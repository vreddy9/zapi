module Zapi
	class Models::Payment < Models::Base
		#the name of the Zuora Object
		self.name = "Payment"

		#all the object fields
		self.fields = %w(AccountID AccountingCode Amount AppliedCreditBalanceAmount AppliedInvoiceAmount AuthTransactionId BankIdentificationNumber
			CancelledOn Comment CreatedById CreatedDate EffectiveDate GatewayOrderId GatewayResponse GatewayResponseCode GatewayState InvoiceId
			InvoiceNumber MarkedForSubmissionOn PaymentMethodID PaymentNumber ReferenceId RefundAmount SecondPaymentReferenceId SettledOn
			SoftDescriptor SoftDescriptorPhone Status SubmittedOn TransferredToAccounting Type UpdatedById UpdatedDate)
		
		#read only fields
		self.read_only_fields = %w(AccountingCode BankIdentificationNumber CancelledOn CreatedById CreatedDate
			GatewayResponse GatewayResponseCode GatewayState MarkedForSubmissionOn PaymentNumber RefundAmount 
			SecondPaymentReferenceId SettledOn SubmittedOn UpdatedById UpdatedDate)
		
		#TODO
		#make these set from a config file
		#self.custom_fields = %w(CustomField__c)
		
	end
end
