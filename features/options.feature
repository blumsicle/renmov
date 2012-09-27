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
