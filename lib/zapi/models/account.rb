module Zapi
	#represents a zuora account
	class Models::Account < Models::Base

		#the name of the Zuora Object
		
		def initialize
			super
			self.object_name = "Account"

			#all the object fields
			self.fields = %w(Id AccountNumber AdditionalEmailAddresses AllowInvoiceEdit AutoPay Balance 
				Batch BcdSettingOption BillCycleDay BillToId CreatedById CreatedDate CrmId
				Currency CustomerServiceRepName DefaultPaymentMethodId InvoiceDeliveryPrefsEmail InvoiceDeliveryPrefsPrint
				InvoiceTemplateId LastInvoiceDate Name Notes PaymentGateway PaymentTerm PurchaseOrderNumber SalesRepName
				SoldToId Status UpdatedById UpdatedDate CustomField__c)

			#read only fields
			self.read_only_fields = %w(Id Balance CreatedById CreatedDate CreditBalance 
				LastInvoiceDate TotalInvoiceBalance UpdatedById UpdatedDate)
			
			#TODO
			#make these set from a config file
			#self.custom_fields = %w(CustomField__c)
			
			#setup the fields
			setup_fields

			#set the minimum required values
			self.name = 'test account'
			self.payment_term = 'Net 30'
			self.currency = 'USD'
			self.bill_cycle_day = 1
			self.batch = 'Batch1'
			self.status = 'Draft'
		end
		#define_attributes
		define_attributes do
			wsdl :id, :account_number, :additional_email_addresses, :allow_invoice_edit, :auto_pay, :balance, 
				:batch, :bcd_setting_option, :bill_cycle_day, :bill_to_id, :created_by_id, :created_date, :crm_id,
				:currency, :customer_service_rep_name, :default_payment_method_id, :invoice_delivery_prefs_email, 
				:invoice_delivery_prefs_print, :invoice_template_id, :last_invoice_date, :name, :notes, :payment_gateway,
				:payment_term, :purchase_order_number, :sales_rep_name, :sold_to_id, :status, :updated_by_id, :updated_date,
				:custom_field__c
		end				
	end

end
