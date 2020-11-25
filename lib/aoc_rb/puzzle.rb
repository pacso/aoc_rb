# frozen_string_literal: true

require "nokogiri"
require "byebug"

module AocRb
  module Puzzle
    extend self

    def fetch_instructions(year, day)
      create_required_directories year, day

      api = AocRb::AocApi.new(ENV['AOC_COOKIE'])
      content = api.puzzle_instructions(year, day)

      parse_and_save_instructions(year, day, content)
    end

    def create_required_directories(year, day)
      padded_day = day.to_s.rjust(2, "0")
      year_directory = File.join("challenges", year.to_s, padded_day)
      FileUtils.mkdir_p(year_directory) unless Dir.exists?(year_directory)
    end

    def parse_and_save_instructions(year, day, content)
      doc = Nokogiri::HTML(content)
      articles = doc.css("article.day-desc")
      articles.each_with_index { |article, index| process_article(year, day, article, index) }
    end

    def process_article(year, day, article, index)
      padded_day = day.to_s.rjust(2, "0")
      part_num = index + 1
      filename = File.join("challenges", year.to_s, padded_day, "part_#{part_num}.md")

      File.open(filename, "w") do |f|
        process_page_content(f, article)
        f.close
      end
    end

    def process_page_content(f, child, indent_level = 0, strip_em = false)
      # byebug
      return unless child.respond_to?(:name)
      case child.name
      when "text"
        f.write child.content.strip.strip.gsub("\n", "\n" + (" " * indent_level))
      when "h2"
        f.write "## "
        process_children f, child.children, indent_level, strip_em
        f.write "\n\n"
      when "p"
        process_children f, child.children, indent_level, strip_em
        f.write "\n\n"
      when "ul"
        process_children f, child.children, indent_level, strip_em
        f.write "\n"
      when "li"
        f.write "* "
        process_children f, child.children, indent_level, strip_em
        f.write "\n"
      when "em"
        f.write "**" unless strip_em
        process_children f, child.children
        f.write "**" unless strip_em
      when "code"
        f.write " " * indent_level
        f.write "``" unless indent_level > 0
        process_children f, child.children, indent_level, true
        f.write "``" unless indent_level > 0
      when "pre"
        process_children f, child.children, 4, strip_em
        f.write "\n\n"
      else
        process_children f, child.children, indent_level, strip_em
        # byebug
      end
    end

    def process_children(f, children, indent_level = 0, strip_em = false)
      children.each do |child|
        process_page_content f, child, indent_level, strip_em
      end
    end
  end
end