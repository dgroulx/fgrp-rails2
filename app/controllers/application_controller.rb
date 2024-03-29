# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def authenticate
    deny_access("Login required.") unless signed_in?
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
