# frozen_string_literal: true

require "bundler/setup"
require "whatsapp"
require "webmock/rspec"
require "pry-byebug"
require "simplecov"
require "simplecov-console"
Dir["./spec/support/**/*.rb"].each { |file| require file }

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.filter_run_when_matching :focus

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

SimpleCov.formatter = SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start
