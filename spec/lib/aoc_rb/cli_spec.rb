# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AocRb::Cli do
  let(:time) { Time.now }
  let(:year) { time.year }
  let(:day) { time.day }
  let(:puzzle_input) {
    <<~EOF
      Some
      collection
      of
      input
      data
    EOF
  }

  describe "fetch_input" do
    before do
      stub_request(:get, "https://adventofcode.com/#{year}/day/#{day}/input").to_return({body: puzzle_input})
      stub_request(:get, "https://adventofcode.com/2018/day/4/input").to_return({body: puzzle_input})
    end

    it "sends a GET request to AOC for today's input" do
      AocRb::Cli.start %w(fetch_input)
      expect(WebMock).to have_requested(:get, "https://adventofcode.com/#{year}/day/#{day}/input")
    end

    it "can override the current date" do
      AocRb::Cli.start %w(fetch_input -y 2018 -d 4)
      expect(WebMock).to have_requested(:get, "https://adventofcode.com/2018/day/4/input")
    end

    it "saves the downloaded input into the correct challenge directory" do
      challenge_dir = File.join(File.dirname(__FILE__), "../../..", "challenges", "2018", "04")
      input_file = File.join(challenge_dir, "input.txt")

      expect { AocRb::Cli.start %w(fetch_input -y 2018 -d 4) }.to change { File.exist?(input_file) }.from(false).to(true)
      expect(File.read(input_file)).to eq puzzle_input
    end
  end
end
