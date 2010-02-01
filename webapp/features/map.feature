Feature: Show Bus Locations on Map
  In order to keep track of their bus
  Parents
  want to see the location of the bus on a map updated within 1/4 mile

  Scenario: Select Bus from List
    Given no cache for "qq34"
    Given bus named "monkey" in the "eanes" district with a id of "qq34"
    Given bus named "stork" in the "baltimore" district with a id of "bb99"
    Given bus with a id of "qq34" goes to "31, -96"
    When I go to the map index page
    Then I should see "eanes"
      And I should see "baltimore"
      And I should see "monkey: active"
      And I should not see "stork: active"
    When I follow "monkey: active"
    Then I should see "monkey"
      And I should see "31, -96"

  Scenario: Select district from list (and back to all)
    Given bus named "monkey" in the "eanes" district with a id of "qq34"
    Given bus named "stork" in the "baltimore" district with a id of "bb99"
    When I go to the map index page
    Then I should see "eanes"
      And I should see "baltimore"
    When I follow "baltimore"
    Then I should see "stork"
      And I should not see "monkey"
    When I follow "show all"
    Then I should see "eanes"
      And I should see "baltimore"

  Scenario: Bus on Map
    Given no cache for "1234"
    When bus named "lion" in the "eanes" district with a id of "1234" goes to "32,-97"
    When I go to the map for "1234"
    Then I should see "lion"
      And I should see "eanes"
      And I should see "32,-97"

  Scenario: Bus not active
    Given bus named "monkey" in the "eanes" district with a id of "qq34"
    Given bus named "stork" in the "baltimore" district with a id of "bb99"
    Given no cache for "qq34"
    When I go to the map for "qq34"
    Then I should not see "Map for monkey"
      And I should see "eanes"
      And I should see "monkey: no update"
      And I should not see "baltimore"

  Scenario: Bus Location Changes
    Given no cache for "6711"
    When bus named "cheeta" in the "eanes" district with a id of "6711" goes to "32, -97"
    When I go to the map for "6711"
    Then I should see "32,-97"
    When bus with a id of "6711" goes to "32.2, -96.9"
      And I wait for a refresh
    Then I should see "32.2,-96.9"