# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- New spec --all task to run all tests (by [@kauredo](https://github.com/kauredo))
- Tests for output task (by [@kauredo](https://github.com/kauredo))

### Changed
- Updated gitignore to exclude ruby environment and gem build files
- Updated all specs to use the generated test app folder, rather than the gem root dir ([#21](https://github.com/pacso/aoc_rb/pull/21) by [@pacso](https://github.com/pacso))

### Fixed
- Thor exit_on_failure deprecation warning (by [@kauredo](https://github.com/kauredo))

## [0.2.4]
### Fixed
- Output task fixed (by [@kauredo](https://github.com/kauredo))
- Spec task added to run tests from a given day (by [@kauredo](https://github.com/kauredo))

## [0.2.3]
### Changed
- Update minimum nokogiri version
- Update thor gem

## [0.2.2]
### Fixed
- FileUtils uninitialized constant bug ([#10](https://github.com/pacso/aoc_rb/pull/10))

## [0.2.1]
### Changed
- Allow any number of arguments to be passed to solutions

## [0.2.0]
### Changed
- Improved input handling in puzzle solutions

## [0.1.1]
### Changed
- Switch from Travis to GitHub Actions
- Added Gem version badge
- Update gems and fix specs

## [0.1.0]
### Changed
- Simplified README

### Fixed
- Added require for pathname

## [0.0.0]

Initial release.

[Unreleased]: https://github.com/pacso/aoc_rb/compare/v0.2.4...HEAD
[0.2.4]: https://github.com/pacso/aoc_rb/compare/v0.2.3...v0.2.4
[0.2.3]: https://github.com/pacso/aoc_rb/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/pacso/aoc_rb/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/pacso/aoc_rb/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/pacso/aoc_rb/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/pacso/aoc_rb/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/pacso/aoc_rb/compare/v0.0.0...v0.1.0
[0.0.0]: https://github.com/pacso/aoc_rb/tree/9fc471cb0accb95ddad1aeb138d542056a0034c2
