class Product < ActiveRecord::Base
  has_many :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  # To check that those fields are not null or empty ""
  validates :title, :description, :image_url, presence: true
  
  # To check that price is at least 1 cent
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  
  validates :title, uniqueness: true
  
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  
  def self.latest
    Product.order(:updated_at).last
  end
  
  private
  
    # ensure that there are no line items referencing this product
    # This method is called before Rails attempts to destroy a row.
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true               # The row will be destroyed
      else
        errors.add(:base, 'Line Items present')
        return false              # The row will not be destroyed
      end
    end
end
