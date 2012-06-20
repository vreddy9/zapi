module Zapi
	#represents a zuora account
	class Models::PaymentMethod < Models::Base
		def initialize
			super

			#the name of the Zuora Object
			self.name = "PaymentMethod"

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
			self.set_fields_query(

				credit_card_number: '4111111111111111',
				credit_card_security_code: '123',
				credit_card_expiration_year: '2015',
				credit_card_expiration_month: '03',
				credit_card_address_1: 'fun lane',
				credit_card_city: 'somewhere',
				credit_card_country: 'us',
				credit_card_state: 'ca',
				credit_card_holder_name: 'test',
				credit_card_postal_code: '95050',
				credit_card_type: 'Visa',
				type: 'CreditCard'

			)
		end		
	end
end
