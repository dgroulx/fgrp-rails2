class ChangeAddressToText < ActiveRecord::Migration
  def self.up
    change_column :parks, :address, :text
  end

  def self.down
    change_column :parks, :address, :string
  end
end
