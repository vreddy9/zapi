require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_product_rate_plan_charge
		#create a product rate plan model
		actually = $zapi.product_rate_plan_charge
		assert_not_equal actually, nil
	end

	def test_create_product_rate_plan_charge
		prod_id = $zapi.product.create
		prp = $zapi.product_rate_plan
		prp.set_fields(product_id: prod_id)
		prp_id = prp.create

		prpc = $zapi.product_rate_plan_charge
		prpc.set_fields(product_rate_plan_id: prp_id)
		tiers = Array.new
		tiers << $zapi.product_rate_plan_charge_tier
		actually = prpc.create_complex(tiers)
		assert_not_equal actually, nil


		prods = $zapi.product.where(id: prod_id)
		prods[0].delete
	end

	def test_update_product_rate_plan_charge
		#product
		prod_id = $zapi.product.create
		#rate_plan
		prp = $zapi.product_rate_plan
		prp.set_fields(product_id: prod_id)
		prp_id = prp.create
		#charge
		prpc = $zapi.product_rate_plan_charge
		prpc.set_fields(product_rate_plan_id: prp_id)
		tiers = Array.new
		tiers << $zapi.product_rate_plan_charge_tier
		
		prpc_id = prpc.create_complex(tiers)
		prpcs =  $zapi.product_rate_plan_charge.where(id: prpc_id)

		prpcs[0].set_fields(name: "hi")
		update_res = prpcs[0].update
		assert_not_equal(update_res[:update_response][:result][:success], false)

		prods = $zapi.product.where(id: prod_id)
		prods[0].delete

	end
end