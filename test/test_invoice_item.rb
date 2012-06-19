require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_invoice_item
		#create an invoice item model
		actually = $zapi.invoice_item
		assert_not_equal(actually, nil)
	end
end