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

		define_attributes do
			wsdl :accounting_code, :charge_amount, :charge_date, :charge_description, :charge_name, :charge_number, :created_by_id,
				:created_date, :invoice_id, :processing_type, :product_description, :product_id, :product_name, :quantity,
				:rate_plan_charge_id, :rev_rec_code, :rev_rec_start_date, :rev_rec_trigger_condition, :service_end_date,
				:service_start_date, :sku, :subscription_id, :subscription_number, :tax_amount, :tax_code, :tax_exempt_amount,
				:unit_price, :uom, :updated_by_id, :updated_date
		end
	end
end
