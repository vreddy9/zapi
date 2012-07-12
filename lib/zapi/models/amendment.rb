module Zapi
	#represents a zuora account
	class Models::Amendment < Models::Base
		#the name of the Zuora Object

		def initialize
			super
			self.object_name = "Amendment"

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
			self.name = 'test amend'
			self.contract_effective_date = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S")
			self.service_activation_date = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S")
			self.customer_acceptance_date = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S")
			self.type = 'NewProduct'

			
		end		
		#define_attributes
		define_attributes do
			wsdl :auto_renew, :code, :contract_effective_date, :created_by_id, :created_date, 
				:customer_acceptance_date, :description, :destination_account_id, :effective_date, 
				:initial_term, :name, :rate_plan_data, :renewal_term, :service_activation_date, :status,
				:subscription_id, :term_start_date, :term_type, :type, :updated_by_id, :updated_date
		end	
	end
end
