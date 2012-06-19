## Zuora Api Wrapper

## Config
	* fill in credentials in the config.rb file

## Usage
	* sesh = Zapi::Session.new(username: '', password: ''), creates a new session
	* inv = sesh.invoice
	##get all invoices
	* invoices = inv.all
	##get a specific invoice
	* specificInvoice = inv.where(id: 'asd123')
	##set fields separate by comma if setting more than one
	* specificInvoice.set_fields(notes: 'hi')
	##get a value
	* specificInvoice.values[:notes]
	* update_res = specificInvoice.update



