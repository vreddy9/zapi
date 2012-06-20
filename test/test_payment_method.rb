require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_payment_method
		actually = $zapi.payment_method
		assert_not_equal(actually, nil)
	end

	def test_create_new_payment_method_with_account
		acc_id = $zapi.account.create
		pm = $zapi.payment_method
		pm.set_fields(account_id: acc_id)
		actually = pm.create
		assert_not_equal(actually, false)
		acc = $zapi.account.where(id: acc_id)
		acc[0].delete
	end
end