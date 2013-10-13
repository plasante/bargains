module CurrentCart
  extend ActiveSupport::Concern
  
  private
  
    # To share common code between controllers.
    # Prevents Rails from ever making it available as an action.
    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
end