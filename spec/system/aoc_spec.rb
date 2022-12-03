# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "aoc" do
  after do
    FileUtils.rm_rf(File.join(Dir.pwd, "dummy"))
  end

  it "can create a new project" do
    expect { system %(aoc new dummy) }
      .to change { File.exist? "dummy" }
            .from(false).to(true)
  end
end
