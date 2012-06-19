## Zuora Api Wrapper

## Config
	* fill in credentials in the config.rb file

## Usage
	* sesh = Zapi::Session.new(username: '', password: ''), creates a new session
	* inv = sesh.invoice
	* invoices = inv.all
	* specificInvoice = inv.where(id: 'asd123')
	* specificInvoice.set_fields(notes: 'hi')
	* update_res = specificInvoice.update


