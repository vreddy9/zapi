require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_login_should_set_session
		actual = $zapi.login
		assert_not_equal(actual, nil)
	end

	def test_add_namespace
		actually = $zapi.add_namespace({key: 'value'})
		assert_equal(actually["ins1:key"], 'value')
	end
end