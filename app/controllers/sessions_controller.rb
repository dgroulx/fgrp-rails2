class SessionsController < Clearance::SessionsController
  layout 'login'
  
  private
  
  def url_after_create
    parks_path
  end
end
