# AocRb

[![Gem Version](https://badge.fury.io/rb/aoc_rb.svg)](https://badge.fury.io/rb/aoc_rb)
[![Tests](https://github.com/pacso/aoc_rb/actions/workflows/tests.yml/badge.svg)](https://github.com/pacso/aoc_rb/actions/workflows/tests.yml)

This gem provides a simple way to create a project for solving [Advent of Code](https://adventofcode.com) puzzles.

It also provides some handy tools to automate your interactions with the Advent of Code website.

If you want more help with your puzzles (use with care ... it'll take the fun out of doing it yourself) then take a look at [aoc_rb_helpers](https://github.com/pacso/aoc_rb_helpers).

## Getting Started

First of all, install the gem:

    $ gem install aoc_rb

Next, generate your Advent of Code project:

    $ aoc new my-project-name
    
This will generate a new project with the given name. After this you should be ready to go!

    $ cd my-project-name
    $ aoc
    
Before running any commands, you must set up your `AOC_COOKIE` environment variable:

    $ cp .env-template .env

You'll need to log in to the [Advent of Code](https://adventofcode.com) website and then grab a copy of your session key from your cookies.
In Chrome you can do this by opening the `Developer Tools` window (`⌥ ⌘ I` on Mac) when browsing the Advent of Code website. Within the `Application` tab, expand `Cookies` under `Storage` in the side menu and select `https://adventofcode.com`. This will then show you all of the cookies set by the website. You need to select the `session` cookie and copy the value. 

Now edit the new `.env` file, so that it looks like the following, replacing `ABCDE12345` with the session key you just copied:

    AOC_COOKIE=ABCDE12345

You're now able to run all the `aoc` commands provided by this gem.
    
You'll see you have a few options when running the `aoc` command within your project.

`prep` will set everything up for a new daily puzzle. It defaults to the puzzle for today, but you can work with older puzzles by passing the year and day: 

    $ aoc prep 2017 12

This will generate a `challenges/2017/12` folder with an `input.txt` file (your puzzle input), a `part_1.md` file with the instructions for part 1, and a `solution.rb` file for you to use when implementing your solution.

In `spec/2017/12` there will be a `solution_spec.rb` which you can use to write tests for your solution. It's a good idea to use the examples provided in the `part_1.md` to test your solution!

When you've got a working solution you can see what it generates by running:

    $ aoc exec

Which runs todays solution. For previous days, just like with `prep`, you can provide a date:

    $ aoc exec 2017 12
    
If you're happy with the output, you can respond to the prompt and `aoc` will submit your answer for you. If you're successful with part 1, it will automatically download the instructions for part 2 for you.

Rinse & repeat!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pacso/aoc_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pacso/aoc_rb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AocRb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/aoc_rb/blob/master/CODE_OF_CONDUCT.md).
