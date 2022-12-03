# frozen_string_literal: true

module SpecMacros
  def within_test_app
    Dir.chdir("testing") do
      yield
    end
  end

  def remove_test_dir(*path)
    FileUtils.rm_rf(File.join(Dir.pwd, "testing", *path))
  end

  def test_file_path(*path)
    File.join(Dir.pwd, "testing", *path)
  end

  def load_test_app
    system %(aoc new testing)
    testing_path = File.join(Dir.pwd, "testing", "**", "*.rb")
    Dir[testing_path].each { |file| require file }
  end

  def clean_test_app
    challenge_dirs = Dir[File.join(Dir.pwd, "testing", "challenges", "**")].select { |path| path !~ /shared$/ }
    challenge_dirs.each { |path| FileUtils.rm_rf path }
  end

  def remove_test_app
    FileUtils.rm_rf(File.join(Dir.pwd, "testing"))
  end
end
