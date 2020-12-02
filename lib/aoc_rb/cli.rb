# frozen_string_literal: true

# require "aoc_rb/app_loader"
# AocRb::AppLoader.exec_app


lib_files = File.join(File.dirname(__FILE__), "*.rb")
src_files = File.join("challenges", "**", "*.rb")
Dir[lib_files].each do |file|
  if File.exist? file
    require file
  else
    puts "missing file #{file}"
  end
end

Dir[src_files].each do |file|
  if File.exist? file
    require file
  else
    puts "missing file #{file}"
  end
end

module AocRb
  class Cli < Thor
    desc "fetch", "Downloads the input file and problem statement for today, or an optionally specified year / day"
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def fetch(year = options[:year], day = options[:day])
      fetch_input(year, day)
      fetch_instructions(year, day)
    end

    desc "download", "downloads an input file for today, or an optionally specified year & day"
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def fetch_input(year = options[:year], day = options[:day])
      AocRb::PuzzleInput.download(year, day)
    end

    desc "fetch_instructions", "downloads the available instructions for today, or the specified date"
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def fetch_instructions(year = options[:year], day = options[:day])
      AocRb::Puzzle.fetch_instructions(year, day)
    end

    desc "bootstrap", "sets up the boilerplate for a new daily challenge"
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def bootstrap(year = options[:year], day = options[:day])
      AocRb::Puzzle.create_templates(year, day)
    end

    desc "exec", "executes the puzzle for today, or the specified date"
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def exec(year = options[:year], day = options[:day])
      puzzle = AocRb::PuzzleSource.create_puzzle(year, day)
      input = AocRb::PuzzleInput.load(year, day)

      level = Puzzle.instructions_exist?(year, day, :part_2) ? 2 : 1
      puts "#{year} Day #{day}"
      solution = PuzzleSource.run_part("part #{level}") { puzzle.send("part_#{level}", input) }

      puts "Submit solution? #{solution} (y/N)"
      submit = STDIN.gets.chomp.downcase
      puts "We said #{submit}"

      if submit == "y"
        if PuzzleSolution.submit(level, year, day, solution)
          puts "Correct!"

          if level == 1
            puts "Downloading part 2!"
            fetch_instructions(year, day)
          end
        end
      end
    end

    desc "output", "outputs results from your solution for the given day"
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def output(year = options[:year], day = options[:day])
      puzzle = AocRb::PuzzleSource.create_puzzle(year, day)
      input = AocRb::PuzzleInput.load(year, day)

      AocRb::PuzzleSource.run_part('part 1') { puzzle.part_1(input) }
      puts
      AocRb::PuzzleSource.run_part('part 2') { puzzle.part_2(input) }
    end

    desc "prep", "preps everything you need for a new puzzle"
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def prep(year = options[:year], day = options[:day])
      fetch(year, day)
      bootstrap(year, day)
    end
  end
end
