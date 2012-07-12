require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_export
		actually = $zapi.export
		assert_not_equal(actually, nil)
	end

	def test_create_query_delete_export
		actually = $zapi.export.create
		
		qres = $zapi.export.where(id: actually)
		qres[0].delete

		assert_not_equal(actually, false)
	end
end