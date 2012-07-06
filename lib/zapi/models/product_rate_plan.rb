module Zapi
	#represents a zuora product rate plan
	class Models::ProductRatePlan < Models::Base
		def initialize
			super

			#the name of the Zuora Object
			self.name = "ProductRatePlan"

			#all the object fields
			self.fields = %w(Id CreatedDate Description EffectiveStartDate EffectiveEndDate
				Name ProductId UpdatedById UpdatedDate) 
 
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
				name: 'test rate plan'
				
			)
		end		
	end
end
