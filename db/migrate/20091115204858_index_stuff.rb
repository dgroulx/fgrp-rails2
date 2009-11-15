class IndexStuff < ActiveRecord::Migration
  def self.up
    add_index :park_amenities, :park_id
    add_index :park_amenities, :amenity_id
  end

  def self.down
    remove_index :park_amenities, :amenity_id
    remove_index :park_amenities, :park_id
  end
end
