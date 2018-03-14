# модуль Accessors
module Accessors
    @@var_history = {}

    def attr_accessor_with_history(*args)
        args.each do |attr_name|
            @@var_history["#{attr_name}".to_sym] = []

            define_method(attr_name){ instance_variable_get("@#{attr_name}".to_sym) }
    
            define_method("#{attr_name}=".intern) do |value|
                instance_variable_set("@#{attr_name}".to_sym, value)
                @@var_history["#{attr_name}".to_sym] << value
                puts @@var_history
            end
            
            # убрать puts и inspect, это нужно только для тестов
            define_method("#{attr_name}_history".intern){ puts @@var_history["#{attr_name}".intern].inspect }
        end
    end

    def strong_attr_acessor(*attr_name)
        define_method(attr_name[0]){ instance_variable_get("@#{attr_name[0]}".to_sym) }
    
        define_method("#{attr_name[0]}=".intern) do |value|
            raise "different types" if value[0].class.to_s != value[1].to_s
            instance_variable_set("@#{attr_name[0]}".to_sym, value)
        end
    end
end

# проверочный класс для модуля
class Test
    extend Accessors
    attr_accessor_with_history :name, :age
    strong_attr_acessor :number

    def initialize
    end
end

# тесты работы
t = Test.new
t.name = "AAA"
t.name = "BBB"
t.name_history
t.number = 100, :Integer
puts t.number.inspect