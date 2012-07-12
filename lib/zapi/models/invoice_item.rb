module Zapi
	class Models::InvoiceItem < Models::Base

		def initialize
			super
			#the name of the Zuora Object
			self.object_name = "InvoiceItem"

			#all the object fields
			self.fields = %w(AccountingCode ChargeAmount ChargeDate ChargeDescription ChargeName ChargeNumber CreatedById
				CreatedDate InvoiceId ProcessingType ProductDescription ProductId ProductName Quantity RatePlanChargeId
				RevRecCode RevRecStartDate RevRecTriggerCondition ServiceEndDate ServiceStartDate SKU SubscriptionId 
				SubscriptionNumber TaxAmount TaxCode TaxExemptAmount UnitPrice UOM UpdatedById UpdatedDate)
			
			#read only fields
			self.read_only_fields = %w(AccountingCode ChargeAmount ChargeDate ChargeDescription ChargeName ChargeNumber CreatedById
				CreatedDate InvoiceId ProcessingType ProductDescription ProductId ProductName Quantity RatePlanChargeId
				RevRecCode RevRecStartDate RevRecTriggerCondition ServiceEndDate ServiceStartDate SKU SubscriptionId 
				SubscriptionNumber TaxAmount TaxCode TaxExemptAmount UnitPrice UOM UpdatedById UpdatedDate)
			
			#TODO
			#make these set from a config file
			#self.custom_fields = %w(CustomField__c)

			setup_fields
		end
	end
end
