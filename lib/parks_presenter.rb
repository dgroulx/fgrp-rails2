class ParksPresenter
  include ActionController::UrlWriter
  
  def initialize park_scope
    @park_scope = park_scope
    @parks = @park_scope.scoped(:include => {:park_amenities => :amenity}).all
  end
  
  def to_json(*args)
    amenity_list = @parks.map(&:park_amenities).flatten.map(&:name).uniq.sort
    amenity_map = {}
    amenity_list.each_with_index do |amenity, index|
      amenity_map[amenity] = index
    end
    
    representation = {
      :amenities => amenity_list,
      :parks => @parks.map do |park|
        {
          :name => park.name,
          :latitude => park.latitude,
          :longitude => park.longitude,
          :address => park.address,
          :url => park_path(park),
          :amenities => park.park_amenities.inject(Array.new(amenity_list.size, false)) do |presence_list, amenity|
            presence_list[amenity_map[amenity.name]] = true
            presence_list
          end
        }
      end
    }
    
    representation.to_json
  end
end