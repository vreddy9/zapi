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
			self.name = 'test rate plan charge'
			self.bill_cycle_type = 'DefaultFromCustomer'
			self.billing_period = 'Month'
			self.charge_model = 'Flat Fee Pricing'
			self.charge_type = 'Recurring'
			self.trigger_event = 'ContractEffective'
			self.product_rate_plan_charge_tier_data = 'this should be set'
			
		end
		define_attributes do 		
			wsdl :id, :accounting_code, :bill_cycle_day, :bill_cycle_type, :billing_period, :billing_period_alignment,
			:charge_model, :charge_type, :created_by_id, :created_date, :default_quantity, :description, :included_units,
			:max_quantity, :min_quantity, :name, :number_of_period, :overage_calculation_option, :overage_unused_units_credit_option,
			:price_increase_option, :price_increase_percentage, :product_rate_plan_charge_tier_data, :product_rate_plan_id,
			:rev_rec_code, :rev_rec_trigger_condition, :smoothing_model, :specific_billing_period, :taxable, :tax_code, :trigger_event,
			:uom, :updated_by_id, :updated_date
		end
	end
end
