# frozen_string_literal: true
module AocRb
  module PuzzleInput
    extend self

    def load(year, day)
      file_path = puzzle_path(year, day)
      download(year, day) unless File.exists? file_path
      File.read(file_path)
    end

    def create_required_directories(year, day)
      padded_day = day.to_s.rjust(2, "0")
      year_directory = File.join("challenges", year.to_s, padded_day)
      FileUtils.mkdir_p(year_directory) unless Dir.exists?(year_directory)
    end

    def puzzle_path(year, day)
      padded_day = day.to_s.rjust(2, "0")
      File.join("challenges", year.to_s, padded_day, "input.txt")
    end

    def download(year, day)
      aoc_api = AocRb::AocApi.new(year, ENV['AOC_COOKIE'])
      content = aoc_api.day(day)
      save_puzzle(year, day, content)
    end

    def save_puzzle(year, day, content)
      protect_against_early_download(content)
      create_required_directories year, day
      skip_if_exists(puzzle_path(year, day)) do
        File.open(puzzle_path(year, day), "w") { |f| f.write content }
      end
    end

    def skip_if_exists(file)
      unless File.exist? file
        yield
      else
        puts "#{file} already exists, skipping"
      end
    end

    private

    def protect_against_early_download(content)
      if /the link will be enabled on the calendar the instant this puzzle becomes available/.match?(content)
        puts "ERROR: This resource is not available for download yet"
        exit 0
      end
    end
  end
end
