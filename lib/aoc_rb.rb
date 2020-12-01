require "httparty"
require 'dotenv/load'
require "thor"

Dir[File.join(File.dirname(__FILE__), "aoc_rb", "**", "*.rb")].each { |file| require file }

module AocRb
  class Error < StandardError; end
  # Your code goes here...
end

AocRb::Cli.start
