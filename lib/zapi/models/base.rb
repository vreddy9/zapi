module Zapi
	class Models::Base

      	attr_accessor :fields, :name, :updated_fields, :queried_fields, :custom_fields, :non_query_fields , :read_only_fields, :values, :symbols
    	#initialize the base
		def initialize
			self.symbols = Hash.new
			self.values = Hash.new
			self.updated_fields = Hash.new
			self.queried_fields = Hash.new
		end
		#setup the symbols with the fields from the model
		def setup_fields
			self.fields.each do |field|
				self.symbols[field] = underscore(field).to_sym
			end
		end
		#get all the objects
		def all
			$session.query(make_query_string)
		end
		#query an object with condition hash
		def where(condition)
			#condition should look like {field_name: 'string', field_number: 1}
			#ends up like FieldName = 'string' AND FieldNumber = 1
			params = Array.new
			condition.each do |k,v|
				#find the string the goes with the symbol
				k = find_field(k)
				#strings need '' in queries
				#dont add if there was no k
				if((v.class == String || v.class == Nori::StringWithAttributes) && k != '')
					params << "#{k} = '#{v}'"
				elsif(k != '')	
					params << "#{k} = #{v}"
				end
			end	
			#params
			$session.query(make_query_string + ' WHERE ' + params.join(' AND '))
		end
		#query an object with condition string
		def where_s(condition)
			$session.query(make_query_string + ' WHERE ' + condition)
		end
		#call the sessions create method
		def create
			$session.create(to_xml('create'))
		end
		#call the sessions update method
		def update
			#need to set the id first
			$session.update(to_xml('update'))
		end
		#call the sessions delete method
		def delete
			$session.delete(self.values[:id], self.name)
		end
		#set the fields on the object
		def set_fields(map)
			map.each do |k,v|
				self.updated_fields[k] = v
			end
			#add the updated fields to the values and overwrite any existing ones
			self.updated_fields.each do |k, v|
				values[k] = v
			end
		end
		#set the queried values on the object
		def set_fields_query(map)
			temp = Hash.new
			map.each do |k,v|
				self.values[k] = v
			end
		end
		#find the symbol in the symbols and return the string
		def find_field(value)
			self.symbols.each do |k, v|
				return k if(value == v)
			end
			#TODO
			#ADD ERROR HANDILING IF THERE IS NO SYMBOL FOUND
			return ''
		end
		#string to symbol
		def symbol_to_string(hash)
			temp = Hash.new
			hash.each do |k,v|
				#find the string the goes with the symbol
				k = find_field(k)
				if(k != '')
					temp[k]= v
				end
			end
			temp
		end 
		#make the string representing the query
		def make_query_string
			if(self.non_query_fields != nil)
				fields = self.fields - self.non_query_fields
			else
				fields = self.fields
			end
			qstr = 'SELECT ' + fields.join(', ') + ' FROM ' + self.name
		end
		#underscore the fields in the way they are returned by savon
		def underscore(string) 
			string.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase  
		end
		#check to see if a field is read only
		def is_read_only(val)
			self.read_only_fields.each do |f|
				if(f == val)
					return true
				end
			end
			false
		end
		#build the xml for the object
		def to_xml(command)
			#the namespace
			ns = 'ins1'
			builder = Builder::XmlMarkup.new		
			#build the xml
			xml = builder.tag!("ins0:zObjects", "xsi:type" => "#{ns}:#{self.name}") {
				#if its update set the id first
				if (command == 'update')
					if(self.values[:id] != nil)
						temp = symbol_to_string(self.updated_fields)
						builder.tag!("#{ns}:Id", self.values[:id])
					end
				elsif (command == 'create')
					temp = symbol_to_string(self.values)
				end
				#set the values if they are not read only
				temp.each do |k,v|
					#check to see if its id or read only
					if(k != ':id' && !is_read_only(k))
						builder.tag!("#{ns}:#{k}",v)
					end
				end				
			}
			xml
		end
	end
end