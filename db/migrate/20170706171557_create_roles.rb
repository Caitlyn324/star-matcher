class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.belongs_to :audition
      t.string :title
      t.string :gender
      t.integer :age_min
      t.integer :age_max
      t.string :ethnicity
      t.string :require_media

      t.timestamps
    end
  end
end
