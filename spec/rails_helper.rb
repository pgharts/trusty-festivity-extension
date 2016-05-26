# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'database_cleaner'
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, timeout: 60)
end

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation, {except: %w[config]}

config.include FactoryGirl::Syntax::Methods

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::TRUSTY_CMS_ROOT}/spec/fixtures"

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    TrustyCms::Config.initialize_cache

    configs = [
        ['admin.title', 'TrustyCMS'],
        ['admin.subtitle', 'Publishing for Small Teams'],
        ['defaults.page.parts', 'body, extended'],
        ['defaults.page.status', 'Draft'],
        ['defaults.page.filter', nil],
        ['defaults.page.fields', 'Keywords, Description'],
        ['defaults.snippet.filter', nil],
        ['session_timeout', '1209600'], # 2.weeks.to_s ????
        ['default_locale', 'en'],
    ]
    configs.each do |key, value|
      c = TrustyCms::Config.find_or_initialize_by(key: key)
      c.value = value
      c.save
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
