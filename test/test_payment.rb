require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_payment
		#create an invoice item model
		actually = $zapi.payment
		assert_not_equal(actually, nil)
	end
end