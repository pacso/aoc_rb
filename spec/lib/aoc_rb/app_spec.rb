# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AocRb::App do
  let(:year) { Time.now.year }
  let(:day) { Time.now.day }

  describe "fetch_input" do
    let(:puzzle_input) {
      <<~EOF
        Some
        collection
        of
        input
        data
      EOF
    }

    before do
      stub_request(:get, "https://adventofcode.com/#{year}/day/#{day}/input").to_return({ body: puzzle_input })
      stub_request(:get, "https://adventofcode.com/2018/day/4/input").to_return({ body: puzzle_input })
    end

    it "sends a GET request to AOC for today's input" do
      within_test_app do
        AocRb::App.start %w(fetch_input)
        expect(WebMock).to have_requested(:get, "https://adventofcode.com/#{year}/day/#{day}/input")
      end
    end

    it "can override the current date" do
      within_test_app do
        AocRb::App.start %w(fetch_input -y 2018 -d 4)
        expect(WebMock).to have_requested(:get, "https://adventofcode.com/2018/day/4/input")
      end
    end

    it "saves the downloaded input into the correct challenge directory" do
      input_file = test_file_path("challenges", "2018", "04", "input.txt")

      within_test_app do
        expect { AocRb::App.start %w(fetch_input -y 2018 -d 4) }.to change { File.exist?(input_file) }.from(false).to(true)
        expect(File.read(input_file)).to eq puzzle_input
      end
    end
  end

  describe "fetch_instructions" do
    let(:response_part_1) {
      <<~EOF
        <!DOCTYPE html>
        <html lang="en-us">
        <head>
        <meta charset="utf-8"/>
        <title>Day 2 - Advent of Code 2018</title>
        <!--[if lt IE 9]><script src="/static/html5.js"></script><![endif]-->
        <link href='//fonts.googleapis.com/css?family=Source+Code+Pro:300&subset=latin,latin-ext' rel='stylesheet' type='text/css'/>
        <link rel="stylesheet" type="text/css" href="/static/style.css?25"/>
        <link rel="stylesheet alternate" type="text/css" href="/static/highcontrast.css?0" title="High Contrast"/>
        <link rel="shortcut icon" href="/favicon.png"/>
        </head><!--




        Oh, hello!  Funny seeing you here.

        I appreciate your enthusiasm, but you aren't going to find much down here.
        There certainly aren't clues to any of the puzzles.  The best surprises don't
        even appear in the source until you unlock them for real.

        Please be careful with automated requests; I'm not a massive company, and I can
        only take so much traffic.  Please be considerate so that everyone gets to play.

        If you're curious about how Advent of Code works, it's running on some custom
        Perl code. Other than a few integrations (auth, analytics, ads, social media),
        I built the whole thing myself, including the design, animations, prose, and
        all of the puzzles.

        The puzzles are most of the work; preparing a new calendar and a new set of
        puzzles each year takes all of my free time for 4-5 months. A lot of effort
        went into building this thing - I hope you're enjoying playing it as much as I
        enjoyed making it for you!

        If you'd like to hang out, I'm @ericwastl on Twitter.

        - Eric Wastl


















































        -->
        <body>
        <header><div><h1 class="title-global"><a href="/">Advent of Code</a></h1><nav><ul><li><a href="/2018/about">[About]</a></li><li><a href="/2018/events">[Events]</a></li><li><a href="https://teespring.com/adventofcode-2019" target="_blank">[Shop]</a></li><li><a href="/2018/settings">[Settings]</a></li><li><a href="/2018/auth/logout">[Log Out]</a></li></ul></nav><div class="user">Jon Pascoe <span class="star-count">2*</span></div></div><div><h1 class="title-event">&nbsp;&nbsp;<span class="title-event-wrap">{:year </span><a href="/2018">2018</a><span class="title-event-wrap">}</span></h1><nav><ul><li><a href="/2018">[Calendar]</a></li><li><a href="/2018/support">[AoC++]</a></li><li><a href="/2018/sponsors">[Sponsors]</a></li><li><a href="/2018/leaderboard">[Leaderboard]</a></li><li><a href="/2018/stats">[Stats]</a></li></ul></nav></div></header>

        <div id="sidebar">
        <div id="sponsor"><div class="quiet">Our <a href="/2018/sponsors">sponsors</a> help make Advent of Code possible:</div><div class="sponsor"><a href="https://www.honeypot.io/" target="_blank" onclick="if(ga)ga('send','event','sponsor','sidebar',this.href);" rel="noopener">Honeypot.io</a> - Europe&apos;s Tech Job Platform where companies apply to you with salary and tech stack upfront!</div></div>
        </div><!--/sidebar-->

        <main>
        <script>window.addEventListener('click', function(e,s,r){if(e.target.nodeName==='CODE'&&e.detail===3){s=window.getSelection();s.removeAllRanges();r=document.createRange();r.selectNodeContents(e.target);s.addRange(r);}});</script>
        <article class="day-desc"><h2>--- Day 2: Inventory Management System ---</h2><p>You stop falling through time, catch your breath, and check the screen on the device. "Destination reached. Current Year: 1518. Current Location: North Pole Utility Closet 83N10." You made it! Now, to find those anomalies.</p>
        <p>Outside the utility closet, you hear footsteps and a voice. "...I'm not sure either. But now that <span title="This is, in fact, roughly when chimneys became common in houses.">so many people have chimneys</span>, maybe he could sneak in that way?" Another voice responds, "Actually, we've been working on a new kind of <em>suit</em> that would let him fit through tight spaces like that. But, I heard that a few days ago, they lost the prototype fabric, the design plans, everything! Nobody on the team can even seem to remember important details of the project!"</p>
        <p>"Wouldn't they have had enough fabric to fill several boxes in the warehouse? They'd be stored together, so the box IDs should be similar. Too bad it would take forever to search the warehouse for <em>two similar box IDs</em>..." They walk too far away to hear any more.</p>
        <p>Late at night, you sneak to the warehouse - who knows what kinds of paradoxes you could cause if you were discovered - and use your fancy wrist device to quickly scan every box and produce a list of the likely candidates (your puzzle input).</p>
        <p>To make sure you didn't miss any, you scan the likely candidate boxes again, counting the number that have an ID containing <em>exactly two of any letter</em> and then separately counting those with <em>exactly three of any letter</em>. You can multiply those two counts together to get a rudimentary <a href="https://en.wikipedia.org/wiki/Checksum">checksum</a> and compare it to what your device predicts.</p>
        <p>For example, if you see the following box IDs:</p>
        <ul>
        <li><code>abcdef</code> contains no letters that appear exactly two or three times.</li>
        <li><code>bababc</code> contains two <code>a</code> and three <code>b</code>, so it counts for both.</li>
        <li><code>abbcde</code> contains two <code>b</code>, but no letter appears exactly three times.</li>
        <li><code>abcccd</code> contains three <code>c</code>, but no letter appears exactly two times.</li>
        <li><code>aabcdd</code> contains two <code>a</code> and two <code>d</code>, but it only counts once.</li>
        <li><code>abcdee</code> contains two <code>e</code>.</li>
        <li><code>ababab</code> contains three <code>a</code> and three <code>b</code>, but it only counts once.</li>
        </ul>
        <p>Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of <code>4 * 3 = 12</code>.</p>
        <p><em>What is the checksum</em> for your list of box IDs?</p>
        </article>
        <p>To begin, <a href="2/input" target="_blank">get your puzzle input</a>.</p>
        <form method="post" action="2/answer"><input type="hidden" name="level" value="1"/><p>Answer: <input type="text" name="answer" autocomplete="off"/> <input type="submit" value="[Submit]"/></p></form>
        <p>You can also <span class="share">[Share<span class="share-content">on
          <a href="https://twitter.com/intent/tweet?text=%22Inventory+Management+System%22+%2D+Day+2+%2D+Advent+of+Code+2018&amp;url=https%3A%2F%2Fadventofcode%2Ecom%2F2018%2Fday%2F2&amp;related=ericwastl&amp;hashtags=AdventOfCode" target="_blank">Twitter</a>
          <a href="javascript:void(0);" onclick="var mastodon_instance=prompt('Mastodon Instance / Server Name?'); if(typeof mastodon_instance==='string' && mastodon_instance.length){this.href='https://'+mastodon_instance+'/share?text=%22Inventory+Management+System%22+%2D+Day+2+%2D+Advent+of+Code+2018+%23AdventOfCode+https%3A%2F%2Fadventofcode%2Ecom%2F2018%2Fday%2F2'}else{return false;}" target="_blank">Mastodon</a
        ></span>]</span> this puzzle.</p>
        </main>

        <!-- ga -->
        <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-69522494-1', 'auto');
        ga('set', 'anonymizeIp', true);
        ga('send', 'pageview');
        </script>
        <!-- /ga -->
        </body>
        </html>
      EOF
    }
    let(:response_part_2) {
      <<~EOF
        <!DOCTYPE html>
        <html lang="en-us">
        <head>
        <meta charset="utf-8"/>
        <title>Day 1 - Advent of Code 2018</title>
        <!--[if lt IE 9]><script src="/static/html5.js"></script><![endif]-->
        <link href='//fonts.googleapis.com/css?family=Source+Code+Pro:300&subset=latin,latin-ext' rel='stylesheet' type='text/css'/>
        <link rel="stylesheet" type="text/css" href="/static/style.css?25"/>
        <link rel="stylesheet alternate" type="text/css" href="/static/highcontrast.css?0" title="High Contrast"/>
        <link rel="shortcut icon" href="/favicon.png"/>
        </head><!--




        Oh, hello!  Funny seeing you here.

        I appreciate your enthusiasm, but you aren't going to find much down here.
        There certainly aren't clues to any of the puzzles.  The best surprises don't
        even appear in the source until you unlock them for real.

        Please be careful with automated requests; I'm not a massive company, and I can
        only take so much traffic.  Please be considerate so that everyone gets to play.

        If you're curious about how Advent of Code works, it's running on some custom
        Perl code. Other than a few integrations (auth, analytics, ads, social media),
        I built the whole thing myself, including the design, animations, prose, and
        all of the puzzles.

        The puzzles are most of the work; preparing a new calendar and a new set of
        puzzles each year takes all of my free time for 4-5 months. A lot of effort
        went into building this thing - I hope you're enjoying playing it as much as I
        enjoyed making it for you!

        If you'd like to hang out, I'm @ericwastl on Twitter.

        - Eric Wastl


















































        -->
        <body>
        <header><div><h1 class="title-global"><a href="/">Advent of Code</a></h1><nav><ul><li><a href="/2018/about">[About]</a></li><li><a href="/2018/events">[Events]</a></li><li><a href="https://teespring.com/adventofcode-2019" target="_blank">[Shop]</a></li><li><a href="/2018/settings">[Settings]</a></li><li><a href="/2018/auth/logout">[Log Out]</a></li></ul></nav><div class="user">Jon Pascoe <span class="star-count">2*</span></div></div><div><h1 class="title-event">&nbsp;&nbsp;&nbsp;<span class="title-event-wrap">$year=</span><a href="/2018">2018</a><span class="title-event-wrap">;</span></h1><nav><ul><li><a href="/2018">[Calendar]</a></li><li><a href="/2018/support">[AoC++]</a></li><li><a href="/2018/sponsors">[Sponsors]</a></li><li><a href="/2018/leaderboard">[Leaderboard]</a></li><li><a href="/2018/stats">[Stats]</a></li></ul></nav></div></header>

        <div id="sidebar">
        <div id="sponsor"><div class="quiet">Our <a href="/2018/sponsors">sponsors</a> help make Advent of Code possible:</div><div class="sponsor"><a href="https://www.winton.com/" target="_blank" onclick="if(ga)ga('send','event','sponsor','sidebar',this.href);" rel="noopener">Winton</a> - a data science and investment management company</div></div>
        </div><!--/sidebar-->

        <main>
        <script>window.addEventListener('click', function(e,s,r){if(e.target.nodeName==='CODE'&&e.detail===3){s=window.getSelection();s.removeAllRanges();r=document.createRange();r.selectNodeContents(e.target);s.addRange(r);}});</script>
        <article class="day-desc"><h2>--- Day 1: Chronal Calibration ---</h2><p>"We've detected some temporal anomalies," one of Santa's Elves at the <span title="It's about as big on the inside as you expected.">Temporal Anomaly Research and Detection Instrument Station</span> tells you. She sounded pretty worried when she called you down here. "At 500-year intervals into the past, someone has been changing Santa's history!"</p>
        <p>"The good news is that the changes won't propagate to our time stream for another 25 days, and we have a device" - she attaches something to your wrist - "that will let you fix the changes with no such propagation delay. It's configured to send you 500 years further into the past every few days; that was the best we could do on such short notice."</p>
        <p>"The bad news is that we are detecting roughly <em>fifty</em> anomalies throughout time; the device will indicate fixed anomalies with <em class="star">stars</em>. The other bad news is that we only have one device and you're the best person for the job! Good lu--" She taps a button on the device and you suddenly feel like you're falling. To save Christmas, you need to get all <em class="star">fifty stars</em> by December 25th.</p>
        <p>Collect stars by solving puzzles.  Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first.  Each puzzle grants <em class="star">one star</em>. Good luck!</p>
        <p>After feeling like you've been falling for a few minutes, you look at the device's tiny screen. "Error: Device must be calibrated before first use. Frequency drift detected. Cannot maintain destination lock." Below the message, the device shows a sequence of changes in frequency (your puzzle input). A value like <code>+6</code> means the current frequency increases by <code>6</code>; a value like <code>-3</code> means the current frequency decreases by <code>3</code>.</p>
        <p>For example, if the device displays frequency changes of <code>+1, -2, +3, +1</code>, then starting from a frequency of zero, the following changes would occur:</p>
        <ul>
        <li>Current frequency <code>&nbsp;0</code>, change of <code>+1</code>; resulting frequency <code>&nbsp;1</code>.</li>
        <li>Current frequency <code>&nbsp;1</code>, change of <code>-2</code>; resulting frequency <code>-1</code>.</li>
        <li>Current frequency <code>-1</code>, change of <code>+3</code>; resulting frequency <code>&nbsp;2</code>.</li>
        <li>Current frequency <code>&nbsp;2</code>, change of <code>+1</code>; resulting frequency <code>&nbsp;3</code>.</li>
        </ul>
        <p>In this example, the resulting frequency is <code>3</code>.</p>
        <p>Here are other example situations:</p>
        <ul>
        <li><code>+1, +1, +1</code> results in <code>&nbsp;3</code></li>
        <li><code>+1, +1, -2</code> results in <code>&nbsp;0</code></li>
        <li><code>-1, -2, -3</code> results in <code>-6</code></li>
        </ul>
        <p>Starting with a frequency of zero, <em>what is the resulting frequency</em> after all of the changes in frequency have been applied?</p>
        </article>
        <p>Your puzzle answer was <code>433</code>.</p><article class="day-desc"><h2 id="part2">--- Part Two ---</h2><p>You notice that the device repeats the same frequency change list over and over. To calibrate the device, you need to find the first frequency it reaches <em>twice</em>.</p>
        <p>For example, using the same list of changes above, the device would loop as follows:</p>
        <ul>
        <li>Current frequency <code>&nbsp;0</code>, change of <code>+1</code>; resulting frequency <code>&nbsp;1</code>.</li>
        <li>Current frequency <code>&nbsp;1</code>, change of <code>-2</code>; resulting frequency <code>-1</code>.</li>
        <li>Current frequency <code>-1</code>, change of <code>+3</code>; resulting frequency <code>&nbsp;2</code>.</li>
        <li>Current frequency <code>&nbsp;2</code>, change of <code>+1</code>; resulting frequency <code>&nbsp;3</code>.</li>
        <li>(At this point, the device continues from the start of the list.)</li>
        <li>Current frequency <code>&nbsp;3</code>, change of <code>+1</code>; resulting frequency <code>&nbsp;4</code>.</li>
        <li>Current frequency <code>&nbsp;4</code>, change of <code>-2</code>; resulting frequency <code>&nbsp;2</code>, which has already been seen.</li>
        </ul>
        <p>In this example, the first frequency reached twice is <code>2</code>. Note that your device might need to repeat its list of frequency changes many times before a duplicate frequency is found, and that duplicates might be found while in the middle of processing the list.</p>
        <p>Here are other examples:</p>
        <ul>
        <li><code>+1, -1</code> first reaches <code>0</code> twice.</li>
        <li><code>+3, +3, +4, -2, -4</code> first reaches <code>10</code> twice.</li>
        <li><code>-6, +3, +8, +5, -6</code> first reaches <code>5</code> twice.</li>
        <li><code>+7, +7, -2, -7, -4</code> first reaches <code>14</code> twice.</li>
        </ul>
        <p><em>What is the first frequency your device reaches twice?</em></p>
        </article>
        <p>Your puzzle answer was <code>256</code>.</p><p class="day-success">Both parts of this puzzle are complete! They provide two gold stars: **</p>
        <p>At this point, you should <a href="/2018">return to your Advent calendar</a> and try another puzzle.</p>
        <p>If you still want to see it, you can <a href="1/input" target="_blank">get your puzzle input</a>.</p>
        <p>You can also <span class="share">[Share<span class="share-content">on
          <a href="https://twitter.com/intent/tweet?text=I%27ve+completed+%22Chronal+Calibration%22+%2D+Day+1+%2D+Advent+of+Code+2018&amp;url=https%3A%2F%2Fadventofcode%2Ecom%2F2018%2Fday%2F1&amp;related=ericwastl&amp;hashtags=AdventOfCode" target="_blank">Twitter</a>
          <a href="javascript:void(0);" onclick="var mastodon_instance=prompt('Mastodon Instance / Server Name?'); if(typeof mastodon_instance==='string' && mastodon_instance.length){this.href='https://'+mastodon_instance+'/share?text=I%27ve+completed+%22Chronal+Calibration%22+%2D+Day+1+%2D+Advent+of+Code+2018+%23AdventOfCode+https%3A%2F%2Fadventofcode%2Ecom%2F2018%2Fday%2F1'}else{return false;}" target="_blank">Mastodon</a
        ></span>]</span> this puzzle.</p>
        </main>

        <!-- ga -->
        <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-69522494-1', 'auto');
        ga('set', 'anonymizeIp', true);
        ga('send', 'pageview');
        </script>
        <!-- /ga -->
        </body>
        </html>
      EOF
    }

    let(:markdown_part_1) {
      <<~EOF
        ## --- Day 2: Inventory Management System ---

        You stop falling through time, catch your breath, and check the screen on the device. "Destination reached. Current Year: 1518. Current Location: North Pole Utility Closet 83N10." You made it! Now, to find those anomalies.

        Outside the utility closet, you hear footsteps and a voice. "...I'm not sure either. But now that so many people have chimneys, maybe he could sneak in that way?" Another voice responds, "Actually, we've been working on a new kind of **suit** that would let him fit through tight spaces like that. But, I heard that a few days ago, they lost the prototype fabric, the design plans, everything! Nobody on the team can even seem to remember important details of the project!"

        "Wouldn't they have had enough fabric to fill several boxes in the warehouse? They'd be stored together, so the box IDs should be similar. Too bad it would take forever to search the warehouse for **two similar box IDs**..." They walk too far away to hear any more.

        Late at night, you sneak to the warehouse - who knows what kinds of paradoxes you could cause if you were discovered - and use your fancy wrist device to quickly scan every box and produce a list of the likely candidates (your puzzle input).

        To make sure you didn't miss any, you scan the likely candidate boxes again, counting the number that have an ID containing **exactly two of any letter** and then separately counting those with **exactly three of any letter**. You can multiply those two counts together to get a rudimentary checksum and compare it to what your device predicts.

        For example, if you see the following box IDs:

        * ``abcdef`` contains no letters that appear exactly two or three times.
        * ``bababc`` contains two ``a`` and three ``b``, so it counts for both.
        * ``abbcde`` contains two ``b``, but no letter appears exactly three times.
        * ``abcccd`` contains three ``c``, but no letter appears exactly two times.
        * ``aabcdd`` contains two ``a`` and two ``d``, but it only counts once.
        * ``abcdee`` contains two ``e``.
        * ``ababab`` contains three ``a`` and three ``b``, but it only counts once.

        Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of ``4 * 3 = 12``.

        **What is the checksum** for your list of box IDs?

      EOF
    }
    let(:markdown_part_2) {
      <<~EOF
        ## --- Part Two ---

        You notice that the device repeats the same frequency change list over and over. To calibrate the device, you need to find the first frequency it reaches **twice**.

        For example, using the same list of changes above, the device would loop as follows:

        * Current frequency `` 0``, change of ``+1``; resulting frequency `` 1``.
        * Current frequency `` 1``, change of ``-2``; resulting frequency ``-1``.
        * Current frequency ``-1``, change of ``+3``; resulting frequency `` 2``.
        * Current frequency `` 2``, change of ``+1``; resulting frequency `` 3``.
        * (At this point, the device continues from the start of the list.)
        * Current frequency `` 3``, change of ``+1``; resulting frequency `` 4``.
        * Current frequency `` 4``, change of ``-2``; resulting frequency `` 2``, which has already been seen.

        In this example, the first frequency reached twice is ``2``. Note that your device might need to repeat its list of frequency changes many times before a duplicate frequency is found, and that duplicates might be found while in the middle of processing the list.

        Here are other examples:

        * ``+1, -1`` first reaches ``0`` twice.
        * ``+3, +3, +4, -2, -4`` first reaches ``10`` twice.
        * ``-6, +3, +8, +5, -6`` first reaches ``5`` twice.
        * ``+7, +7, -2, -7, -4`` first reaches ``14`` twice.

        **What is the first frequency your device reaches twice?**

      EOF
    }

    it "sends a GET request to AOC for today's instructions" do
      stub_request(:get, "https://adventofcode.com/#{year}/day/#{day}").to_return({ body: response_part_1 })
      within_test_app { AocRb::App.start %w(fetch_instructions) }
      expect(WebMock).to have_requested(:get, "https://adventofcode.com/#{year}/day/#{day}")
    end

    it "converts the returned HTML into markdown and saves it to the correct challenge directory" do
      stub_request(:get, "https://adventofcode.com/2018/day/4").to_return({ body: response_part_1 })
      part_1_file = test_file_path("challenges/2018/04/part_1.md")
      within_test_app do
        expect { AocRb::App.start %w(fetch_instructions 2018 4) }.to change { File.exist?(part_1_file) }.from(false).to(true)
        expect(File.read(part_1_file)).to eq markdown_part_1
      end
    end

    it "correctly splits the instructions into two files when both parts are returned" do
      stub_request(:get, "https://adventofcode.com/2018/day/1").to_return({ body: response_part_2 })
      challenge_dir = test_file_path("challenges/2018/01")
      part_1_file   = File.join(challenge_dir, "part_1.md")
      part_2_file   = File.join(challenge_dir, "part_2.md")
      expect(File.exist?(part_1_file)).to be false
      expect(File.exist?(part_2_file)).to be false
      within_test_app { AocRb::App.start %w(fetch_instructions 2018 1) }
      expect(File.exist?(part_1_file)).to be true
      expect(File.exist?(part_2_file)).to be true
      expect(File.read(part_2_file)).to eq markdown_part_2
    end
  end

  describe "output" do
    before do
      stub_request(:get, "https://adventofcode.com/2018/day/4/input").to_return({ body: 'test' })
    end

    after do
      remove_test_dir("spec", "2018")
    end

    it "can return output" do
      within_test_app do
        AocRb::App.start %w(bootstrap -y 2018 -d 4)
        require File.join(Dir.pwd, "challenges", "2018", "04", "solution.rb")

        expect { AocRb::App.start %w(output -y 2018 -d 4) }.to output("no result for part 1\n\nno result for part 2\n").to_stdout
      end
    end
  end
end
