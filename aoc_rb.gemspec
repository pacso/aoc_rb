require_relative 'lib/aoc_rb/version'

Gem::Specification.new do |spec|
  spec.name          = "aoc_rb"
  spec.version       = AocRb::VERSION
  spec.authors       = ["Jon Pascoe"]
  spec.email         = ["jon.pascoe@me.com"]

  spec.summary       = %q{A Ruby toolkit for Advent of Code}
  spec.description   = %q{Tools for creating a new project for your Advent of Code solutions, built using Ruby.}
  spec.homepage      = "https://github.com/pacso/aoc_rb"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pacso/aoc_rb"
  spec.metadata["changelog_uri"] = "https://github.com/pacso/aoc_rb/blob/main/CHANGELOG"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dotenv", "~> 2.7.6"
  spec.add_dependency "httparty", "~> 0.20.0"
  spec.add_dependency "thor", "~> 1.1.0"
  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "nokogiri", "~> 1.12.5"

  spec.add_development_dependency "webmock", "~> 3.14.0"
end
