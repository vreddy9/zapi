module Zapi
	#represents a zuora account
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
			self.set_fields_query(

				term_type: 'EVERGREEN',
				contract_effective_date: DateTime.now.strftime("%Y-%m-%dT%H:%M:%S"),
				service_activation_date: DateTime.now.strftime("%Y-%m-%dT%H:%M:%S"),
				contract_acceptance_date: DateTime.now.strftime("%Y-%m-%dT%H:%M:%S")

			)
		end		
	end
end
