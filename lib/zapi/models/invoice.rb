module Zapi
	class Models::Invoice < Models::Base


		def initialize
			super
			#the name of the Zuora Object
			self.name = "Invoice"

			#all the object fields
			self.fields = %w(Id AccountId AdjustmentAmount Amount AmountWithoutTax Balance Comments	
				CreatedById CreatedDate DueDate IncludesOneTime IncludesOneTime IncludesOneTime IncludesOneTime
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
		
	end
end
