Then /^I should see the park:$/ do |table|
  within ".park" do |park|
    table.rows_hash.each_pair do |css_selector, content|
      park.should have_selector("#{css_selector}", :content => content)
    end
  end
end

When /^I destroy the "([^\"]*)" park$/ do |park_name|
  click_link_within ".park:contains('#{park_name}')", "Delete"
end

Then /^I should see the park has the amenities:$/ do |table|
  table.hashes.each do |row|
    name = row['Amenity'] || raise('Amenity must be supplied')
    description = row['Description'] || raise('Description must be supplied')
    within ".park .amenities .amenity" do |amenity|
      amenity.should have_selector('.name', :content => name)
      amenity.should have_selector('.description', :content => description)
    end
  end
end

Given /^the park "([^\"]*)" has a "([^\"]*)" amenity with description "([^\"]*)"$/ do |park_name, amenity_name, amenity_description|
  park = Park.find_by_name(park_name)
  amenity = Amenity.find_by_name(amenity_name)
  park.park_amenities.build(:amenity_id => amenity.id, :description => amenity_description)
end

Then /^I should see a flickr slide show for the pool with group id "([^"]+)"$/ do |group_id|
  response.should have_selector(".flickr-pool-slideshow[@data-groupid='#{group_id}']")
end
