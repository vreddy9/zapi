module Zapi
	#represents a zuora subscription
	class Models::Subscription < Models::Base
		#the name of the Zuora Object


		def initialize
			super

			self.object_name = "Subscription"

			#all the object fields
			self.fields = %w( Id AccountId AutoRenew CancelledDate ContractAcceptanceDate
				ContractEffectiveDate CreatedById CreatedDate CreatorAccountId CreatorInvoiceOwnerId
				InitialTerm InvoiceOwnerId IsInvoiceSeparate Name Notes OriginalCreatedDate OriginalId
				PreviousSubscriptionId RenewalTerm ServiceActivationDate Status
				SubscriptionEndDate SubscriptionStartDate TermEndDate TermStartDate TermType 
				UpdatedById UpdatedDate Version ) 
	 
			#read only fields
			self.read_only_fields = %w( CreatedById CreatedDate CreatorAccountId CreatorInvoiceOwnerId 
				SubscriptionEndDate SubscriptionStartDate TermStartDate TermEndDate UpdatedById UpdatedDate
				OriginalCreatedDate OriginalId OriginalSubscriptionId PreviousSubscriptionId 
				Version Status )
			
			#TODO
			#make these set from a config file
			#self.custom_fields = %w()

			setup_fields
			#set the minimum required values

			self.term_type = 'EVERGREEN'
			self.contract_effective_date = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S")
			self.service_activation_date = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S")
			self.contract_acceptance_date = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S")

			
		end
		define_attributes do
			wsdl :id, :account_id, :auto_renew, :cancelled_date, :contract_acceptance_date, :contract_effective_date, :created_by_id, :created_date,
			:creator_account_id, :creator_invoice_owner_id, :initial_term, :invoice_owner_id, :is_invoice_separate, :name, :notes, :original_created_date,
			:original_id, :previous_subscription_id, :renewal_term, :service_activation_date, :status, :subscription_end_date, :subscription_start_date,
			:term_end_date, :term_start_date, :term_type, :updated_by_id, :updated_date, :version
		end		
	end
end
