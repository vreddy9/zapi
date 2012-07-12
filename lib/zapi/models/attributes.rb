module Zapi
  module Models::Attributes

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def define_attributes(&block)
        yield self
        class_variable_get(:@@wsdl_attributes).each do |attr|
          class_eval <<-EVAL
            define_method "#{attr}" do
              self.values[attr]
            end

            define_method "#{attr}=" do |value|
              self.updated_fields[attr] = value
              self.values[attr] = value             
            end
          EVAL
        end
      end
    
      def wsdl(*args)
          class_variable_set(:@@wsdl_attributes, args)
      end
    end
  end
end
