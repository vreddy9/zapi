require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_invoice
		#create an invoice model
		actually = $zapi.invoice
		assert_not_equal(actually, nil)
	end
end