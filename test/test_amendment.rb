require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_amendment
		actually = $zapi.amendment
		assert_not_equal(actually, nil)
	end

	#add new product
	def test_create_amendment

		create_product
		acc = $zapi.account
		subres = $zapi.subscribe(acc , $zapi.contact, $zapi.subscription, $zapi.payment_method, $prp_id)
		

		actually = $zapi.amend(acc, subres, $prp_id)
		
		assert_not_equal(actually, nil)
		#clear the created stuff
		remove_account_with_subscription
	end

end
