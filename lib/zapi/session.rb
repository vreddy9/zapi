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
    		     	if response.to_hash[:update_response][:result][:id] != nil
                        return response.to_hash[:update_response][:result][:id]
                    else
                        return response.to_hash[:update_response]
                    end
    	   		else 
    	   	   		return false
    	   		end
        end
        #delete, the namespace is diff that the obj.to_xml so there is a custom method
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
        def subscribe(account, contact, subscription, payment_method, product_rate_plan_id, subscribe_options, preview_options)
            xml = subscribe_to_xml(account, contact, subscription, payment_method, product_rate_plan_id,subscribe_options, preview_options )
            check_login
            response = @client.request :subscribe do
                soap.header = { "SessionHeader" => { "session" => "#{self.session}" }}
                soap.body = xml
            end
            if response.success?
                return response.to_hash
            else 
                return false
            end
        end

        def amend(account, subscription, product_rate_plan_id)

        end

        #build the xml for the amend call
        def amend_to_xml(account, subscription, product_rate_plan_id)

        end
        #TODO
        #TAKE IN A HASH IF SOME PARAMS ARE NIL DO CERTAIN THINGS
        #product_rate_plan_id should have the related charge info passed in with, i.e. price and quantity 
        #make subscribe xml
        def subscribe_to_xml(account, contact, subscription, payment_method, product_rate_plan_id, subscribe_options, preview_options)
            builder = Builder::XmlMarkup.new
            #build the XML
            xml = builder.tag!("ins0:subscribes") {
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
                    builder.tag!("ins0:EnablePreviewMode", false)
                    builder.tag!("ins0:NumberOfPeriods", 1)
                }
                #TODO
                #ADD SUPPORT FOR SOLD TO
                #sold to contact, if only one BillTo defaults to SoldTo

                #subscribe options                    
                builder.tag!("ins0:SubscribeOptions") {
                    builder.tag!("ins0:GenerateInvoice", false)
                    builder.tag!("ins0:ProcessPayments", false)
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
                    #WILL NEED TO MAKE A NEW ONE OF THESE FOR EACH PRODUCT RATE PLAN ID
                    builder.tag!("ins0:RatePlanData") {
                        #TODO
                        #ADD SUPPORT FOR MULTIPLE RATE PLANS / CHARGES AND QUANTITY
                        #RIGHT NOW ITS ONLY ONE RATE PLAN
                        builder.tag!('ins0:RatePlan', "xsi:type" => "ins1:RatePlan") {
                            builder.tag!("ins1:ProductRatePlanId", product_rate_plan_id)
                        }
                        #TODO
                        #ADD SUPPORT FOR RATE PLAN CHARGE DATA
                        #<ins0:RatePlanChargeData>
                        #  <ins0:RatePlanCharge xsi:type="ns2:RatePlanCharge">
                        #    <ins1:ProductRatePlanChargeId></ns2:ProductRatePlanChargeId>
                        #    <ins1:Quantity></ns2:Quantity>
                        #    </ins0:RatePlanCharge>
                        #</ins0:RatePlanChargeData>
                        #
                        #builder.tag!('ins0:RatePlanChargeData') {
                        #  builder.tag!('ins0:RatePlanCharge', "xsi:type" => "ins1:RatePlanCharge"){
                        #
                        #  }
                        #}
                        #
                    }
                }
            }
        end
        # build the xml for the rate plan data to use in subscribe and amend calls
        def build_rate_plan_data(rate_plans, rate_plan_charges, rate_plan_charge_tiers, type)
            #the namespace
            ns = 'ins1'
            ns0 = 'ins0'
            builder = Builder::XmlMarkup.new
            xml = ''
            #build the xml
            rate_plans.each do |rp|
                #build a rate plan data for each rate plan that is passed in
                xml = builder.tag!("#{ns0}:RatePlanData") {
                    builder.tag!("#{ns0}:RatePlan", "xsi:type" => "#{ns}:RatePlan") {
                        if type == "subscribe"
                            builder.tag!("#{ns}:ProductRatePlanId", rp.values[:id])
                        elsif type == 'amendment'
                               builder.tag!("#{ns}:SubscriptionRatePlanId", rp.values[:id])
                        end
                        #build the XML for the rate_plan_charges
                        if rate_plan_charges != nil
                            builder.tag!("#{ns0}:RatePlanChargeData") {
                                rate_plan_charges.each do |rpc|
                                    builder.tag!("#{ns0}:RatePlanCharge", "xsi:type" => "#{ns}:RatePlanCharge") {
                                        if type == "subscribe"
                                            builder.tag!("#{ns}:ProductRatePlanChargeId", rpc.values[:id])
                                        elsif type == 'amendment'
                                            builder.tag!("#{ns}:SubscriptionRatePlanChargeId", rpc.values[:id])
                                        end
                                        #put in all the rate plan charge values in the call if its not the id 
                                        rpc.symbol_to_string(rpc.values).each do |k,v|
                                            if(k != 'Id' || !rpc.is_complex_type(k))
                                                builder.tag!("#{ns}:#{k}",v)
                                            end
                                        end
                                        #TODO
                                        #need to do a little processing here to figure out which tiers go with what charge
                                        #add tier data if necessary                                    
                                        #if rate_plan_charge_tiers != nil
                                        #    builder.tag!("#{ns0}:RatePlanChargeTierData") {
                                        #        rate_plan_charge_tiers.each do |rpct|    
                                        #        
                                        #            builder.tag!("#{ns0}:RatePlanChargeTier", "xsi:type" => "#{ns}:RatePlanChargeTier") {
                                        #            }
                                        #        end
                                        #    }
                                        #end
                                    }
                                end
                            }
                        end    
                    }

                }
            end
            xml
        end

      	#check to see if the session is valid
        def check_login
      			if self.session == nil
      				  login
      			end
      	end
        #TODO
        #MOVE THIS TO ANOTHER FILE
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
        #create a product model
        def product
            Zapi::Models::Product.new
        end
        #create a product rate plan model
        def product_rate_plan
            Zapi::Models::ProductRatePlan.new
        end
        #create a product rate plan charge model
        def product_rate_plan_charge
            Zapi::Models::ProductRatePlanCharge.new
        end
        #create a product rate plan charge tier model
        def product_rate_plan_charge_tier
            Zapi::Models::ProductRatePlanChargeTier.new
        end
        #create a product rate plan charge tier model
        def amendment
            Zapi::Models::Amendment.new
        end
        #create an export model
        def export
            Zapi::Models::Export.new
        end
	  end	 
end