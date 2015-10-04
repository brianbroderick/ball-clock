Feature: Ticking Clock
  As a clock watcher
  I want to track the movements of the balls.

  Scenario: The clock has 30 balls
    When I successfully run `ball-clock start -b 30`
    Then the stdout should contain "30 balls cycle after 15 days."

  Scenario: The clock has 45 balls
    When I successfully run `ball-clock start -b 45`
    Then the stdout should contain "45 balls cycle after 378 days."

  Scenario: The clock has 30 balls and I run it for 325 minutes.
    When I successfully run `ball-clock start -b 30 -m 325`
    Then the stdout should contain:
    """
    {"Min":[],"FiveMin":[22,13,25,3,7],"Hour":[6,12,17,4,15],"Main":[9,27,14,23,1,28,21,16,20,29,10,24,8,19,30,2,18,26,5,11]}
    """

  Scenario: I am trying too few balls
    When I run `ball-clock start -b 26`
    Then the stderr should contain "The number of balls must be between 27 and 127."

  Scenario: I am trying too many balls
    When I run `ball-clock start -b 128`
    Then the stderr should contain "The number of balls must be between 27 and 127."
