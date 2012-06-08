require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_login_should_set_session
		actual = $zapi.login
		assert_not_equal(actual, nil)
	end

	def test_query_should_return_response
		actually = $zapi.query('SELECT Id, Name FROM Account')
		assert_not_equal(actually,nil)
	end
end