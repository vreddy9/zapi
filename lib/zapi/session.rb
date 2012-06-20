module Zapi

    WSDL =  File.expand_path("../zuora.a.38.0.wsdl", __FILE__)

	  class Session
        #getters and setters
        attr_accessor :zconfig, :session
		    #initilize the savon client and login
		    def initialize(config)
            self.zconfig = Zapi::Zconfig.new(config)
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
    		def create(xml)
    			  check_login
       			    response = @client.request :create do
           		      soap.header = { "SessionHeader" => { "session" => "#{self.session}" }}
           		      soap.body = xml
          	end
          	if response.success?
    		   		    return response.to_hash[:create_response][:result][:id]
    	   		else 
    	   			    return false
    	   		end
        end
        #update an object in zuora
        def update(xml)
         		check_login
       			response = @client.request :update do
           	    soap.header = { "SessionHeader" => { "session" => "#{self.session}" }}
           		  soap.body = xml
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
        #TODO
        #TAKE IN A HASH IF SOME PARAMS ARE NIL DO CERTAIN THINGS 
        #subscribe call
        def subscribe_xml(account, contact, subscription, payment_method)
            builder = Builder::XmlMarkup.new
            #build the XML
            xml = builder.tag!("ins0:subscribe") {
                builder.tag!("ins0:subscribes") {
                    #account can be just an id to subscribe to existing
                    builder.tag!("ins0:Account", "xsi:type" => "ins1:Account") {
                        #put all the account values in the call
                        account.symbol_to_string(account.values).each do |k,v|
                            builder.tag!("ins1:#{k}",v)
                        end
                    }
                    #payment method
                    builder.tag!("ins0:PaymentMethod", "xsi:type" => "ins1:PaymentMethod") {
                        #put all the paymnet method values in the call
                        payment_method.symbol_to_string(payment_method.values).each do |k,v|
                            builder.tag!("ins1:#{k}",v)
                        end
                    }
                    #bill to contact
                    builder.tag!("ins0:BillToContact", "xsi:type" => "ins1:BillToContact") {
                        #put all the contact values in the call
                        contact.symbol_to_string(contact.values).each do |k,v|
                            builder.tag!("ins1:#{k}",v)
                        end
                    }
                    #preview options
                    builder.tag!("ins0:PreviewOptions") {
                        builder.tag!("ins1:EnablePreviewMode", false)
                        builder.tag!("ins1:NumberOfPeriods", 1)
                    }
                    #TODO
                    #ADD SUPPORT FOR SOLD TO
                    #sold to contact, if only one BillTo defaults to SoldTo

                    #subscribe options                    
                    builder.tag!("ins0:SubscribeOptions") {
                        builder.tag!("ins1:GenerateInvoice", false)
                        builder.tag!("ins1:ProcessPayments", false)
                    }
                    #subscription data
                    builder.tag!("ins0:SubscriptionData") {
                        #subscription
                        builder.tag!("ins0:Subscription", "xsi:type" => "ins1:Subscription"){
                            #put in all the subscription values in the call
                            subscription.symbol_to_string(subscription.values).each do |k,v|
                                builder.tag!("ins1:#{k}",v)
                            end
                        }
                        #rate plan data
                        builder.tag!("ins0:RatePlanData") {

                        }
                    }
                }
            }
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
        #create a payment method model
        def payment_method
            Zapi::Models::PaymentMethod.new
        end
	  end	 
end