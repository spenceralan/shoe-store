class UpdateShoes < ActiveRecord::Migration[5.1]
  def change
    remove_column :shoes, :price, :int
    add_column :shoes, :price, :decimal, precision: 15, scale: 2
  end
end
