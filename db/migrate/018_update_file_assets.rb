class UpdateFileAssets < ActiveRecord::Migration
  def self.up
    rename_column :file_assets, :file_file_name, :file
    rename_column :file_assets, :file_content_type, :content_type
    add_column :file_assets, :created_at, :datetime
    rename_column :file_assets, :file_updated_at, :updated_at
    remove_column :file_assets, :file_width
    remove_column :file_assets, :file_height
    rename_column :file_assets, :file_file_size, :file_size
  end

  def self.down
  end
end
