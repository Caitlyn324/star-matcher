class RenameRequiredMedia < ActiveRecord::Migration[5.1]
  def change
    rename_column :roles, :require_media, :required_media
  end
end
