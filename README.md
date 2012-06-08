## Zuora Api Wrapper

## Config
	* fill in credentials in the config.rb file

## Usage
	* sesh = Zapi::Session.new, creates a new session
	* inv = Zapi::Models::Invoice.new(sesh), make an invoice model to manipulate invoices
	* invoice = inv.all, gets all the invoices
	* invoice = inv.where("InvoiceNumber = 'INV00000016'"), gets invoice with the specified invoice number

