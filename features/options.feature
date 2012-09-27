Feature: Options
  As a user of `renmov`
  In order to get the results desired
  I want the command line arguments to work properly

  Scenario: verbose (-v)
    Given an empty file named "TV.Show.S01E02.HDTV.x264-LOL.mp4"
    When I successfully run `renmov -v TV.Show.S01E02.HDTV.x264-LOL.mp4`
    Then a file named "TV.Show.S01E02.HDTV.x264-LOL.mp4" should not exist
    And a file named "tv.show.s01e02.mp4" should exist
    And the output should contain:
    """
    mv TV.Show.S01E02.HDTV.x264-LOL.mp4 tv.show.s01e02.mp4
    """

  Scenario: verbose (--verbose)
    Given an empty file named "TV.Show.S01E02.HDTV.x264-LOL.mp4"
    When I successfully run `renmov --verbose TV.Show.S01E02.HDTV.x264-LOL.mp4`
    Then a file named "TV.Show.S01E02.HDTV.x264-LOL.mp4" should not exist
    And a file named "tv.show.s01e02.mp4" should exist
    And the output should contain:
    """
    mv TV.Show.S01E02.HDTV.x264-LOL.mp4 tv.show.s01e02.mp4
    """

  Scenario: noop (-n)
    Given an empty file named "TV.Show.S01E02.HDTV.x264-LOL.mp4"
    When I successfully run `renmov -n TV.Show.S01E02.HDTV.x264-LOL.mp4`
    Then a file named "tv.show.s01e02.mp4" should not exist
    And a file named "TV.Show.S01E02.HDTV.x264-LOL.mp4" should exist
    And the output should contain:
    """
    mv TV.Show.S01E02.HDTV.x264-LOL.mp4 tv.show.s01e02.mp4
    """

  Scenario: noop (--noop)
    Given an empty file named "TV.Show.S01E02.HDTV.x264-LOL.mp4"
    When I successfully run `renmov --noop TV.Show.S01E02.HDTV.x264-LOL.mp4`
    Then a file named "tv.show.s01e02.mp4" should not exist
    And a file named "TV.Show.S01E02.HDTV.x264-LOL.mp4" should exist
    And the output should contain:
    """
    mv TV.Show.S01E02.HDTV.x264-LOL.mp4 tv.show.s01e02.mp4
    """

  Scenario: version (--version)
    Given a blank slate
    When I successfully run `renmov --version`
    Then the output should contain the right version

  Scenario: help (-h)
    Given a blank slate
    When I successfully run `renmov -h`
    Then the output should contain:
    """
    Rename video files to a consistent format.

    Usage: renmov [options] filename...
    """
    
  Scenario: help (--help)
    Given a blank slate
    When I successfully run `renmov --help`
    Then the output should contain:
    """
    Rename video files to a consistent format.

    Usage: renmov [options] filename...
    """

  Scenario: no arguments/options
    Given a blank slate
    When I run `renmov`
    Then the exit status should be 1
    And the stderr should contain:
    """
    renmov: no filename(s) provided
    Rename video files to a consistent format.

    Usage: renmov [options] filename...
    """

  Scenario: invalid option (short)
    Given a blank slate
    When I run `renmov -i`
    Then the exit status should be 1
    And the stderr should contain:
    """
    renmov: invalid option: -i
    Rename video files to a consistent format.

    Usage: renmov [options] filename...
    """

  Scenario: invalid option (long)
    Given a blank slate
    When I run `renmov --invalid`
    Then the exit status should be 1
    And the stderr should contain:
    """
    renmov: invalid option: --invalid
    Rename video files to a consistent format.

    Usage: renmov [options] filename...
    """
