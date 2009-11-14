class AddVimeoEmbedToParks < ActiveRecord::Migration
  def self.up
    add_column :parks, :vimeo_embed, :text
  end

  def self.down
    remove_column :parks, :vimeo_embed
  end
end
