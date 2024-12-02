require "httparty"
require 'dotenv/load'
require "fileutils"
require "thor"

require 'aoc_rb/aoc_api'
require 'aoc_rb/puzzle'
require 'aoc_rb/puzzle_input'
require 'aoc_rb/puzzle_solution'
require 'aoc_rb/puzzle_source'

shared_files = File.join(Dir.getwd, "challenges", "shared", "**", "*.rb")
Dir[shared_files].each do |file|
  if File.exist? file
    require file
  else
    puts "missing file #{file}"
  end
end

src_files = File.join(Dir.getwd, "challenges", "20**", "**", "*.rb")
Dir[src_files].each do |file|
  if File.exist? file
    require file
  else
    puts "missing file #{file}"
  end
end

module AocRb
  class App < Thor
    def self.exit_on_failure?
      false
    end

    desc "fetch", "Downloads the input file and problem statement for today, or an optionally specified year / day", hide: true
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def fetch(year = options[:year], day = options[:day])
      fetch_input(year, day)
      fetch_instructions(year, day)
    end

    desc "download", "downloads an input file for today, or an optionally specified year & day", hide: true
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def fetch_input(year = options[:year], day = options[:day])
      AocRb::PuzzleInput.download(year, day)
    end

    desc "fetch_instructions", "downloads the available instructions for today, or the specified date", hide: true
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def fetch_instructions(year = options[:year], day = options[:day])
      AocRb::Puzzle.fetch_instructions(year, day)
    end

    desc "bootstrap", "sets up the boilerplate for a new daily challenge", hide: true
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def bootstrap(year = options[:year], day = options[:day])
      AocRb::Puzzle.create_templates(year, day)
    end

    desc "exec", "executes and optionally submits the puzzle for today, or the specified date"
    long_desc <<~LONGDESC
      `exec` will check if you have instructions for PART 2 of today's puzzle. 
      If you don't it will execute part 1, and offer to submit it for you. If 
      you do have instructions for part 2, it will execute part 2 and offer to 
      submit that.

      In the event that you've recently submitted an incorrect answer and are 
      being throttled, it will detect the remaining time you need to wait, and
      automatically submit your solution 1s after that delay.

      You can optionally specify another day/year to exec if you're not working on 
      today's puzzle.
    LONGDESC
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day

    def exec(year = options[:year], day = options[:day])
      input = AocRb::PuzzleInput.load(year, day)
      puzzle = AocRb::PuzzleSource.create_puzzle(year, day, input)

      level = Puzzle.instructions_exist?(year, day, :part_2) ? 2 : 1
      puts "#{year} Day #{day}"
      solution = PuzzleSource.run_part("part #{level}") { puzzle.send("part_#{level}") }

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
      input = AocRb::PuzzleInput.load(year, day)
      puzzle = AocRb::PuzzleSource.create_puzzle(year, day, input)

      AocRb::PuzzleSource.run_part('part 1') { puzzle.part_1 }
      puts
      AocRb::PuzzleSource.run_part('part 2') { puzzle.part_2 }
    end

    desc "spec", "runs tests for today, or the specified date"
    method_option :year, aliases: "-y", type: :numeric, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, default: Time.now.day
    method_option :all, :type => :boolean, :aliases => "--all"

    def spec(year = options[:year], day = options[:day])
      if options[:all]
        Kernel.exec( "bundle exec rspec" )
      else
        spec_dir = File.join("spec", year.to_s, AocRb::Puzzle.padded(day))
        Kernel.exec( "bundle exec rspec #{spec_dir}" )
      end
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
