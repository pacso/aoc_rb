# frozen_string_literal: true
require "benchmark"

module AocRb
  module PuzzleSource
    extend self

    def create_puzzle(year, day, input = nil)
      padded_day = Puzzle.padded(day)
      begin
        Module.const_get("Year#{year}").const_get("Day#{padded_day}").new(input)
      rescue NameError
        puts "There is no solution for this puzzle"
      end
    end

    def run_part(part_name)
      solution = nil
      t = Benchmark.realtime do
        solution = yield
        if !solution.nil?
          puts "Result for #{part_name}:"
          puts solution
        else
          puts "no result for #{part_name}"
        end
      end
      puts "(obtained in #{t} seconds)" unless solution.nil?

      solution
    end
  end
end