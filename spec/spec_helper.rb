require "bundler/setup"

require "httparty"
require 'dotenv/load'
require "thor"

require 'webmock/rspec'
WebMock.disable_net_connect!

lib_path = File.join(File.dirname(__FILE__), "..", "lib", "aoc_rb", "*.rb")
Dir[lib_path].each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    system %(aoc new testing)
    testing_path = File.join(File.dirname(__FILE__), "..", "testing", "**", "*.rb")
    Dir[testing_path].each { |file| require file }
  end

  config.after(:all) do
    FileUtils.rm_rf(File.join(File.dirname(__FILE__), "..", "testing"))
  end

  config.after(:each) do
    FileUtils.rm_rf(File.join(File.dirname(__FILE__), "..", "challenges"))
    FileUtils.rm_rf(File.join(File.dirname(__FILE__), "..", "dummy"))
    FileUtils.rm_rf(File.join(File.dirname(__FILE__), "..", "spec", "2018"))
  end
end
