Feature: Mobile Access
  In order to ensure that location updates are captured
  School Bus Location providers
  want to have data they send stored on the site
  
  Scenario: Update Location
    When bus named "lion" in the "eanes" district with a id of "1234" goes to "32,-97"
    When I go to the bus "1234" page
    Then json has an object called "buses"
      And json has a record "1234" in "buses" with "lat" value "32"
      And json has a record "1234" in "buses" with "lng" value "-97"
      