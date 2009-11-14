Feature: Managing links

  In order to provide information related to the parks
  As an admin
  I want to be able to manage links associated with parks
  
  Scenario: Non-admin trying to create a link
    Given I am not signed in
    And a park exists with a name of "Free parking"
    When I go to the links page for the "Free parking" park
    Then I should see "Login required"


