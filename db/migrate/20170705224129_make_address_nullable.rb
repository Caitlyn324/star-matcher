class MakeAddressNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null(:auditions, :address, true)
  end
end
