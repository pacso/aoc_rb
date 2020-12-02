# frozen_string_literal: true

module AocRb
  module AppLoader
    extend self

    RUBY = Gem.ruby
    EXECUTABLES = ["bin/aoc", "script/aoc"]

    def exec_app
      original_cwd = Dir.pwd

      loop do
        if exe = find_executable
          contents = File.read(exe)

          if /THIS IS THE BIN FILE/.match?(contents)
            exec RUBY, exe, *ARGV
            break
          end
        end

        Dir.chdir(original_cwd) && return if Pathname.new(Dir.pwd).root?

        Dir.chdir("..")
      end
    end

    def find_executable
      EXECUTABLES.find { |exe| File.file?(exe) }
    end
  end
end
