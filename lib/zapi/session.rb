module Zapi

    WSDL =  File.expand_path("../zuora.a.38.0.wsdl", __FILE__)

	  class Session
        #getters and setters
        attr_accessor :zconfig, :session
		    #initilize the savon client and login
		    def initialize
            self.zconfig = Zapi::Zconfig.new
			      savon_setup
            $session = self	
		    end
    		#setup savon
    		def savon_setup
    			  HTTPI.log = false
    			  Savon.configure do |config|
                #TODO 
                #FIGURE OUT WHY THIS BREAKS WITH RAKE
    	  		    #disable logging
    	  		    #config.log = false
            end 	
    			  @client = Savon::Client.new do
    				    wsdl.document = WSDL
    			  end
    		end
    		#login to the Zuora API and set the session
    		def login
    		    response = @client.request :login do
                soap.body = { username: self.zconfig.user_name, password: self.zconfig.password}
    		    end
    		    response.to_hash
    	   	  self.session = response.to_hash[:login_response][:result][:session]
        end
      	#query objects and return a QueryResponse
      	def query(queryString)
      	   	check_login
      			query = @client.request :query do
      	   			soap.header = { "SessionHeader" => { "session" => "#{self.session}" }}
      		  		soap.body = {"queryString" => queryString }
      			end
      			#query.to_hash
      			qr = Zapi::QueryResponse.new(query.to_hash, self)
      			qr.objects
      	end
      	#create an object in zuora
    		def create(type, map)
    			  check_login
       			    map = add_namespace(map)
       			    response = @client.request :create do
           		      soap.header = { "SessionHeader" => { "session" => "#{self.session}" }}
           		      soap.body = {

    				            zObjects: map,
    				            attributes!: {"ins0:zObjects" => { "xsi:type" => "ins1:#{type}"}}

             		    }
          	end
          	if response.success?
    		   		    return response.to_hash[:create_response][:result][:id]
    	   		else 
    	   			    return false
    	   		end
        end
        #update an object in zuora
        def update(body)
         		check_login
         		#map = add_namespace(map)
       			response = @client.request :update do
           	    soap.header = { "SessionHeader" => { "session" => "#{self.session}" }}
           		  soap.body = body
          	end
         		if response.success?
    		     		return response.to_hash
    	   		else 
    	   	   		return false
    	   		end
        end
        #delete
        def delete(id, type)
            check_login
            response = @client.request :delete do
                soap.header = { "SessionHeader" => { "session" => "#{self.session}" }}
                soap.body = {
                    "ins0:type" => type,
                    "ins0:ids" => id
                }
            end
            if response.success?
                return response.to_hash
            else 
                return false
            end
        end
        #subscribe call
        def subscribe(account, contact, payment_method, subscription, subscription_data)

        end
      	#add the ins1: before the keys and make them strings
      	def add_namespace(map)
      			temp = Hash.new
      			map.each do |k, v|
      				  k = "ins1:#{k}".to_s
      				  temp[k] = v
      			end
      			temp
      	end
      	#check to see if the session is valid
        def check_login
      			if self.session == nil
      				  login
      			end
      		end
      	#create an account model
      	def account
      			Zapi::Models::Account.new
      	end
        #create a contact model
        def contact
            Zapi::Models::Contact.new
        end
      	#create an invoice model
      	def invoice
      			Zapi::Models::Invoice.new
      	end
        #create an invoice item model
        def invoice_item
            Zapi::Models::InvoiceItem.new
        end
        #create a payment model
        def payment
            Zapi::Models::Payment.new
        end
        #create a subscription model
        def subscription
            Zapi::Models::Subscription.new
        end
        #
	  end	 
end