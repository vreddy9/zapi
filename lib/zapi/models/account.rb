module Zapi
	class Models::Account < Models::Base
		self.name = 'Account'

		self.fields = %w(Id AccountNumber AdditionalEmailAddresses AllowInvoiceEdit AutoPay Balance 
			Batch BcdSettingOption BillCycleDay BillToId CreatedById CreatedDate CrmId
			Currency CustomerServiceRepName DefaultPaymentMethodId InvoiceDeliveryPrefsEmail InvoiceDeliveryPrefsPrint
			InvoiceTemplateId LastInvoiceDate Name Notes PaymentGateway PaymentTerm PurchaseOrderNumber SalesRepName
			SoldToId Status UpdatedById UpdatedDate CustomField__c)

		self.default_fields = %w(Id AccountNumber Name CustomField__c)
		
		self.custom_fields = %w(CustomField__c)
		
	end
end
