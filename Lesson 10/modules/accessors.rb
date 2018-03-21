module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*args)
      args.each do |attr|
        define_method("#{attr}".to_sym){ instance_eval("@#{attr}") }

        define_method("#{attr}=".to_sym) do |value|
          instance_variable_set("@#{attr}".to_sym, value)
          tmp = []
          unless instance_variable_defined?("@#{attr}_history".to_sym)
            tmp << instance_eval("@#{attr}")
            instance_variable_set("@#{attr}_history".to_sym, tmp)
          else
            tmp = instance_eval("@#{attr}_history")
            tmp << instance_eval("@#{attr}")
            instance_variable_set("@#{attr}_history".to_sym, tmp)
          end
          tmp = []
        end
      end
    end

    def strong_attr_accessor(*args)
      define_method(args[0]){ instance_eval("@#{args[0]}") }
          
      define_method("#{args[0]}=".to_sym) do |value|
        raise "different types" if value.class.to_s != args[1].to_s
        instance_variable_set("@#{args[0]}".to_sym, value)
      end
    end
  end
end

class Test
  include Accessors
  attr_accessor_with_history :name, :age
  
  strong_attr_accessor :name, String
  strong_attr_accessor :age, Integer
end

t = Test.new
t.name = "AAAAA"
t.name = "BBBBB"
t.age = 29
t.age = 31

t2 = Test.new
t2.name = "CCCCC"
t2.name = "DDDDD"

puts t.instance_variable_get(:@name_history).inspect
puts t.instance_variable_get(:@age_history).inspect
puts t2.instance_variable_get(:@name_history).inspect
