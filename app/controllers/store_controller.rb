class StoreController < ApplicationController
  include StoreIndexCounter

  before_action :index_counter_increment, only: [:index]

  def index
    @products = Product.order(:title)
  end

end
