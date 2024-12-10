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

    describe "#puzzle_instructions" do
      let(:expected_path) { "/2024/day/#{expected_day}" }

      before do
        allow(api.class).to receive(:get).and_return(double('Response', body: ''))
      end

      it "sends the request to the correct uri" do
        api.puzzle_instructions(year, day_input)
        expect(api.class).to have_received(:get).with(expected_path, hash_including(headers: expected_headers))
      end
    end

    describe "#puzzle_input" do
      let(:expected_path) { "/2024/day/#{expected_day}/input" }

      before do
        allow(api.class).to receive(:get).and_return(double('Response', body: ''))
      end

      it "sends the request to the correct uri" do
        api.puzzle_input(year, day_input)
        expect(api.class).to have_received(:get).with(expected_path, hash_including(headers: expected_headers))
      end
    end

    describe "#submit_answer" do
      let(:expected_path) { "/2024/day/#{expected_day}/answer" }
      let(:expected_body) { { level: level.to_s, answer: answer.to_s } }

      before do
        allow(api.class).to receive(:post).and_return(double('Response', body: ''))
      end

      it "sends the request to the correct uri" do
        api.submit_answer(year, day_input, level, answer)
        expect(api.class).to have_received(:post).with(expected_path, hash_including(headers: expected_headers, body: expected_body))
      end
    end
  end

  context "when day is an integer" do
    include_examples "consistent day path", 1, 1
    include_examples "consistent day path", 17, 17
  end

  context "when day is a two-character string" do
    include_examples "consistent day path", "01", 1
    include_examples "consistent day path", "22", 22
  end

  context "when day is a single character string" do
    include_examples "consistent day path", "8", 8
  end
end
