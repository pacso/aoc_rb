# frozen_string_literal: true

module AocRb
  module PuzzleSolution
    extend self

    def submit(level, year, day)
      puzzle   = PuzzleSource.create_puzzle(year, day)
      input    = PuzzleInput.load(year, day)
      solution = level == 1 ? puzzle.part_1(input) : puzzle.part_2(input)

      aoc_api  = AocApi.new(ENV['AOC_COOKIE'])
      response = aoc_api.submit_answer(year, day, level, solution)
      puts response.body

      wrong = /not the right answer/.match?(response.body)

      doc = Nokogiri::HTML(response.body)
      articles = doc.css("article")
      puts articles[0].content

      puts "That's not the right answer" if wrong

      !wrong
    end
  end
end
