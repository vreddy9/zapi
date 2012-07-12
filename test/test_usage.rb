require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_usage
		actually = $zapi.usage
		assert_not_equal(actually, nil)
	end

	def test_create_query_delete_usage
		make_subscription

		usage = $zapi.usage
		usage.account_id = $account_id
		actually = usage.create
		assert_not_equal(actually, false)

		qres = $zapi.usage.where(id: actually)
		assert_not_equal(qres, nil)
		usage = qres[0]
		actually = usage.delete
		assert_not_equal actually, false

		remove_account_with_subscription

	end
end
