Feature: Create a new park
  In order to provide information on parks in the GR area
  As an admin
  I want to be able to create parks
  
  
  Scenario: Admin creating a park
  
  Scenario: Non-admin trying to create a park
    Given I go to the new park page
    Then I should see "Login required"
    
    