class AddFassetsResourcesNamespaceToTables < ActiveRecord::Migration
  def change
    rename_table :file_assets, :fassets_resources_file_assets
    rename_table :urls, :fassets_resources_urls
  end
end
