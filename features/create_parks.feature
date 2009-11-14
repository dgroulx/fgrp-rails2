Feature: Create a new park
  In order to provide information on parks in the GR area
  As an admin
  I want to be able to create parks
  
  
  Scenario: Admin creating a park
    Given I have signed in with "zach@zach.com/banana"
    When I go to the new park page
    And I fill in "Name" with "Zach's awesome park"
    And I fill in "Address" with "1234 Mulberry Ln"
    And I fill in "Park Size" with "50x50"
    And I fill in "History" with "this is a new park"
    And I fill in "Latitude" with "0.0"
    And I fill in "Longitude" with "0.0"
    And I fill in "Contact info" with "Zachary"
    And I press "Create"
    Then I should see "Park was successfully created."
    And I should be on the parks index page
    And I should see "Zach's awesome park"
    When I go to the recently created park's page
    Then I should see the park:
      | .name | Zach's awesome park |
      | .contact_info | Zachary |
      | .history | this is a new park |
      | .park_size    | 50x50 |
      | .address    | 1234 Mulberry Ln |
  
  Scenario: Non-admin trying to create a park
    Given I am not signed in
    When I go to the new park page
    Then I should see "Login required"
    
    