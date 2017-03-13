module StoreHelper
  include StoreIndexCounter

	def show_counter?
		counter > 5
	end
end
