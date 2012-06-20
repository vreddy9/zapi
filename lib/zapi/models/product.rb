module Zapi
	#represents a zuora product
	class Models::Product < Models::Base
		def initialize
			super

			#the name of the Zuora Object
			self.name = "Product"

			#all the object fields
			self.fields = %w(Id Category CreatedDate Description EffectiveStartDate EffectiveEndDate
				Name SKU UpdatedById UpdatedDate) 
 
			#read only fields
			self.read_only_fields = %w(CreatedById CreatedDate UpdatedById UpdatedDate)
		
			#TODO
			#make these set from a config file
			#self.custom_fields = %w()

			setup_fields
			#set the minimum required values
			
			start_time = Time.new(2000, 1, 1)
			end_time = Time.new(2050, 1, 1)

			self.set_fields_query(

				effective_start_date: start_time.strftime("%Y-%m-%dT%H:%M:%S"),
				effective_end_date: end_time.strftime("%Y-%m-%dT%H:%M:%S"),
				name: 'sup'
				
			)
		end		
	end
end
