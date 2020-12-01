# frozen_string_literal: true

require "nokogiri"
require "erb"

module AocRb
  module Puzzle
    extend self

    def create_templates(year, day)
      create_source(year, day)
      create_spec(year, day)
    end

    def padded(day)
      day.to_s.rjust(2, "0")
    end

    def create_source(year, day)
      source_dir = File.join("challenges", year.to_s, padded(day))
      source_path = File.join(source_dir, "solution.rb")
      FileUtils.mkdir_p(source_dir) unless Dir.exist?(source_dir)
      PuzzleInput.skip_if_exists(source_path) do
        template = File.read(File.join(File.dirname(__FILE__), "../../templates", "solution.rb.erb"))
        @year = year.to_s
        @day = padded(day)
        File.open(source_path, "w") do |f|
          f.write ERB.new(template).result(binding)
        end
      end
    end

    def create_spec(year, day)
      spec_dir = File.join("spec", year.to_s, padded(day))
      spec_path = File.join(spec_dir, "solution_spec.rb")
      FileUtils.mkdir_p(spec_dir) unless Dir.exist?(spec_dir)
      PuzzleInput.skip_if_exists(spec_path) do
        template = File.read(File.join(File.dirname(__FILE__), "../../templates", "solution_spec.rb.erb"))
        @year = year.to_s
        @day = padded(day)
        File.open(spec_path, "w") do |f|
          f.write ERB.new(template).result(binding)
        end
      end
    end

    def fetch_instructions(year, day)
      create_required_directories year, day

      api = AocRb::AocApi.new(ENV['AOC_COOKIE'])
      content = api.puzzle_instructions(year, day)

      parse_and_save_instructions(year, day, content.body)
    end

    def create_puzzle(year, day)

    end

    def instructions_exist?(year, day, part)
      filename = File.join("challenges", year.to_s, padded(day), "#{part}.md")
      File.exist?(filename)
    end

    def create_required_directories(year, day)
      year_directory = File.join("challenges", year.to_s, padded(day))
      FileUtils.mkdir_p(year_directory) unless Dir.exist?(year_directory)
    end

    def parse_and_save_instructions(year, day, content)
      doc = Nokogiri::HTML(content)
      articles = doc.css("article.day-desc")
      articles.each_with_index { |article, index| process_article(year, day, article, index) }
    end

    def process_article(year, day, article, index)
      part_num = index + 1
      filename = File.join("challenges", year.to_s, padded(day), "part_#{part_num}.md")

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
        f.write child.content.chomp.gsub("\n", "\n" + (" " * indent_level))
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