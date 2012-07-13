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
		actually = $zapi.subscribe_to_xml($zapi.account, $zapi.contact, $zapi.subscription, $zapi.payment_method, $prp_id, nil, nil)

		assert_not_equal actually, nil
		remove_product
	end

	def test_subscribe
		create_product
		prp = $zapi.product_rate_plan.where(id: $prp_id)
		rpcs = Array.new
		qres = $zapi.product_rate_plan_charge.where(id: $charge_id)
		rpcs << qres[0]
		actually = $zapi.subscribe($zapi.account, $zapi.contact, $zapi.subscription, $zapi.payment_method,nil, nil, prp, rpcs , nil, 'subscribe')
		assert_equal actually[:subscribe_response][:result][:success], true
		#delete the account
		res = $zapi.account.where(id: actually[:subscribe_response][:result][:account_id])
		#res[0].delete
		remove_product
	end

	def test_build_rate_plan_data
		create_product
		prp = $zapi.product_rate_plan.where(id: $prp_id)
		rpcs = Array.new
		qres = $zapi.product_rate_plan_charge.where(id: $charge_id)
		rpcs << qres[0]
		actually = $zapi.build_rate_plan_data(prp, rpcs , nil, 'subscribe')
		remove_product

		assert_not_equal(actually, nil)	
	end

	def test_subscribe_with_rateplan_data_to_xml
		create_product
		prp = $zapi.product_rate_plan.where(id: $prp_id)
		rpcs = Array.new
		qres = $zapi.product_rate_plan_charge.where(id: $charge_id)
		rpcs << qres[0]
		#rate_plan_data = $zapi.build_rate_plan_data(prp, rpcs , nil, 'subscribe')
		remove_product

		actually = $zapi.subscribe_with_rateplan_data_to_xml($zapi.account, $zapi.contact, $zapi.subscription, $zapi.payment_method,nil, nil, prp, rpcs , nil, 'subscribe')
		assert_not_equal actually, nil
	end
end


