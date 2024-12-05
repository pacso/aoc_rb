# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "aoc" do
  after do
    FileUtils.rm_rf(File.join(Dir.pwd, "dummy"))
  end

  it "can create a new project" do
    expect { `aoc new dummy` }.to change { File.exist? "dummy" }.from(false).to(true)
  end

  it "can output the installed version" do
    expect(`aoc version`).to eq "AocRb version #{AocRb::VERSION}\n"
  end
end
