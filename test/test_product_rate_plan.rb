require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_product_rate_plan
		#create a product rate plan model
		actually = $zapi.product_rate_plan
		assert_not_equal(actually, nil)
	end

	def test_create_product_rate_plan
		prod_id = $zapi.product.create
		prp = $zapi.product_rate_plan
		prp.set_fields(product_id: prod_id)
		actually = prp.create
		assert_not_equal actually, nil

		prods = $zapi.product.where(id: prod_id)
		prods[0].delete
	end

	def test_update_product_rate_plan

		prod_id = $zapi.product.create
		prp = $zapi.product_rate_plan
		prp.set_fields(product_id: prod_id)
		prp_id = prp.create
		prps = $zapi.product_rate_plan.where(id: prp_id)
		prps[0].set_fields(description: "testing update")
		update_res = prps[0].update
		assert_not_equal(update_res[:update_response][:result][:success], false)

		prods = $zapi.product.where(id: prod_id)
		prods[0].delete

	end
end