module Zapi	
	class Zconfig
		attr_accessor :user_name, :password, :endpoint
		def initialize(config={})
			self.user_name = config[:username]
			self.password = config[:password]
			self.endpoint = config[:endpoint] || 'https://apisandbox.zuora.com'
		end
	end
end
