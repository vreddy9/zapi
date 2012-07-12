module Zapi
	#represents a zuora account
	class Models::Usage < Models::Base

		#the name of the Zuora Object
		
		def initialize
			super
			self.object_name = "Usage"

			#all the object fields
			self.fields = %w(Id AccountId AccountNumber AncestorAccountId ChargeId ChargeNumber CreatedById CreatedDate Description EndDateTime
				ImportId Quantity RbeStatus SourceName SourceType StartDateTime SubmissionDateTime SubscriptionId SubscriptionNumber UOM
				UpdatedById UpdatedDate)

			#read only fields
			self.read_only_fields = %w(AncestorAccountId CreatedById CreatedDate RbeStatus SourceName SourceType UpdatedById UpdatedDate)
			
			#TODO
			#make these set from a config file
			#self.custom_fields = %w(CustomField__c)
			self.non_query_fields = %w(AncestorAccountId)
			#setup the fields
			setup_fields

			#set the minimum required values
			self.uom = 'Each'
			self.start_date_time = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S")
			self.quantity = 1

		end
		#define_attributes
		define_attributes do
			wsdl :id, :account_id, :account_number, :ancestor_account_id, :charge_id, :charge_number, :created_by_id, :created_date, 
			:description, :end_date_time, :import_id, :quantity, :rbe_status, :source_name, :source_type, :start_date_time, 
			:submission_date_time, :subscription_id, :subscription_number, :uom, :updated_by_id, :updated_date
		end				
	end

end
