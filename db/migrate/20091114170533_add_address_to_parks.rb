class AddAddressToParks < ActiveRecord::Migration
  def self.up
    add_column :parks, :address, :string
  end

  def self.down
    remove_column :parks, :address
  end
end
