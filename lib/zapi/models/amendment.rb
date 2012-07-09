module Zapi
	#represents a zuora account
	class Models::Amendment < Models::Base
		#the name of the Zuora Object

		def initialize
			super
			self.name = "Amendment"

			#all the object fields
			self.fields = %w(AutoRenew Code ContractEffectiveDate CreatedById CreatedDate 
				CustomerAcceptanceDate Description DestinationAccountId EffectiveDate 
				InitialTerm Name RatePlanData RenewalTerm ServiceActivationDate Status
				SubscriptionId TermStartDate TermType Type UpdatedById UpdatedDate)

			#read only fields
			self.read_only_fields = %w( Id CreatedById CreatedDate UpdatedById UpdatedDate	)
			
			self.non_query_fields = %w(RatePlanData)

			#TODO
			#make these set from a config file
			#self.custom_fields = %w(CustomField__c)
			
			#setup the fields
			setup_fields

			#set the minimum required values
			set_fields_query(

				name: 'test amend',
				contract_effective_date: DateTime.now.strftime("%Y-%m-%dT%H:%M:%S"),
				service_activation_date: DateTime.now.strftime("%Y-%m-%dT%H:%M:%S"),
				contract_acceptance_date: DateTime.now.strftime("%Y-%m-%dT%H:%M:%S"),
				type: 'NewProduct'

			)
		end		
	end
end
