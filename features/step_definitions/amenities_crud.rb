When /^I click the edit link for the amenity named "([^\"]*)"$/ do |amenity_name|
  click_link_within ".amenity:contains('#{amenity_name}')", "Edit"
end
                                                
