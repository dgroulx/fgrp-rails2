Then /^I should see the park:$/ do |table|
  within ".park" do |park|
    table.rows_hash.each_pair do |css_selector, content|
      park.should have_selector("#{css_selector}", :content => content)
    end
  end
end

When /^I destroy the "([^\"]*)" park$/ do |park_name|
  click_link_within ".park:contains('#{park_name}')", "Destroy"
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
