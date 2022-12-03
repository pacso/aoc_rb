# frozen_string_literal: true

require "fileutils"
require "aoc_rb/app_loader"
AocRb::AppLoader.exec_app

require "thor"

module AocRb
  class Cli < Thor
    def self.exit_on_failure?
      false
    end

    desc "new NAME", "Creates a new AoC project with the given name"

    def new(name)
      project_dir = File.join(Dir.getwd, name)
      if File.exist?(project_dir)
        puts "ERROR: #{project_dir} already exists!"
        exit -1
      end

      bin_dir = File.join(project_dir, "bin")
      bin_path = File.join(bin_dir, "aoc")
      bin_template = File.join(File.dirname(__FILE__), "../../templates/bin/aoc")
      FileUtils.mkdir_p bin_dir
      File.open(bin_path, "w") { |f| f.write(File.read(bin_template)) }

      shared_dir = File.join(project_dir, "challenges", "shared")
      solution_path = File.join(shared_dir, "solution.rb")
      solution_template = File.join(File.dirname(__FILE__), "../../templates/solution_base.rb")
      FileUtils.mkdir_p shared_dir
      File.open(solution_path, "w") { |f| f.write(File.read(solution_template)) }

      spec_dir = File.join(project_dir, "spec")
      spec_helper_path = File.join(spec_dir, "spec_helper.rb")
      spec_helper_template = File.join(File.dirname(__FILE__), "../../templates/spec/spec_helper.rb")
      FileUtils.mkdir_p spec_dir
      File.open(spec_helper_path, "w") { |f| f.write(File.read(spec_helper_template)) }

      env_template_path = File.join(project_dir, ".env-template")
      env_template = File.join(File.dirname(__FILE__), "../../templates/.env-template")
      File.open(env_template_path, "w") { |f| f.write(File.read(env_template)) }

      gemfile_dst = File.join(project_dir, "Gemfile")
      gemfile_src = File.join(File.dirname(__FILE__), "../../templates/Gemfile")
      File.open(gemfile_dst, "w") { |f| f.write(File.read(gemfile_src))}
    end
  end
end

AocRb::Cli.start
