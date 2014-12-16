ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  reporter_options = { color: true, slow_count: 5 }

  Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
end
