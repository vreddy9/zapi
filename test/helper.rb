require 'test/unit'
require 'zapi'

module ZapiTestHelper
	$zapi = Zapi::Session.new(username: 'smogger914@yahoo.com', password: 'Fo!d3168')
	$zapi.login

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

	def make_subscription
		create_product
		subres = $zapi.subscribe($zapi.account, $zapi.contact, $zapi.subscription, $zapi.payment_method, $prp_id)
		$account_id = subres[:subscribe_response][:result][:account_id]
		subres[:subscribe_response][:result][:subscription_id]

	end

	def remove_account_with_subscription
		#delete the account
		qres = $zapi.account.where(id: $account_id)
		qres[0].delete
		remove_product
	end
end