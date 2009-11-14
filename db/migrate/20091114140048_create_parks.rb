class CreateParks < ActiveRecord::Migration
  def self.up
    create_table :parks do |t|
      t.string :name
      t.text :history
      t.float :latitude
      t.float :longitude
      t.text :contact_info

      t.timestamps
    end
  end

  def self.down
    drop_table :parks
  end
end
