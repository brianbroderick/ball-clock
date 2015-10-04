Feature: Command Suite Interface
  As a clock maker
  I want to be able to get help when I need it.

  Scenario: App just runs
    When I get help for "ball-clock"
    Then the exit status should be 0

