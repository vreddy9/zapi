module Zapi
	#represents a zuora contact
	class Models::Contact < Models::Base
		def initialize
			super

			#the name of the Zuora Object
			self.name = "Contact"

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
			self.set_fields_query(

				first_name: 'Donald',
				last_name: 'Duck',
				address1: 'test address',
				work_email: 'test@test.com',
				country: 'us',
				state: 'ca'

			)
		end		
	end
end
