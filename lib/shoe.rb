class Shoe < ActiveRecord::Base
  has_many :store_shoes
  has_many :stores, through: :store_shoes
  validates :name, length: { maximum: 100 }
end
