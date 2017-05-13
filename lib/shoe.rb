class Shoe < ActiveRecord::Base
  has_many :store_shoes
  has_many :stores, through: :store_shoes
  validates :name, length: { maximum: 100 },
    presence: :true,
    uniqueness: :true
  validates :price, numericality: true

  before_validation :capitalize_title

  private

  def capitalize_title
    if name.present?
      self.name = name.split.map(&:capitalize).join(" ")
    end
  end

end

# Numeric method from https://www.ruby-forum.com/topic/89085

class Numeric
  def to_currency( pre_symbol='$', thousands=',', decimal='.',
post_symbol=nil )
    "#{pre_symbol}#{
      ( "%.2f" % self ).gsub(
        /(\d)(?=(?:\d{3})+(?:$|\.))/,
        "\\1#{thousands}"
      )
    }#{post_symbol}"
  end
end