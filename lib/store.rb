class Shoe < ActiveRecord::Base
  has_many :stores_shoes
  has_many :shoes, through: :stores_shoes
  validates :name, length: { maximum: 100 }
end