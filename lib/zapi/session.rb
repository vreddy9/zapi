module Zapi
	class Session
		attr_accessor :zconfig, :session
		#initilize the savon client and login
		def initialize
			self.zconfig = Zapi::Zconfig.new

			Savon.configure do |config|
  				config.log = false            # disable logging
  				config.log_level = :info
			end 
			#disable logging?
			#HTTPI.log=false

			@client = Savon::Client.new do
				wsdl.document = File.expand_path("../zuora.a.38.0.wsdl", __FILE__)
			end
			login			
		end
		#login to the Zuora API and set the session
		def login
		   	response = @client.request :login do
				soap.body = { username: self.zconfig.user_name, password: self.zconfig.password}
		   	end
	   		self.session = response.to_hash[:login_response][:result][:session]
		end
  		#query objects and return a QueryResponse
  		def query(queryString)
  			check_login
  			query = @client.request :query do
  				soap.header = { "SessionHeader" => { "session" => "#{session}" }}
  				soap.body = {"queryString" => queryString }
  			end
  			qr = Zapi::QueryResponse.new(query.to_hash)
  			#return only the records
  			#TODO
  			#MAKE QUERYRESPONSE RECORDS BE Zapi::Models
  			qr.records
  		end
  		#create an object in zuora
  		def create
  			check_login
  			createresponse = client.request :create do
      			soap.header = { "SessionHeader" => { "session" => "#{session}" }}
      			soap.body = {
	        		:zObjects => { "ins1:AllowInvoiceEdit" => "false",
	                           "ins1:StartDateTime" => "2011-09-16T03:18:09Z",
	                           "ins1:BillCycleDay" => "1",
	                           "ins1:Currency" => "USD",
	                           "ins1:Name" => accountname,
	                           "ins1:PaymentTerm" => "Due Upon Receipt",
	                           "ins1:Status" => "Draft",
	                           "ins1:Batch" => "Batch1" },

	        		:attributes! => {"ins0:zObjects" => { "xsi:type" => "ins1:Account"}}
        		}
     		end
     		return createresponse
  		end
  		#check to see if the session is not nil otherwise login
  		def check_login
  			if self.session == nil
  				login
  			end
  		end

  		def account
  			Zapi::Models::Account.new(self)
  		end
	end	 
end