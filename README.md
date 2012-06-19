# Zuora Api Wrapper

## Config
Set credentials when making a new session, you can also specify the endpoint after the password ( you will need to change the endpoint in the wsdl and prod is untested )

## Usage
###make a new session
	sesh = Zapi::Session.new(username: '', password: '')

###Get all acoounts
	accs = sesh.account.all

###Get a specific account
	query_result = sesh.account.where(id: 'asd123') 
	specificAccount = query_result[0]

###Get a value

Must specify the WSDL field name.

	accountName = specificAccount.values["Name"]

###Set fields

Separate by comma if setting more than one, use ruby case i.e ThisName is this_name.

	specificAccount.set_fields(name: 'hi', currency: 'USD')
	update_res = specificAccount.update

###Make a new account

Some values are set by default.

	acc = sesh.account
	acc.set_fields(name: "test account")
	acc.create



