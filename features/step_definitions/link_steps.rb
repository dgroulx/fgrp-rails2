Given /^a link exists for the "([^\"]*)" park called "([^\"]*)"$/ do |park_name, link_title|
  park = Park.find_by_name(park_name)
  Factory(:link, :title => link_title, :park => park)
end

When /^I follow "([^\"]*)" for the "([^\"]*)" link$/ do |link, link_title|
  click_link_within ".link:contains('#{link_title}')", link
end