require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_product
		#create a product model
		actually = $zapi.product
		assert_not_equal(actually, nil)
	end

	#THERES A BUG IN THE API RIGHT NOW WHICH THROWS A DATA INTEGRITY VIOLATION 
	#ERROR INSTEAD OF TELLING YOU THE PRODUCT EXISITS
	def test_create_product
		actually = $zapi.product.create
		assert_not_equal(actually, false)

		prod = $zapi.product.where(id: actually)
		prod[0].delete
	end
end