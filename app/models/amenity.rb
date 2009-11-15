class Amenity < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :park_amenities, :dependent => :destroy
end
