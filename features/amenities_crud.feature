Feature: Amenities crud

  Scenario: An unauthenticated user tries to access a crud action
    Given I am not signed in
    When I go to the new amenity page
    And I should be on the sign in page

  Scenario: An authenticated user creates an amenity
    Given I have signed in with "admin@example.com/password"
    When I go to the new amenity page
    And I fill in "Name" with "Basketball Court"
    And I press "Create"
    Then I should see "Basketball Court was created"
    And I should be on the amenities page

    When I go to the amenities page
    Then I should see "Basketball Court"

  Scenario: A user creates a duplicate amenity
    Given an amenity exists with a name of "Basketball Court"
    And I have signed in with "admin@example.com/password"
    When I go to the new amenity page
    And I press "Create"
    Then I should see "Name can't be blank"

  Scenario: A user creates a duplicate amenity
    Given an amenity exists with a name of "Basketball Court"
    And I have signed in with "admin@example.com/password"
    When I go to the new amenity page
    And I fill in "Name" with "Basketball Court"
    And I press "Create"
    Then I should see "Name has already been taken"
    And the "Name" field should contain "Basketball Court"

  Scenario: A user updates an existing amenity
    Given an amenity exists with a name of "Basketball Curt"
    And I have signed in with "admin@example.com/password"
    When I go to the amenities page
    And I click the "Edit" link for the amenity named "Basketball Curt"
    Then I should be on the "Basketball Curt" amenity's edit page
    And the "Name" field should contain "Basketball Curt"

    When I fill in "Name" with "Basketball Court"
    And I press "Save"
    Then I should see "Basketball Court was updated"
    And I should be on the amenities page

  Scenario: A user deletes an amenity
    Given an amenity exists with a name of "Basketball Curt"
    And I have signed in with "admin@example.com/password"
    When I go to the amenities page
    And I click the "Delete" link for the amenity named "Basketball Curt"
    Then I should be on the amenities page
    And I should see "Basketball Curt deleted."

    When I go to the amenities page
    And I should not see "Basketball Curt"

