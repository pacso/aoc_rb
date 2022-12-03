require "bundler/setup"

require "httparty"
require 'dotenv/load'
require "thor"

require 'webmock/rspec'
WebMock.disable_net_connect!

lib_path = File.join(File.dirname(__FILE__), "..", "lib", "aoc_rb", "*.rb")
Dir[lib_path].each { |file| require file }

Dir[File.join(File.dirname(__FILE__), "support", "**", "*.rb")].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include SpecMacros

  config.before(:all) { load_test_app }
  config.after(:each) { clean_test_app }
  config.after(:all) { remove_test_app }

  config.after(:each) do
    # FileUtils.rm_rf(File.join(File.dirname(__FILE__), "..", "testing", "challenges"))
    # FileUtils.rm_rf(File.join(File.dirname(__FILE__), "..", "challenges"))
    # FileUtils.rm_rf(File.join(File.dirname(__FILE__), "..", "spec", "2018"))
  end
end
