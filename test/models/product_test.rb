require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
	# test "the truth" do
	#   assert true
	# end
	test "product attributes must not be empty" do
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end

	test "product price must be positive" do
		product = Product.new(
			title:       "My Book Title",
			description: "abc",
			image_url:   "abc.jpg"
		)

		product.price = -1
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
		
		product.price = 0
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

		product.price = 1
		assert product.valid?
	end

	def new_product_by_image(image_url)
		Product.new(
			title:       "My Book Title",
			description: "abc",
			image_url:   image_url,
			price:       1
		)
	end

	test "image url" do
		ok  = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
		bad = %w{ fred.doc fred.gif/more fred.gef.more }

		ok.each do |img|
			assert new_product_by_image(img).valid?, "#{img} shouldn't be invalid"
		end

		bad.each do |img|
			assert new_product_by_image(img).invalid?, "#{img} shouldn't be valid"
		end
	end

	test "product is not valid without a unique title" do
		product = Product.new(
				title: products(:ruby).title,
				description: "abc",
				price: 1,
				image_url: "fred.gif"
		)
		assert product.invalid?
		assert_equal ["has already been taken"], product.errors[:title]
	end

	# test "product is not valid without a unique title - i18n" do
	# 	product = Product.new(
	# 		title:       products(:ruby).title,
	# 		description: "abc",
	# 		price:       1,
	# 		image_url:   "fred.gif"
	# 	)
	# 	assert product.invalid?
	# 	assert_equal [I18n.translate('activerecord.errors.messages.taken')], product.errors[:title]
	# end
	
	def new_product_by_title(title)
		Product.new(
			title:       title,
			description: "abc",
			image_url:   "fred.gif",
			price:       1
		)
	end

	test "product title length must be more than 10" do
		ok  = [ "Really long title", "Still more than ten", "TenSimbols" ]
		bad = ["", "ShortName" ]

		ok.each do |title|
			assert new_product_by_title(title).valid?, "#{title} shouldn't be invalid"
		end

		bad.each do |title|
			assert new_product_by_title(title).invalid?, "#{title} shouldn't be valid"
		end

	end
end
