require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper


	def test_query_update_subscription

		#helper method to create a subscription 
		$subscription_id = make_subscription

		query_res = $zapi.subscription.where(id: $subscription_id)
		sub = query_res[0]
		sub.set_fields(notes: 'hello i am setting this')
		update_res = sub.update
		assert_equal(update_res[:update_response][:result][:success], true)

		#helper method to remove the account with the susbcription
		remove_account_with_subscription
	end

end

