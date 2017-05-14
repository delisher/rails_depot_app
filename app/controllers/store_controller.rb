class StoreController < ApplicationController
  include CurrentCart, StoreIndexCounter

  before_action :set_cart
  before_action :index_counter_increment, only: [:index]

  def index
    @products = Product.order(:title)
  end

end
