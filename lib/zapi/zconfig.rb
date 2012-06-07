module Zapi	
	class Zconfig
		attr_accessor :user_name, :password, :endpoint
		def initialize
			self.user_name = 'smogger914@yahoo.com'
			self.password = 'Fo!d3168'
			self.endpoint = 'https://apisandbox.zuora.com'
		end
	end
end
