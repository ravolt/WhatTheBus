Feature: Mobile Access
  In order to ensure that location updates are captured
  School Bus Location providers
  want to have data they send stored on the site
  
  Scenario: Bus Moves
    When bus named "lion" in the "eanes" district with a id of "1234" goes to "32,-97"
    When I go to the bus "1234" json page
    Then json has an object called "buses"
      And json has a record "1234" in "buses" with "lat" value "32"
      And json has a record "1234" in "buses" with "lng" value "-97"
    When bus with a id of "1234" goes to "33,-98"
    When I go to the bus "1234" json page
    Then json has an object called "buses"
      And json has a record "1234" in "buses" with "lat" value "33"
      And json has a record "1234" in "buses" with "lng" value "-98"

  Scenario: Update Location
    When bus named "lion" in the "eanes" district with a id of "1234" goes to "32,-97"
    When I go to the bus "1234" json page
    Then json has an object called "buses"
      And json has a record "1234" in "buses" with "lat" value "32"
      And json has a record "1234" in "buses" with "lng" value "-97"
      And json has a record "1234" in "buses" with "name" value "lion"
      And json has a record "1234" in "buses" with "district" value "eanes"

  Scenario: Add Bus
    When bus named "giraffe" in the "eanes" district with a id of "6789" goes to "33,-98"
    When I go to the bus "6789" page
    Then I should see "giraffe"
      And I should see "eanes"
      And I should see "6789"
      And I should see "33,-98"
      
  Scenario: Multiple Buses (same district)
    When bus named "giraffe" in the "eanes" district with a id of "6789" goes to "33,-98"
    When bus named "lion" in the "eanes" district with a id of "1234" goes to "32,-97"
    When I go to the bus "6789" page
    Then I should see "giraffe"
      And I should not see "lion"
    When I go to the bus "1234" page
    Then I should see "lion"
      And I should not see "giraffe"

  Scenario: Multiple Buses (differnt district)
    When bus named "giraffe" in the "eanes" district with a id of "6789" goes to "33,-98"
    When bus named "elephant" in the "houston" district with a id of "1234" goes to "32,-97"
    When I go to the bus "6789" page
    Then I should see "giraffe"
      And I should see "eanes"
      And I should not see "houston"
    When I go to the bus "1234" page
    Then I should see "lion"
      And I should see "houston"
      And I should not see "eanes"
