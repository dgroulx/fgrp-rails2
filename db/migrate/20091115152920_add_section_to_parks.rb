class AddSectionToParks < ActiveRecord::Migration
  def self.up
    add_column :parks, :section_id, :integer
  end

  def self.down
    remove_column :parks, :section_id
  end
end
