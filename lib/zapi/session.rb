module Zapi
	class Session
		attr_accessor :zconfig, :session

		#initilize the savon client and login
		def initialize
			self.zconfig = Zapi::Zconfig.new

			@client = Savon::Client.new do
				wsdl.document = File.expand_path("../zuora.a.38.0.wsdl", __FILE__)
			end
			login
		end
		# Login to the Zuora API and set the session
		def login
		   	response = @client.request :login do
				soap.body = { username: self.zconfig.user_name, password: self.zconfig.password}
		   	end
	   		self.session = response.to_hash[:login_response][:result][:session]
		end
		#returns the invoice based on an id
  		def get_invoices
  			check_login
      		invoices = @client.request :query do
        		soap.header = { "SessionHeader" => { "session" => "#{session}" }}
        		soap.body = {"queryString" => "select Id, Amount FROM Invoice"}
      		end
    		#invoices.to_hash
    		qr = Zapi::QueryResponse.new(invoices.to_hash)
    		qr.records
  		end

  		def check_login
  			if self.session == nil
  				login
  			end
  		end
	end	 
end