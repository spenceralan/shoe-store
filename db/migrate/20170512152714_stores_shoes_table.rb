class StoresShoesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :stores_shoes, id: :uuid do |s|
      s.column :store_id, :uuid
      s.column :shoe_id, :uuid
      s.timestamps
    end
  end
end
