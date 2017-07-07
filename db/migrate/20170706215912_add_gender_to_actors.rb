class AddGenderToActors < ActiveRecord::Migration[5.1]
  def change
    add_column :actors, :gender, :string
  end
end
