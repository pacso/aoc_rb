# frozen_string_literal: true
require 'byebug'
module AocRb
  class AocApi
    include HTTParty
    base_uri 'https://adventofcode.com'
    # base_uri 'lvh.me:3000'

    def initialize(session)
      @options = { headers: { 'Cookie' => "session=#{session}" }, follow_redirects: false }
    end

    def puzzle_instructions(year, day)
      self.class.get(puzzle_path(year, day), @options)
    end

    def puzzle_input(year, day)
      self.class.get(input_path(year, day), @options)
    end

    def submit_answer(year, day, level, answer)
      options_with_answer = @options.merge({ body: { level: level.to_s, answer: answer.to_s } })
      self.class.post(answer_path(year, day), options_with_answer)
    end

    private
      def puzzle_path(year, day)
        "/#{year}/day/#{day}"
      end

      def input_path(year, day)
        puzzle_path(year, day) + "/input"
      end

      def answer_path(year, day)
        puzzle_path(year, day) + "/answer"
      end
  end
end
