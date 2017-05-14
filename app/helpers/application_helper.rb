module ApplicationHelper
	def hidden_div_if(condition, attributes = {}, &block)
		if condition
			puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			attributes["style"] = "display: none"
		else
			puts "-----------------"
		end
		content_tag("div", attributes, &block)
	end
end
