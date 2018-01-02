# frozen_string_literal: true

require "simplecov"
SimpleCov.start
require "codecov"
SimpleCov.formatter = SimpleCov::Formatter::Codecov

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "mocha/mini_test"
require "webmock/minitest"
require "database_cleaner"
require "support/action_mailer_helpers"

class Module
  include Minitest::Spec::DSL
end

DatabaseCleaner.strategy = :transaction

Mocha::Configuration.prevent(:stubbing_non_existent_method)

module Minitest
  class Spec
    before :each do
      DatabaseCleaner.start
      ::Rails.cache.clear
    end

    after :each do
      DatabaseCleaner.clean
    end
  end

  class Test
    include ActiveSupport::Testing::Assertions

    def em_then_stop
      stub_replace(EM, :promise_defer) do |&block|
        EMPromise.resolve(nil).then { block.call }
      end

      EM.run do
        yield.then { EM.stop }.catch do |e|
          failures << UnexpectedError.new(e)
          EM.stop
        end
      end

      undo_stub_replace(EM, :promise_defer)
    end

    def em_hang_then_stop
      Thread.new { EM.run }
      loop until EM.reactor_running?
      yield
      EM.stop
    end

    def stub_replace(klass, method_name, &method_implementation)
      klass.singleton_class.send(:alias_method, "#{method_name}_mock_backup", method_name)
      klass.define_singleton_method(method_name, method_implementation)
    end

    def undo_stub_replace(klass, method_name)
      klass.singleton_class.send(:alias_method, method_name, "#{method_name}_mock_backup")
    end

    def assert_promise_fails_with(klass)
      err = nil
      em_then_stop do
        yield.then {
          assert false, "The promise provided did not fail"
        }.catch do |f|
          err = f
          assert_kind_of klass, f
        end
      end
      err
    end
  end
end

def with_versioning
  was_enabled = PaperTrail.enabled?
  was_enabled_for_controller = PaperTrail.enabled_for_controller?
  PaperTrail.enabled = true
  PaperTrail.enabled_for_controller = true
  begin
    yield
  ensure
    PaperTrail.enabled = was_enabled
    PaperTrail.enabled_for_controller = was_enabled_for_controller
  end
end

# sql_queries and assert_sql_queries from here: https://stackoverflow.com/a/43810063
def sql_queries(&block)
  queries = []
  counter = lambda do |*, payload|
    queries << payload.fetch(:sql) unless ["CACHE", "SCHEMA"].include?(payload.fetch(:name))
  end

  ActiveSupport::Notifications.subscribed(counter, "sql.active_record", &block)

  queries
end

def assert_sql_queries(expected, &block)
  queries = sql_queries(&block)
  queries.count.must_equal(
    expected,
    "Expected #{expected} queries, but found #{queries.count}:\n#{queries.join("\n")}"
  )
end

module Mocha
  class Mock
    def as_json
      {}
    end
  end
end

Timecop.safe_mode = true

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include ActionMailerHelpers
  end
end
