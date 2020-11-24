# frozen_string_literal: true

# require "aoc_rb/app_loader"
# AocRb::AppLoader.exec_app

require "httparty"
require 'dotenv/load'
require "thor"
require "aoc_rb/puzzle_input"
require "aoc_rb/aoc_api"

module AocRb
  class Cli < Thor
    desc "get", "Downloads the input file and problem statement for today, or an optionally specified year / day"
    method_option :year, aliases: "-y", type: :numeric, required: false, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, required: false, default: Time.now.day

    def get(year = options[:year], day = options[:day])
      download(year, day)
    end

    desc "download", "downloads an input file for today, or an optionally specified year & day"
    method_option :year, aliases: "-y", type: :numeric, required: false, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, required: false, default: Time.now.day

    def download(year = options[:year], day = options[:day])
      AocRb::PuzzleInput.download(year, day)
    end

    desc "bootstrap", "sets up the boilerplate for a new daily challenge"
    method_option :year, aliases: "-y", type: :numeric, required: false, default: Time.now.year
    method_option :day, aliases: "-d", type: :numeric, required: false, default: Time.now.day

    def bootstrap(year = options[:year], day = options[:day])
      puts "Set up boilerplate for #{year}, Day #{day}"
    end
  end
end

AocRb::Cli.start
