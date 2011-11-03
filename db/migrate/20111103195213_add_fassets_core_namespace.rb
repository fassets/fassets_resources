class AddFassetsCoreNamespace < ActiveRecord::Migration
  def up
    rename_table 'assets', 'fassets_core_assets'
    rename_table 'catalogs', 'fassets_core_catalogs'
    rename_table 'classifications', 'fassets_core_classifications'
    rename_table 'facets', 'fassets_core_facets'
    rename_table 'file_assets', 'fassets_core_file_assets'
    rename_table 'labelings', 'fassets_core_labelings'
    rename_table 'labels', 'fassets_core_labels'
    rename_table 'tray_positions', 'fassets_core_tray_positions'
    rename_table 'urls', 'fassets_core_urls'
  end

  def down
    rename_table 'fassets_core_assets', 'assets'
    rename_table 'fassets_core_catalogs', 'catalogs'
    rename_table 'fassets_core_classifications', 'classifications'
    rename_table 'fassets_core_facets', 'facets'
    rename_table 'fassets_core_file_assets', 'file_assets'
    rename_table 'fassets_core_labelings', 'labelings'
    rename_table 'fassets_core_labels', 'labels'
    rename_table 'fassets_core_tray_positions', 'tray_positions'
    rename_table 'fassets_core_urls', 'urls'
  end
end
