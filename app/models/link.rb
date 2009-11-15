class Link < ActiveRecord::Base
  belongs_to :park
  
  validates_format_of :url, :with => /\w+:\/\/.+/
end
