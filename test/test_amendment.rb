require 'helper'

class ZapiTest < Test::Unit::TestCase
	include ZapiTestHelper

	def test_new_amendment
		actually = $zapi.amendment
		assert_not_equal(actually, nil)
	end

	#add new product
	def test_create_amendment

		create_product
		acc = $zapi.account
		subres = $zapi.subscribe(acc , $zapi.contact, $zapi.subscription, $zapi.payment_method, $prp_id)
		

		actually = $zapi.session.amend(acc, subres, $prp_id)
		
		assert_not_equal(actually, nil)
		#clear the created stuff
		remove_account_with_subscription
	end

end

if false
<ns1:create>
 <ns1:zObjects xsi:type="ns2:Amendment">
   <ns2:AutoRenew></ns2:AutoRenew>
   <ns2:Code></ns2:Code>
   <ns2:ContractEffectiveDate></ns2:ContractEffectiveDate>
   <ns2:CreatedById></ns2:CreatedById>
   <ns2:CreatedDate></ns2:CreatedDate>
   <ns2:CustomerAcceptanceDate></ns2:CustomerAcceptanceDate>
   <ns2:Description></ns2:Description>
   <ns2:DestinationAccountId></ns2:DestinationAccountId>
   <ns2:DestinationInvoiceOwnerId></ns2:DestinationInvoiceOwnerId>
   <ns2:EffectiveDate></ns2:EffectiveDate>
   <ns2:InitialTerm></ns2:InitialTerm>
   <ns2:Name></ns2:Name>
   <ns2:RatePlanData></ns2:RatePlanData>
   <ns2:RenewalTerm></ns2:RenewalTerm>
   <ns2:ServiceActivationDate></ns2:ServiceActivationDate>
   <ns2:Status></ns2:Status>
   <ns2:SubscriptionId></ns2:SubscriptionId>
   <ns2:TermStartDate></ns2:TermStartDate>
   <ns2:TermType></ns2:TermType>
   <ns2:Type></ns2:Type>
   <ns2:UpdatedById></ns2:UpdatedById>
   <ns2:UpdatedDate></ns2:UpdatedDate>
 </ns1:zObjects>
</ns1:create>
end