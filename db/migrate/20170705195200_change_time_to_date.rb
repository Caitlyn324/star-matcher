class ChangeTimeToDate < ActiveRecord::Migration[5.1]
  def change
    change_column :auditions, :time, :date
    rename_column :auditions, :time, :date
  end
end
