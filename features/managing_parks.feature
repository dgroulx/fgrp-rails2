Feature: Managing parks

  In order to provide information on parks in the GR area
  As an admin
  I want to be able to manage parks
  
  Scenario: Non-admin trying to create a park
    Given I am not signed in
    When I go to the new park page
    Then I should see "Login required"
  
  Scenario: Admin creating a park
    Given I have signed in with "zach@zach.com/banana"
    When I go to the new park page
    And I fill in "Name" with "Zach's awesome park"
    And I fill in "Address" with "1234 Mulberry Ln"
    And I fill in "Latitude" with "40.5"
    And I fill in "Longitude" with "-80.5"
    And I fill in "Vimeo Embed" with "<object>My great video</object>"    
    And I fill in "Park Size" with "50x50"
    And I fill in "History" with "this is a new park"
    And I fill in "Contact info" with "Zachary"
    And I fill in "Flickr pool id" with "abc123"
    And I press "Create"
    Then I should see "Park was successfully created."
    And I should be on the parks index page
    And I should see "Zach's awesome park"
    
    When I go to the recently created park's page
    Then I should see the park:
      | .name | Zach's awesome park |
      | .contactinfo | Zachary |
      | .history | this is a new park |
      | .parksize    | 50x50 |
      | .address    | 1234 Mulberry Ln |
      | .vimeo_embed    | My great video |
    
    Then I should see a flickr slide show for the pool with group id "abc123"

  Scenario: Admin updating a park
    Given I have signed in with "zach@zach.com/banana"
    And a park exists with a name of "Wilcox Park"
    When I go to the "Wilcox Park" park's edit page
    And I fill in "Name" with "Zach's awesome park"
    And I fill in "Address" with "1234 Mulberry Ln"
    And I fill in "Vimeo Embed" with "<object>My great video</object>"
    And I fill in "Park Size" with "50x50"
    And I fill in "History" with "this is a new park"
    And I fill in "Contact info" with "Zachary"
    And I fill in "Flickr Pool Id" with "abc123"
    And I fill in "Latitude" with "40.5"
    And I fill in "Longitude" with "-80.5"
    And I press "Update"
    Then I should see "Park was successfully updated."
    And I should be on the parks index page
    And I should see "Zach's awesome park"
    
    When I go to the "Zach's awesome park" park's page
    Then I should see the park:
      | .name | Zach's awesome park |
      | .contactinfo | Zachary |
      | .history | this is a new park |
      | .parksize    | 50x50 |
      | .address    | 1234 Mulberry Ln |
      | .vimeo_embed    | My great video |
  
  Scenario: Admin destroying a park
    Given I have signed in with "zach@zach.com/banana"
    And a park exists with a name of "Wilcox Park"
    When I go to the parks index page
    And I destroy the "Wilcox Park" park
    Then I should see "Park was successfully destroyed."
    
    When I go to the parks index page
    Then I should not see "Wilcox Park"
    
  Scenario: Admin adding park amenities
    Given I have signed in with "zach@zach.com/banana"
    And a park exists with a name of "Parky"
    And an amenity exists with a name of "Benches"
    When I go to the "Parky" park's edit page
    And I select "Benches" from "Amenity"
    And I fill in "Amenity description" with "Brown happy benches"
    And I press "Update"
    Then I should see "Park was successfully updated."
    
    When I go to the recently created park's page
    Then I should see the park has the amenities:
      | Amenity | Description |
      | Benches | Brown happy benches |
    
  Scenario: Updating a park amenity
    Given I have signed in with "zach@zach.com/banana"
    And an amenity exists with a name of "Benches"
    And an amenity exists with a name of "Slides"
    And a park exists with a name of "Parky"
    And the park "Parky" has a "Benches" amenity with description "Benchy"
    When I go to the "Parky" park's edit page
    And I select "Slides" from "Amenity"
    And I fill in "Amenity description" with "Slippery slide"
    And I press "Update"
    Then I should see "Park was successfully updated."
    And I should be on the parks index page
    
    When I go to the "Parky" park's page
    Then I should see the park has the amenities:
      | Amenity | Description |
      | Slides | Slippery slide |

  Scenario: Admin adding park resource links
    Given I have signed in with "zach@zach.com/banana"
    And a park exists with a name of "Parky"
    When I go to the "Parky" park's edit page
    And I fill in "Title" with "Google Huh"
    And I fill in "Url" with "http://www.google.com"
    And I press "Update"
    Then I should see "Park was successfully updated."

    When I go to the recently created park's page
    Then I should see "Google Huh"

