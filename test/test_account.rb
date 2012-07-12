require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_account
		actually = $zapi.account
		assert_not_equal(actually, nil)
	end

	def test_create_query_update_delete_account
		#create an account
		actually = $zapi.account.create
		assert_not_equal(actually, false)
		#query account with id
		acc = $zapi.account.where(id: actually)
		assert_equal(acc[0].values[:id], actually)
		#update the account
		acc[0].set_fields(name: "updated")
		updateres = acc[0].update
		assert_not_equal(updateres, false)
		#delete the account
		delres = acc[0].delete
		assert_equal(delres[:delete_response][:result][:success], true)
	end
end