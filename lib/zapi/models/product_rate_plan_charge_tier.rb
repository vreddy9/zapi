module Zapi
	#represents a zuora product rate plan charge tier
	class Models::ProductRatePlanChargeTier < Models::Base
		def initialize
			super

			#the name of the Zuora Object
			self.object_name = "ProductRatePlanChargeTier"

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

			self.active = true
			self.currency = 'USD'
			self.price = 1
				
			
		end
		define_attributes do	
			wsdl :id, :active, :created_by_id, :created_date, :currency, :ending_unit, :is_overage_price, :price, :price_format,
			:product_rate_plan_charge_id, :starting_unit, :tier, :updated_by_id, :updated_date
		end
	end
end
