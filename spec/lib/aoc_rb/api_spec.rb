# frozen_string_literal: true
require 'spec_helper'

RSpec.describe AocRb::AocApi do
  let(:session_token) { "test_session_token" }
  let(:year) { 2024 }
  let(:level) { 1 }
  let(:answer) { "42" }
  let(:api) { described_class.new(session_token) }

  shared_examples "consistent day path" do |day_input, expected_day|
    let(:expected_headers) { { 'Cookie' => "session=#{session_token}" } }

    it "requests the correct path for puzzle instructions with day #{day_input}" do

      expected_path = "/#{year}/day/#{expected_day}"
      
      allow(api.class).to receive(:get).and_return(double('Response', body: ''))
      

      api.puzzle_instructions(year, day_input)
      
      expect(api.class).to have_received(:get).with(expected_path, hash_including(headers: expected_headers))
    end

    it "requests the correct path for puzzle input with day #{day_input}" do
      expected_path = "/#{year}/day/#{expected_day}/input"

      allow(api.class).to receive(:get).and_return(double('Response', body: ''))

      api.puzzle_input(year, day_input)


      expect(api.class).to have_received(:get).with(expected_path, hash_including(headers: expected_headers))
    end

    it "posts to the correct path for submit_answer with day #{day_input}" do
      expected_path = "/#{year}/day/#{expected_day}/answer"
      expected_body = { level: level.to_s, answer: answer.to_s }

      allow(api.class).to receive(:post).and_return(double('Response', body: ''))

      api.submit_answer(year, day_input, level, answer)


      expect(api.class).to have_received(:post).with(expected_path, hash_including(headers: expected_headers, body: expected_body))
    end

  end


  context "when day is an integer (e.g., 1)" do
    include_examples "consistent day path", 1, 1
  end

  context "when day is a string with leading zero (e.g., '01')" do
    include_examples "consistent day path", "01", 1
  end
end
