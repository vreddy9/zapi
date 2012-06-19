## Zuora Api Wrapper

## Config
fill in credentials in the config.rb file

## Usage
#make a new session
sesh = Zapi::Session.new(username: '', password: '')

#get all acoounts
accs = sesh.account.all

#get a specific account
query_result = sesh.account.where(id: 'asd123')
specificAccount = query_result[0]

#get a value
accountName = specificAccount.values[:name]

#set fields separate by comma if setting more than one
specificAccount.set_fields(name: 'hi')
update_res = specificAccount.update

#make a new account
acc = sesh.account
acc.set_fields(name: "test account")
acc.create


