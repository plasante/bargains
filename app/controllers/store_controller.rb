class StoreController < ApplicationController
  def index
    # To list the products by title
    @products = Product.order(:title)
  end
end
