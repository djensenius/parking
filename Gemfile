# frozen_string_literal: true

source "https://rubygems.org"
ruby "2.6.2"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "activerecord-session_store", github: "rails/activerecord-session_store"
gem "activeresource"
gem "bcrypt", "~> 3.1.12"
gem "bootstrap", ">= 4.3.1"
gem "bugsnag"
gem "dotenv-rails"
gem "email_validator"
gem "jquery-rails"
gem "local_time"
gem "materialize-sass", "~> 1.0.0"
gem "sprockets", "~> 4.0beta8"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.2.1"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1.3"
# Use Puma as the app server
gem "puma", "~> 3.12.6"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0.7"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 4.1.20"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5.2"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.8.0"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2.2"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 3.14.0"
  gem "database_cleaner"
  gem "minitest-profile"
  gem "minitest-rails"
  gem "mocha"
  gem "pronto"
  gem "pronto-brakeman"
  gem "pronto-eslint_npm"
  gem "pronto-flay"
  gem "pronto-rubocop"
  gem "pronto-stylelint"
  gem "pry-byebug"
  gem "rails-controller-testing"
  gem "rubocop"
  gem "selenium-webdriver"
  gem "timecop"
  gem "webmock"
end

group :development do
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 3.7.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.1"
end

group :test do
  gem "codecov", require: false
  gem "simplecov", require: false
end

group :production do
  gem "dalli"
  gem "snappy"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
