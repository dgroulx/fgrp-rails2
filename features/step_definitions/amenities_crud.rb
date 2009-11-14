When /^I click the "([^"]+)" link for the amenity named "([^\"]*)"$/ do |link_text, amenity_name|
  click_link_within ".amenity:contains('#{amenity_name}')", link_text
end
                                                
