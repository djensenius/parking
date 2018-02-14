# frozen_string_literal: true

require "test_helper"

class UserTest < Minitest::Test
  describe User do
    # let(:user) { User.new }

    it "should respond to create with omniauth" do
      assert_respond_to(User, :from_omniauth)
    end

    # it "must be valid" do
    #  value(user).must_be :valid?
    # end
  end
end
