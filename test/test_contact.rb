require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_create_query_update_delete_contact
		#create an account
		accid = $zapi.account.create
		#query account with id
		acc = $zapi.account.where(id: accid)
		#create a contact for that account
		con = $zapi.contact
		con.set_fields(account_id: acc[0].values["Id"])
		actually = con.create
		assert_not_equal(actually, false)
		#query the contact
		con = $zapi.contact.where(id: actually)
		assert_equal(con[0].values["Id"], actually)
		#update the contact
		con[0].set_fields(county: 'someplace')
		updateres = con[0].update
		assert_not_equal(updateres, false)
		#delete the contact
		delres = con[0].delete
		assert_not_equal(delres, false)
		#delete the account
		delres = acc[0].delete
	end
end