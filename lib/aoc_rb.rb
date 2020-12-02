puts "lib/aoc_rb.rb"

Dir[File.join(File.dirname(__FILE__), "aoc_rb", "**", "*.rb")].each { |file| require file }

module AocRb
  class Error < StandardError; end
end
