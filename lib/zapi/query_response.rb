module Zapi
	class QueryResponse
		attr_accessor :records, :objects

		def initialize(result, session)
			self.objects = Array.new
			@session = session
			if result[:query_response][:result][:size] == "1"
				self.records = Array.new << result[:query_response][:result][:records]
			else
				self.records = result[:query_response][:result][:records]
			end
			parse_records(self.records)		
		end
		#parse the QueryResponse
		#figure out the type and set the values
		def parse_records(records) 
			records.each do |record|
				#gets the object which is after the @xsi:type
				type = record[:"@xsi:type"].split(':').last
				#TODO
				#IS THERE A BETTER WAY OF DOING THIS
				#make the correct model and set the fields
				if type == 'Account'
					obj = Zapi::Models::Account.new					
				elsif type == 'Contact'
					obj = Zapi::Models::Contact.new
				elsif type == 'Invoice'
					obj = Zapi::Models::Invoice.new
				elsif type == 'InvoiceItem'
					obj = Zapi::Models::InvoiceItem.new
				elsif type == 'Payment'
					obj = Zapi::Models::Payment.new
				elsif type == 'Subscription'
					obj = Zapi::Models::Subscription.new
				elsif type == 'PaymentMethod'
					obj = Zapi::Models::PaymentMethod.new
				elsif type == 'Product'
					obj = Zapi::Models::Product.new
				elsif type == 'ProductRatePlan'
					obj = Zapi::Models::ProductRatePlan.new
				elsif type == 'ProductRatePlanCharge'
					obj = Zapi::Models::ProductRatePlanCharge.new
				elsif type == 'ProductRatePlanChargeTier'
					obj = Zapi::Models::ProductRatePlanChargeTier.new
				end
				obj.set_fields_query(record)
				#add the obj to the array
				self.objects << obj
			end
		end
	end
end