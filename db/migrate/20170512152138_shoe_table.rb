ActiveRecord::Base.connection.execute('create extension if not exists "pgcrypto"')

class ShoeTable < ActiveRecord::Migration[5.1]
  def change
    create_table :shoes, id: :uuid do |s|
      s.column :name, :varchar
      s.column :price, :int
      s.column :store_id, :uuid
      s.timestamps
    end
  end
end
