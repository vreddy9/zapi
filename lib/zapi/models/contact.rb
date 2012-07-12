module Zapi
	#represents a zuora contact
	class Models::Contact < Models::Base
		def initialize
			super

			#the name of the Zuora Object
			self.object_name = "Contact"

			#all the object fields
			self.fields = %w(Id AccountId Address1 Address2 City Country County CreatedById CreatedDate 
				Description Fax FirstName HomePhone LastName MobilePhone NickName OtherPhone
				OtherPhoneType PersonalEmail PostalCode State TaxRegion UpdatedById UpdatedDate WorkEmail WorkPhone) 
 
			#read only fields
			self.read_only_fields = %w(CreatedById CreatedDate UpdatedById UpdatedDate)
		
			#TODO
			#make these set from a config file
			#self.custom_fields = %w()

			setup_fields
			#set the minimum required values
			self.first_name = 'Donald'
			self.last_name = 'Duck'
			self.address1 = 'test address'
			self.work_email = 'test@test.com'
			self.country = 'us'
			self.state = 'ca'

			
		end		
		define_attributes do
			wsdl :id, :account_id, :address1, :address2, :city, :country, :county, :created_by_id, :created_date, 
				:description, :fax, :first_name, :home_phone, :last_name, :mobile_phone, :nick_name, :other_phone,
				:other_phone_type, :personal_email, :postal_code, :state, :tax_region, :updated_by_id, :updated_date, 
				:work_email, :work_phone
		end
	end		
end
