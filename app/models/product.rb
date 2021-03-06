class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_lien_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)}i,
    message: 'gif or jpg or png'
  }

  private
    def ensure_not_referenced_by_any_line_item
      if line_items_empty?
        return true
      else
        errors.add(:base, '')
        return false
      end
    end
end
