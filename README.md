# Zuora Api Wrapper

## Install
Make sure you install the latest version

	gem 'zapi', :git => 'git@github.com:mdemin914/zapi.git'

## Config
Set credentials when making a new session, you can also specify the endpoint after the password ( you will need to change the endpoint in the wsdl and prod is untested as of 6/18/2012 )

## Usage

###Make a new session before doing anything

	sesh = Zapi::Session.new(username: '', password: '')

###Get all accounts, return an array of accounts
	accs = sesh.account.all

###Get a specific account, will always return the object in an array even if its one

	query_result = sesh.account.where(id: 'asd123') 
	specificAccount = query_result[0]

###Get a specific value from a field that has been set or returned from a query

	accountName = specificAccount.values[:name]

###Set fields and Update

Separate by comma if setting more than one, use underscore case i.e 'ThisName' in the WSDL is ':this_name'.

	specificAccount.set_fields( name: 'hi', currency: 'USD' )
	update_res = specificAccount.update

###Make a new account

Some values are set by default.

	acc = sesh.account
	acc.set_fields(name: "test account")
	acc.create



