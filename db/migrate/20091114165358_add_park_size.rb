class AddParkSize < ActiveRecord::Migration
  def self.up
    add_column :parks, :park_size, :string
  end

  def self.down
    remove_column :parks, :park_size
  end
end
