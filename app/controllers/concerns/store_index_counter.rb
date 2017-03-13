module StoreIndexCounter
  extend ActiveSupport::Concern

  def counter
    session[:counter]
  end

  private

    def index_counter_increment
      reset_counter unless session[:counter]
      session[:counter] += 1
      puts session[:counter]
    end

    def reset_counter
      session[:counter] = 0
    end
end