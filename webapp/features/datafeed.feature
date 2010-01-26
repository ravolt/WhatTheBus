Feature: Mobile Access
  In order to ensure that location updates are captured
  School Bus Location providers
  want to have data they send stored on the site
  
  Scenario: Bus Moves
    Given no cache for "1234"
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
    Given no cache for "1234"
    When bus named "lion" in the "eanes" district with a id of "1234" goes to "32,-97"
    When I go to the bus "1234" json page
    Then json has an object called "buses"
      And json has a record "1234" in "buses" with "lat" value "32"
      And json has a record "1234" in "buses" with "lng" value "-97"
      And json has a record "1234" in "buses" with "name" value "lion"
      And json has a record "1234" in "buses" with "district" value "eanes"

  Scenario: Update Location, extra decimals
    Given no cache for "1234"
    When bus named "lion" in the "eanes" district with a id of "1234" goes to "32.123456789,-97.987654321"
    When I go to the bus "1234" json page
    Then json has an object called "buses"
      And json has a record "1234" in "buses" with "lat" value "32.123456789"
      And json has a record "1234" in "buses" with "lng" value "-97.987654321"
    
  Scenario: Add Bus
    Given no cache for "6789"
    When bus named "giraffe" in the "eanes" district with a id of "6789" goes to "33,-98"
    When I go to the bus "6789" page
    Then I should see "giraffe"
      And I should see "eanes"
      And I should see "6789"
      And I should see "33,-98"
      
  Scenario: Multiple Buses (same district)
    Given no cache for "1234"
    Given no cache for "6789"
    When bus named "giraffe" in the "eanes" district with a id of "6789" goes to "33,-98"
    When bus named "lion" in the "eanes" district with a id of "1234" goes to "32,-97"
    When I go to the bus "6789" page
    Then I should see "giraffe"
      And I should not see "lion"
    When I go to the bus "1234" page
    Then I should see "lion"
      And I should not see "giraffe"

  Scenario: Multiple Buses (different district)
    Given no cache for "1234"
    Given no cache for "6789"
    When bus named "giraffe" in the "eanes" district with a id of "6789" goes to "33,-98"
    When bus named "elephant" in the "houston" district with a id of "1234" goes to "32,-97"
    When I go to the bus "6789" page
    Then I should see "giraffe"
      And I should see "eanes"
      And I should not see "houston"
    When I go to the bus "1234" page
    Then I should see "elephant"
      And I should see "houston"
      And I should not see "eanes"

  Scenario: Update to bus already in DB
    Given no cache for "qq34"
    Given bus named "monkey" in the "eanes" district with a id of "qq34"
    When I go to the bus "qq34" page
    Then I should see "monkey"
      And I should see "eanes"
      And I should see "qq34"
      And I should see "unknown"
    Then bus with a id of "qq34" goes to "31,-96"
      And I go to the bus "qq34" page
      And I should see "31,-96"
      
  Scenario: Create key from name
    Given no cache for "bogus"
    Given no cache for "district_bus"
    When bus named "bus" in the "district" district has no id goes to "1.111,4.444"
    When I go to the bus "district_bus" page
    Then I should see "district_bus"
      And I should see "1.111,4.444"
      