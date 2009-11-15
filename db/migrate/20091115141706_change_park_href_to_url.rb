class ChangeParkHrefToUrl < ActiveRecord::Migration
  def self.up
    rename_column :links, :href, :url
  end

  def self.down
    rename_column :links, :url, :href
  end
end
