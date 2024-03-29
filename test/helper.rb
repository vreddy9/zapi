require 'test/unit'
require 'zapi'

module ZapiTestHelper
	$zapi = Zapi::Session.new(username: 'smogger914@yahoo.com', password: 'Fo!d3168')
	$zapi.login


	def create_product
		$prod_id = $zapi.product.create
		prp = $zapi.product_rate_plan
		prp.product_id = $prod_id
		$prp_id = prp.create

		prpc = $zapi.product_rate_plan_charge
		prpc.product_rate_plan_id = $prp_id
		tiers = Array.new
		tiers << $zapi.product_rate_plan_charge_tier
		$charge_id = prpc.create_complex(tiers)
		
		$prp_id
	end

	def remove_product
		qres = $zapi.product.where(id: $prod_id)
		qres[0].delete
	end

	def make_subscription
		create_product
		prp = $zapi.product_rate_plan.where(id: $prp_id)
		rpcs = Array.new
		qres = $zapi.product_rate_plan_charge.where(id: $charge_id)
		rpcs << qres[0]
		subres = $zapi.subscribe($zapi.account, $zapi.contact, $zapi.subscription, $zapi.payment_method, nil, nil, prp, rpcs , nil, 'subscribe')
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