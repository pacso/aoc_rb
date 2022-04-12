# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "aoc" do
  it "can create a new project" do
    expect { system %(aoc new dummy) }
      .to change { File.exist? "dummy" }
            .from(false).to(true)
  end
end
