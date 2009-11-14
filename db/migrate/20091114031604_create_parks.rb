class CreateParks < ActiveRecord::Migration
  def self.up
    create_table :parks do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :parks
  end
end
