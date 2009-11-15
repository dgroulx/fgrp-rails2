class User < ActiveRecord::Base
  include Clearance::User
  
  named_scope :confirmed, :conditions => { :email_confirmed => true }
end
