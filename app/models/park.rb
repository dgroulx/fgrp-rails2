class Park < ActiveRecord::Base
  has_many :park_amenities
  has_many :links
  accepts_nested_attributes_for :park_amenities, :reject_if => lambda{|attrs| attrs['amenity_id'].blank? }, :allow_destroy => true
end
