module Zapi
	#represents a zuora export
	class Models::Export < Models::Base

		#the name of the Zuora Object
		
		def initialize
			super
			self.object_name = "Export"

			#all the object fields
			self.fields = %w(Id CreatedById CreatedDate Encrypted FileId Format Name Query Size Status StatusReason UpdatedDate UpdatedById)

			#read only fields
			self.read_only_fields = %w(CreatedById CreatedDate UpdatedDate UpdatedById Zip)
			
			#TODO
			#make these set from a config file
			#self.custom_fields = %w(CustomField__c)
			
			#setup the fields
			setup_fields

			#set the minimum required values
			self.format = "csv"
			self.query = "SELECT Id FROM Account"
			
		end
		#define_attributes
		define_attributes do
			wsdl :id, :created_by_id, :created_date, :encrypted, :file_id, :format, :name, :query, :size, :status, :status_reason, :updated_date, :updated_by_id
		end				
	end

end
