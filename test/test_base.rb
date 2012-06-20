require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_underscore_string
		base = Zapi::Models::Account.new
		actually = base.underscore("TestThis")
		assert_equal(actually, "test_this")
	end

	def test_make_query_string
		base = Zapi::Models::Account.new
		actually = base.make_query_string
		assert_equal(actually, "SELECT Id, AccountNumber, AdditionalEmailAddresses, AllowInvoiceEdit, AutoPay, Balance, Batch, BcdSettingOption, BillCycleDay, BillToId, CreatedById, CreatedDate, CrmId, Currency, CustomerServiceRepName, DefaultPaymentMethodId, InvoiceDeliveryPrefsEmail, InvoiceDeliveryPrefsPrint, InvoiceTemplateId, LastInvoiceDate, Name, Notes, PaymentGateway, PaymentTerm, PurchaseOrderNumber, SalesRepName, SoldToId, Status, UpdatedById, UpdatedDate, CustomField__c FROM Account")
	end

	def test_is_read_only
		base = Zapi::Models::Account.new
		actually = base.is_read_only('UpdatedById')
		assert_equal(actually, true)
	end

	def test_to_xml
		base = Zapi::Models::Account.new
		actually = base.to_xml('create')
		assert_equal(actually, "<ins0:zObjects xsi:type=\"ins1:Account\"><ins1:Name>test account</ins1:Name><ins1:PaymentTerm>Net 30</ins1:PaymentTerm><ins1:Currency>USD</ins1:Currency><ins1:BillCycleDay>1</ins1:BillCycleDay><ins1:Batch>Batch1</ins1:Batch><ins1:Status>Draft</ins1:Status></ins0:zObjects>")
	end

	def test_find_field
		base = Zapi::Models::Account.new
		actually = base.find_field(:name)
		assert_equal(actually, 'Name')
	end

	def test_set_fields
		base = Zapi::Models::Account.new
		base.set_fields(name: 'testing')
		actually = base.values[:name]
		assert_equal(actually, 'testing')
	end
end