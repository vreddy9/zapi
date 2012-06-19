require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper
	#TODO 
	#REPLACE WITH THE id from a subscribe call
	$subscription_id = '4028e69637d27d5101380113916c1ea8'

	def test_query_subscription
		query_res = $zapi.subscription.where(id: $subscription_id)
		sub = query_res[0]
		assert_equal(sub.values[:id], $subscription_id)
	end

	def test_update_subscription
		query_res = $zapi.subscription.where(id: $subscription_id)
		sub = query_res[0]
		sub.set_fields(notes: 'hello i am setting this')
		update_res = sub.update
		assert_equal(update_res[:update_response][:result][:success], true)
	end
end

