require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_amendment
		actually = $zapi.amendment
		assert_not_equal(actually, nil)
	end

end