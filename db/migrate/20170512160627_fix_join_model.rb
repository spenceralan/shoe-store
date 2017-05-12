class FixJoinModel < ActiveRecord::Migration[5.1]
  def change
    rename_table :stores_shoes, :store_shoes
  end
end
