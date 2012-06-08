module Zapi
	class Models::Invoice < Models::Base
		self.fields = %w(Id AccountId Amount Balance Comments 
			DueDate InvoiceDate InvoiceNumber 
			LastEmailSentDate PaymentAmount PostedDate 
			RefundAmount Status TargetDate)
		
		self.name = 'Invoice'
		
	end
end
