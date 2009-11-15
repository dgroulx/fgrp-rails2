class AddFlickrPoolKeyToParks < ActiveRecord::Migration
  def self.up
    add_column :parks, :flickr_pool_id, :string
  end

  def self.down
    remove_column :parks, :flickr_pool_id
  end
end
