# frozen_string_literal: true

module AocRb
  module PuzzleSolution
    extend self

    def submit(level, year, day, answer = nil, allow_waiting = true)
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
      waiting_regex = /You have (\d*m* *\d+s) left to wait/
      waiting = waiting_regex.match?(response.body)

      doc = Nokogiri::HTML(response.body)
      articles = doc.css("article")
      puts articles[0].content

      puts "That's not the right answer" if wrong
      puts "You have already completed this challenge" if already_complete
      if waiting && allow_waiting
        delay = 1
        time = waiting_regex.match(response.body)[1]
        time_parts = time.split(" ")
        time_parts.each do |part|
          if part.match?(/m/)
            delay += part.match(/(\d+)m/)[1].to_i * 60
          elsif part.match?(/s/)
            delay += part.match(/(\d+)s/)[1].to_i
          end
        end

        puts "WAITING for #{delay} seconds ..."
        sleep delay
        return submit(level, year, day, answer, false)
      end

      !wrong && !already_complete && !waiting
    end
  end
end
