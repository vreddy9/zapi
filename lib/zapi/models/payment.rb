module Zapi
	class Models::Payment < Models::Base

		def initialize
			super
			#the name of the Zuora Object
			self.object_name = "Payment"

			#all the object fields
			self.fields = %w(AccountId AccountingCode Amount AppliedCreditBalanceAmount AppliedInvoiceAmount AuthTransactionId BankIdentificationNumber
				CancelledOn Comment CreatedById CreatedDate EffectiveDate GatewayOrderId GatewayResponse GatewayResponseCode GatewayState InvoiceId
				InvoiceNumber MarkedForSubmissionOn PaymentMethodID PaymentNumber ReferenceId RefundAmount SecondPaymentReferenceId SettledOn
				SoftDescriptor SoftDescriptorPhone Status SubmittedOn TransferredToAccounting Type UpdatedById UpdatedDate)
			
			#read only fields
			self.read_only_fields = %w(AccountingCode BankIdentificationNumber CancelledOn CreatedById CreatedDate
				GatewayResponse GatewayResponseCode GatewayState MarkedForSubmissionOn PaymentNumber RefundAmount 
				SecondPaymentReferenceId SettledOn SubmittedOn UpdatedById UpdatedDate)
			
			self.non_query_fields = %w(AppliedInvoiceAmount InvoiceId InvoiceNumber)
			#TODO
			#make these set from a config file
			#self.custom_fields = %w(CustomField__c)
			setup_fields
		end

		#define_attributes
		define_attributes do
			wsdl :account_id, :accounting_code, :amount, :applied_credit_balance_amount, :applied_invoice_amount, :auth_transaction_id,
			:bank_identification_number, :cancelled_on, :comment, :created_by_id, :created_date, :effective_date, :gateway_order_id,
			:gateway_response,:gateway_response_code,:gateway_state,:invoice_id,:invoice_number, :marked_for_submission_on, :payment_method_id,
			:payment_number, :reference_id,:refund_amount,:second_payment_reference_id, :settled_on, :soft_descriptor, :soft_descriptor_phone,
			:status, :submitted_on, :transferred_to_accounting, :type, :updated_by_id, :updated_date
		end	
	end
end
