Feature: Managing links

  In order to provide information related to the parks
  As an admin
  I want to be able to manage links associated with parks
  
  Scenario: Non-admin trying to create a link
    Given I am not signed in
    And a park exists with a name of "Free parking"
    When I go to the links page for the "Free parking" park
    Then I should see "Login required"
  
  Scenario: Admin user creating a link
    Given I have signed in with "zach@zach.com/bananapanic"
    And a park exists with a name of "Free parking"
    When I go to the links page for the "Free parking" park
    And I fill in "Title" with "Unrelated, but funny"
    And I fill in "URL" with "http://badgerbadgerbadger.com"
    And I press "Create"
    Then I should see "Link was successfully created."
    And I should be on the links page for the "Free parking" park
    And I should see "Unrelated, but funny"
    
  Scenario: Admin user deleting a link
    Given I have signed in with "zach@zach.com/bananapanic"
    And a park exists with a name of "Free parking"
    And a link exists for the "Free parking" park called "Pineapples"
    When I go to the links page for the "Free parking" park
    And I follow "Destroy" for the "Pineapples" link
    Then I should see "Link was successfully destroyed."
    And I should be on the links page for the "Free parking" park
    And I should not see "Pineapples"
    
  Scenario: Admin user editing a link
    Given I have signed in with "zach@zach.com/bananapanic"
    And a park exists with a name of "Free parking"
    And a link exists for the "Free parking" park called "Pineapples"
    When I go to the links page for the "Free parking" park
    And I follow "Edit" for the "Pineapples" link
    And I fill in "Title" with "YouTube"
    And I press "Update"
    Then I should see "Link was successfully updated."
    And I should be on the links page for the "Free parking" park
    And I should see "YouTube"
    And I should not see "Pineapples"
    
  Scenario: Admin trying to add an invalid link
    Given I have signed in with "zach@zach.com/bananapanic"
    And a park exists with a name of "Free parking"
    When I go to the links page for the "Free parking" park
    And I fill in "Title" with "lols"
    And I fill in "URL" with "http/badgerbadgerbadger.com"
    And I press "Create"
    Then I should see "Url is invalid"
    And I should be on the links page for the "Free parking" park