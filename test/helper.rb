require 'test/unit'
require 'zapi'

module ZapiTestHelper
	$zapi = Zapi::Session.new
	$zapi.login
end