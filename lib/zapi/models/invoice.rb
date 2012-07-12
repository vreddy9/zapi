module Zapi
	class Models::Invoice < Models::Base


		def initialize
			super
			#the name of the Zuora Object
			self.object_name = "Invoice"

			#all the object fields
			self.fields = %w(Id AccountId AdjustmentAmount Amount AmountWithoutTax Balance Comments	
				CreatedById CreatedDate DueDate IncludesOneTime IncludesRecurring IncludesUsage
				InvoiceNumber LastEmailSentDate PaymentAmount PostedBy PostedDate RefundAmount RefundAmount
				RefundAmount Status TargetDate TaxAmount TaxExemptAmount TransferredToAccounting UpdatedById UpdatedDate)
			
			#read only fields
			self.read_only_fields = %w(Id AdjustmentAmount Amount AmountWithoutTax Balance 
				Comments CreatedBy CreatedById CreatedDate DueDate InvoiceNumber LastEmailSentDate
				PaymentAmount PostedBy PostedDate RefundAmount Source SourceId TaxAmount TaxExemptAmount
				UpdatedBy UpdatedDate)	
			setup_fields
			#TODO
			#make these set from a config file
			#self.custom_fields = %w(CustomField__c)
		end	
		
		define_attributes do
			wsdl :id, :account_id, :adjustment_amount, :amount, :amount_without_tax, :balance, :comments,	
				:created_by_id, :created_date, :due_date, :includes_one_time, :includes_one_time, :includes_usage, :includes_recurring,
				:invoice_number, :last_email_sent_date, :payment_amount, :posted_by, :posted_date, :refund_amount, :refund_amount,
				:refund_amount, :status, :target_date, :tax_amount, :tax_exempt_amount, :transferred_to_accounting, :updated_by_id,
				:updated_date
		end
	end
end
