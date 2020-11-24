# frozen_string_literal: true
module AocRb
  class AocApi
    include HTTParty
    base_uri 'adventofcode.com'

    def initialize(year, session)
      @year = year
      @options = {headers: {'Cookie' => "session=#{session}"}}
    end

    def day(day_number)
      self.class.get("/#{@year}/day/#{day_number}/input", @options)
    end
  end
end
