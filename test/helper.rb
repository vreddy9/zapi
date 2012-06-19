require 'test/unit'
require 'zapi'

module ZapiTestHelper
	$zapi = Zapi::Session.new(username: 'smogger914@yahoo.com', password: 'Fo!d3168')
	$zapi.login
end