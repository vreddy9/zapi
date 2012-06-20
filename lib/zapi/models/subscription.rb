module Zapi
	#represents a zuora account
	class Models::Subscription < Models::Base
		#the name of the Zuora Object


		def initialize
			super

			self.name = "Subscription"

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

				term_type: 'EVERGREEN'
				#contract_acceptance_date: 

			)
		end		
	end
end
