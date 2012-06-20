require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_login_should_set_session
		actual = $zapi.login
		assert_not_equal(actual, nil)
	end

	def test_subscribe
		res = $zapi.subscribe_xml($zapi.account,$zapi.contact, $zapi.subscription, $zapi.payment_method)
		assert_not_equal(res, nil)
	end
end