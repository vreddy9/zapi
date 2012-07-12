module Zapi
	#represents a zuora product rate plan charge
	class Models::ProductRatePlanCharge < Models::Base
		attr_accessor :product_rate_plan_charge_tier_data

		def initialize
			super

			#the name of the Zuora Object
			self.object_name = "ProductRatePlanCharge"

			#all the object fields
			self.fields = %w(Id AccountingCode BillCycleDay BillCycleType BillingPeriod BillingPeriodAlignment
				ChargeModel ChargeType CreatedById CreatedDate DefaultQuantity Description IncludedUnits
				MaxQuantity MinQuantity Name NumberOfPeriod OverageCalculationOption OverageUnusedUnitsCreditOption
				PriceIncreaseOption PriceIncreasePercentage ProductRatePlanChargeTierData ProductRatePlanId RevRecCode RevRecTriggerCondition
				SmoothingModel SpecificBillingPeriod Taxable TaxCode TriggerEvent UOM UpdatedById UpdatedDate
				UseDiscountSpecificAccountingCode) 
 
			#read only fields
			self.read_only_fields = %w(CreatedById CreatedDate UpdatedById UpdatedDate )
		

			self.non_query_fields = %w(ProductRatePlanChargeTierData)
			#TODO
			#make these set from a config file
			#self.custom_fields = %w()

			setup_fields
			#set the minimum required values
			
			self.set_fields_query(

				name: 'test rate plan charge',
				bill_cycle_type: 'DefaultFromCustomer',
				billing_period: 'Month',
				charge_model: 'Flat Fee Pricing',
				charge_type: 'Recurring',
				trigger_event: 'ContractEffective',
				product_rate_plan_charge_tier_data: 'this should be set'
			)
		end		
	end
end
