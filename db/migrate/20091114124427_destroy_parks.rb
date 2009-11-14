class DestroyParks < ActiveRecord::Migration
  def self.up
    drop_table :parks
  end

  def self.down
    create_table :parks do |t|
      t.string :title

      t.timestamps
    end
  end
end
