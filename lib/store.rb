class Store < ActiveRecord::Base
  has_many :store_shoes
  has_many :shoes, through: :store_shoes
  validates :name, length: { maximum: 100 },
    presence: :true,
    uniqueness: :true

  before_validation :capitalize_title

  private

  def capitalize_title
    self.name = name.split.map(&:capitalize).join(" ")
  end

end