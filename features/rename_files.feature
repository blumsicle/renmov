Feature: Rename Files
  As a digital video collector
  In order to organize my video files
  I want to consistently rename my files

  Scenario Outline: one file
    Given an empty file named "<old>"
    When I successfully run `renmov <old>`
    Then a file named "<old>" should not exist
    And a file named "<new>" should exist

    Scenarios: tv shows
      | old                                     | new                |
      | TV.Show.S01E02.HDTV.x264-LOL.[VTV].mp4  | tv.show.s01e02.mp4 |
      | The.TV.Show.S01E02.[VTV].avi            | tv.show.s01e02.avi |
      | TV.Show.2012.S01E02.x264-LOL.mp4        | tv.show.s01e02.mp4 |

  Scenario: same file name
    Given an empty file named "tv.show.s01e01.mp4"
    When I successfully run `renmov tv.show.s01e01.mp4`
    Then a file named "tv.show.s01e01.mp4" should exist
