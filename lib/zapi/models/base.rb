module Zapi
	class Models::Base
		class << self
      		attr_accessor :fields, :name, :default_fields, :custom_fields, :values, :symbols
    	end
    	#initilize the base
		def initialize(session)
			self.class.symbols = Hash.new
			@session = session
			#make the symbol map
			self.class.fields.each do |field|
				self.class.symbols[field] = underscore(field).to_sym
			end	
		end
		#get all the objects
		def all
			@session.query(make_query_string)
		end
		#query an object with condition hash
		def where(condition)
			#condition should look like {field_name: 'string'. field_number, 1}
			#ends up like FieldName = 'string' AND FieldNumber = 1
			params = Array.new
			condition.each do |k,v|
				#find the string the goes with the symbol
				k = find_field(k)
				#strings need '' in queries
				#dont add if there was no k
				if(v.class == String && k != '')
					params << "#{k} = '#{v}'"
				elsif(v.class == Fixnum && k != '')
					params << "#{k} = #{v}"
				end
			end	
			#params
			#string = make_query_string + ' WHERE ' + params.join(' AND ')
			@session.query(make_query_string + ' WHERE ' + params.join(' AND '))
		end
		#query an object with condition string
		def where_s(condition)
			@session.query(make_query_string + ' WHERE ' + condition)
		end
		#duh
		def create

		end
		#duh
		def update

		end
		#duh
		def destroy

		end
		#find the symbol in the symbols and return the string
		def find_field(value)
			self.class.symbols.each do |k, v|
				return k if(value == v)
			end
			#TODO
			#ADD ERROR HANDILING IF THERE IS NO SYMBOL FOUND
			return ''
		end
		#make the string representing the query
		def make_query_string
			qstr = 'SELECT ' + self.class.fields.join(', ') + ' FROM ' + self.class.name
		end
		#underscore the fields in the way they are returned by savon
		def underscore(string) 
			string.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase  
		end
	end
end