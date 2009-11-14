class CreateParkAmenities < ActiveRecord::Migration
  def self.up
    create_table :park_amenities do |t|
      t.integer :park_id
      t.integer :amenity_id
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :park_amenities
  end
end
