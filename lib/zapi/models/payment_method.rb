module Zapi
	#represents a zuora account
	class Models::PaymentMethod < Models::Base
		def initialize
			super

			#the name of the Zuora Object
			self.object_name = "PaymentMethod"

			#all the object fields
			self.fields = %w(Id AccountId AchAbaCode AchAccountName AchAccountNumber AchAccountNumberMask AchAccountType
				AchAccountType Active BankBranchCode BankCheckDigit BankCity BankCode BankIdentificationNumber
				BankName BankPostalCode BankStreetName BankStreetNumber BankTransferAccountName BankTransferAccountNumber
				BankTransferAccountType BankTransferType BusinessIdentificationCode City Country CreatedById
				CreatedDate CreditCardAddress1 CreditCardAddress2 CreditCardCity CreditCardCountry CreditCardExpirationMonth
				CreditCardExpirationYear CreditCardHolderName CreditCardMaskNumber CreditCardNumber CreditCardPostalCode
				CreditCardSecurityCode CreditCardState CreditCardType DeviceSessionId Email FirstName IBAN
				IPAddress LastFailedSaleTransactionDate LastName LastTransactionDateTime LastTransactionStatus
				MandateCreationDate MandateID MandateReceived MandateUpdateDate MaxConsecutivePaymentFailures Name
				NumConsecutiveFailures PaymentMethodStatus PaymentRetryWindow PaypalBaid PaypalEmail PaypalPreapprovalKey
				PaypalType Phone PostalCode SkipValidation State StreetName StreetNumber TotalNumberOfErrorPayments 
				TotalNumberOfProcessedPayments Type UpdatedById UpdatedDate UseDefaultRetryRule)  
 
			#read only fields
			self.read_only_fields = %w(CreatedById CreatedDate UpdatedById UpdatedDate TotalNumberOfProcessedPayments 
				TotalNumberOfErrorPayments Name PaymentMethodStatus LastFailedSaleTransactionDate CreditCardMaskNumber 
				BankTransferType BankTransferAccountType BankTransferAccountNumber BankTransferAccountName
				BankStreetNumber BankStreetName BankPostalCode BankName BankIdentificationNumber BankCode
				BankCity Active AchAccountNumberMask)
		

			self.non_query_fields = %w(CreditCardNumber CreditCardSecurityCode SkipValidation AchAccountNumber BankTransferAccountNumber)
			#TODO
			#make these set from a config file
			#self.custom_fields = %w()

			setup_fields
			#set the minimum required values

			self.credit_card_number = '4111111111111111'
			self.credit_card_security_code = '123'
			self.credit_card_expiration_year = '2015'
			self.credit_card_expiration_month = '03'
			self.credit_card_address1 = 'fun lane'
			self.credit_card_city = 'somewhere'
			self.credit_card_country = 'us'
			self.credit_card_state= 'ca'
			self.credit_card_holder_name = 'test'
			self.credit_card_postal_code = '95050'
			self.credit_card_type = 'Visa'
			self.type = 'CreditCard'
		
		end

		define_attributes do
			wsdl :id, :account_id,:ach_aba_code, :ach_account_name, :ach_account_number, :ach_account_number_mask, :ach_account_type, :ach_account_type,
			:active, :bank_branch_code, :bank_check_digit, :bank_city, :bank_code, :bank_identification_number, :bank_name, :bank_postal_code,
			:bank_street_name, :bank_street_number, :bank_transfer_account_name, :bank_transfer_account_number, :bank_transfer_account_type,
			:bank_transfer_type, :business_identification_code, :city, :country, :created_by_id, :created_date, :credit_card_address1,
			:credit_card_address2, :credit_card_city, :credit_card_country, :credit_card_expiration_month, :credit_card_expiration_year,
			:credit_card_holder_name, :credit_card_mask_number, :credit_card_number, :credit_card_postal_code, :credit_card_security_code,
			:credit_card_state, :credit_card_type, :device_session_id, :email, :first_name, :iban, :ip_address, :last_failed_sale_transaction_date,
			:last_name, :last_transaction_date_time, :last_transaction_status, :mandate_creation_date, :mandate_id, :mandate_received, :mandate_update_date,
			:max_consecutive_payment_failures, :name, :num_consecutive_failures, :payment_method_status, :payment_retry_window, :paypal_baid,
			:paypal_email, :paypal_preapproval_key, :paypal_type, :phone, :postal_code, :skip_validation, :state, :street_name, :street_number,
			:total_number_of_error_payments, :total_number_of_processed_payments, :type, :updated_by_id, :updated_date, :use_default_retry_rule
		end			
	end
end
