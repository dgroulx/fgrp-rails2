class UsersController < Clearance::UsersController
  
  # only allow logged in users to create new accounts
  skip_before_filter :redirect_to_root
  before_filter :authenticate
end
