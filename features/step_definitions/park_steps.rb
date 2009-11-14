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
