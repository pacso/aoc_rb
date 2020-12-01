# frozen_string_literal: true
require "benchmark"

module AocRb
  module PuzzleSource
    extend self

    def create_puzzle(year, day)
      padded_day = Puzzle.padded(day)
      begin
        Module.const_get("Year#{year}").const_get("Day#{padded_day}").new
      rescue NameError
        puts "There is no solution for this puzzle"
      end
    end

    def run_part(part_name)
      has_result = false
      t = Benchmark.realtime do
        solution = yield
        if !solution.nil?
          puts "Result for #{part_name}:"
          puts solution
          has_result = true
        else
          puts "no result for #{part_name}"
        end
      end
      puts "(obtained in #{t} seconds)" if has_result
    end
  end
end