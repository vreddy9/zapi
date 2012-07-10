require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper
	#TODO 
	#MAKE A PRODUCT WITH A PRODUCT RATE PLAN TO SUSBCRIBE TO
	def test_login_should_set_session
		
		actual = $zapi.login
		assert_not_equal(actual, nil)

	end

	def test_subscribe_to_xml
		create_product
		actually = $zapi.subscribe_to_xml($zapi.account, $zapi.contact, $zapi.subscription, $zapi.payment_method, $prp_id)

		assert_not_equal actually, nil
		remove_product
	end

	def test_subscribe
		create_product
		actually = $zapi.subscribe($zapi.account, $zapi.contact, $zapi.subscription, $zapi.payment_method, $prp_id)
		assert_equal actually[:subscribe_response][:result][:success], true
		#delete the account
		res = $zapi.account.where(id: actually[:subscribe_response][:result][:account_id])
		res[0].delete
		remove_product
	end

	def test_build_rate_plan_data
		create_product
		prp = $zapi.product_rate_plan.where(id: $prp_id)
		rpcs = Array.new
		rpcs << $zapi.product_rate_plan_charge
		rpcs << $zapi.product_rate_plan_charge
		actually = $zapi.build_rate_plan_data(prp, rpcs , nil, 'subscribe')
		remove_product

		assert_equal actually, 'some soap'

		
	end
end