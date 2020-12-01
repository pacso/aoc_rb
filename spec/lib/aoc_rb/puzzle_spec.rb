# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AocRb::Puzzle do
  describe "#padded(day)" do
    it "returns 01 for 1" do
      expect(AocRb::Puzzle.padded(1)).to eq "01"
    end

    it "returns 09 for 9" do
      expect(AocRb::Puzzle.padded(9)).to eq "09"
    end

    it "returns 12 for 12" do
      expect(AocRb::Puzzle.padded(12)).to eq "12"
    end
  end
end
