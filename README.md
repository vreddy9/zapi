# Zuora Api Wrapper

## Config
set credentials when makeing a new session, you can also specify the endpoint after the password ( you will need to change the endpoint in the wsdl and prod is untested )

## Usage
###make a new session
	sesh = Zapi::Session.new(username: '', password: '')

###get all acoounts
	accs = sesh.account.all

###get a specific account
	query_result = sesh.account.where(id: 'asd123') 
	specificAccount = query_result[0]

###get a value
	accountName = specificAccount.values[:name]

###set fields separate by comma if setting more than one
	specificAccount.set_fields(name: 'hi')
	update_res = specificAccount.update

###make a new account
	acc = sesh.account
	acc.set_fields(name: "test account")
	acc.create



