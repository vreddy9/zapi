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
				#make the correct model and set the fields
				if type == 'Account'
					obj = Zapi::Models::Account.new
					obj.set_fields(record)
				elsif type == 'Invoice'
					obj = Zapi::Models::Invoice.new
					obj.set_fields(record)
				elsif type == 'InvoiceItem'
					obj = Zapi::Models::InvoiceItem.new
					obj.set_fields(record)
				elsif type == 'Payment'
					obj = Zapi::Models::Payment.new
					obj.set_fields(record)
				end
				#add the obj to the array
				self.objects << obj
			end
		end
	end
end