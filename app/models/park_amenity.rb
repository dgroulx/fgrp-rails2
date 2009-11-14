class ParkAmenity < ActiveRecord::Base
  belongs_to :amenity
  belongs_to :park

  delegate :name, :to => :amenity
end
