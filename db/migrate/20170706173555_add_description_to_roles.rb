class AddDescriptionToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :description, :text
  end
end
