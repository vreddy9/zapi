require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_product_rate_plan_charge_tier
		#create a product rate plan model
		actually = $zapi.product_rate_plan_charge_tier
		assert_not_equal actually, nil
	end
end