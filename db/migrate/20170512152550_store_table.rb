class StoreTable < ActiveRecord::Migration[5.1]
  def change
    create_table :stores, id: :uuid do |s|
      s.column :name, :varchar
      s.timestamps
    end
  end
end
