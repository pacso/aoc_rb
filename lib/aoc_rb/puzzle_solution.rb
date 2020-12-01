# frozen_string_literal: true

module AocRb
  module PuzzleSolution
    extend self

    def submit(level, year, day, answer = nil)
      if answer.nil?
        puzzle   = PuzzleSource.create_puzzle(year, day)
        input    = PuzzleInput.load(year, day)
        answer = level == 1 ? puzzle.part_1(input) : puzzle.part_2(input)
      end

      aoc_api  = AocApi.new(ENV['AOC_COOKIE'])
      response = aoc_api.submit_answer(year, day, level, answer)
      # puts response.body

      wrong = /not the right answer/.match?(response.body)
      already_complete = /Did you already complete it/.match?(response.body)

      doc = Nokogiri::HTML(response.body)
      articles = doc.css("article")
      puts articles[0].content

      puts "That's not the right answer" if wrong
      puts "You have already completed this challenge" if already_complete

      !wrong && !already_complete
    end
  end
end
