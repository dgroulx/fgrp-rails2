module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the homepage/i
      root_path
    when /the sign up page/i
      new_user_path
    when /the sign in page/i
      new_session_path
    when /the password reset request page/i
      new_password_path
    when /the new park page/i
      new_park_path
    when /the parks index page/
      parks_path
    when /the recently created park's page/
      park_path(Park.last)
    when /the new amenity page/i
      new_amenity_path
    when /the amenities page/i
      amenities_path
    
    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end
 
World(NavigationHelpers)
