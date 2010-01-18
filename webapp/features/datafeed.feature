Feature: Mobile Access
  In order to ensure that location updates are captured
  School Bus Location providers
  want to have data they send stored on the site
  
  Scenario: Update Location
    When bus named "lion bus" in the "eanes" district with a id of "1234" goes to "32,-97"
    When I go to the bus moved json
    Then json has an object called "buses"
      And json has an object "buses\at" with "lat" value "32"
      And json has an object "buses\at" with "lng" value "-97"
      And json has an object "buses\at" with "name" value "lion bus"
      And json has an object "buses\at" with "id" value "1234"
      