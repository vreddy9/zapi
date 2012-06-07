module Zapi
	class QueryResponse
		attr_accessor :result, :query_locator, :records, :done

		def initialize(result)
			self.result = result[:query_response][:result]
			self.records = result[:query_response][:result][:records]
		end
	end
end