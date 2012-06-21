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
		actually = $zapi.subscribe_to_xml($zapi.account, $zapi.contact, $zapi.subscription, $zapi.payment_method, '4028e6973467ae5801347c838a8354f3')
		assert_not_equal actually, nil
	end

	def test_subscribe
		actually = $zapi.subscribe($zapi.account, $zapi.contact, $zapi.subscription, $zapi.payment_method, '4028e6973467ae5801347c838a8354f3')
		assert_equal actually[:subscribe_response][:result][:success], true
		#delete the account
		res = $zapi.account.where(id: actually[:subscribe_response][:result][:account_id])
		res[0].delete
	end
end