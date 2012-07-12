require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_product
		#create a product model
		actually = $zapi.product
		assert_not_equal(actually, nil)
	end

	#THERES A BUG IN THE API RIGHT NOW WHICH THROWS A DATA INTEGRITY VIOLATION 
	#ERROR INSTEAD OF TELLING YOU THE PRODUCT EXISITS WITH THE NAME
	def test_create_product
		actually = $zapi.product.create

		assert_not_equal(actually, false)
		prods = $zapi.product.where(id: actually)
		prods[0].delete
	end

	def test_update_product
		actually = $zapi.product.create
		prods = $zapi.product.where(id: actually)
		prods[0].set_fields(name: 'changed')
		update_res = prods[0].update
		assert_not_equal(update_res, false)
		prods[0].delete

	end
end