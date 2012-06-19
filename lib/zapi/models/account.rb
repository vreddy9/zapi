module Zapi
	#represents a zuora account
	class Models::Account < Models::Base
		#the name of the Zuora Object

		def initialize
			super
			self.name = "Account"

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
			set_fields(

				name: 'test account',
				payment_term: 'Net 30',
				currency: 'USD',
				bill_cycle_day: 1,
				batch: 'Batch1',
				status: 'Draft'

			)
			

		end		
	end
end
