module Zapi
	#represents a zuora product rate plan charge tier
	class Models::ProductRatePlanChargeTier < Models::Base
		def initialize
			super

			#the name of the Zuora Object
			self.name = "ProductRatePlanChargeTier"

			#all the object fields
			self.fields = %w(Id Active CreatedById CreatedDate Currency EndingUnit IsOveragePrice
				Price PriceFormat ProductRatePlanChargeId StartingUnit Tier UpdatedById UpdatedDate
				) 
 
			#read only fields
			self.read_only_fields = %w(CreatedById CreatedDate EndingUnit Currency
				IsOveragePrice StartingUnit Tier UpdatedById UpdatedDate)
		
			#TODO
			#make these set from a config file
			#self.custom_fields = %w()

			setup_fields
			#set the minimum required values
			
			start_time = Time.new(2000, 1, 1)
			end_time = Time.new(2050, 1, 1)

			self.set_fields_query(

				active: true,
				currency: 'USD',
				price: 1,
				
			)
		end		
	end
end
