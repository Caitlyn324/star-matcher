class CreateAuditions < ActiveRecord::Migration[5.1]
  def change
    create_table :auditions do |t|
      t.string :roles, array: true, default: [], null: false
      t.string :show, null: false
      t.string :theater
      t.string :address, null: false
      t.string :company
      t.string :description
      t.boolean :equity, null: false
      t.datetime :time, null: false

      t.timestamps
    end
  end
end
