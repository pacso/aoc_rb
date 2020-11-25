# frozen_string_literal: true
module AocRb
  class AocApi
    include HTTParty
    base_uri 'adventofcode.com'

    def initialize(session)
      @options = {headers: {'Cookie' => "session=#{session}"}}
    end

    def puzzle_instructions(year, day)
      self.class.get("/#{year}/day/#{day}", @options)
    end

    def puzzle_input(year, day)
      self.class.get("/#{year}/day/#{day}/input", @options)
    end
  end
end
