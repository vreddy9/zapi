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
              self.values[attr] = value
            end
          EVAL
        end
      end
    
      def wsdl(*args)
          class_variable_set(:@@wsdl_attributes, args)
      end
      alias_method :wsdl_attributes, :wsdl
      # returns an array of symbols for all attributes read from WSDL.
      def wsdl_attributes
        return [] unless self.class.class_variable_defined?(:@@wsdl_attributes)
        self.class.send(:class_variable_get, :@@wsdl_attributes)
      end
    end
  end
end
