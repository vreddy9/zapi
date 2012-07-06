require 'test/unit'
require 'zapi'

module ZapiTestHelper
	$zapi = Zapi::Session.new(username: 'smogger914@yahoo.com', password: 'Fo!d3168')
	$zapi.login
	$prp_id
	def subscribe_subscription_id

	end

	def create_product
		$prod_id = $zapi.product.create
		prp = $zapi.product_rate_plan
		prp.set_fields(product_id: $prod_id)
		$prp_id = prp.create

		prpc = $zapi.product_rate_plan_charge
		prpc.set_fields(product_rate_plan_id: $prp_id)
		tiers = Array.new
		tiers << $zapi.product_rate_plan_charge_tier
		charge = prpc.create_complex(tiers)
		
		$prp_id
	end

	def remove_product
		qres = $zapi.product.where(id: $prod_id)
		qres[0].delete
	end
end