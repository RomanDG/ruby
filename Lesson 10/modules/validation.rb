module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations
    def validate(*args)
      self.validations = [] unless self.validations.is_a?(Array)
      self.validations << args
    end
  end

  module InstanceMethods  
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate!
      self.class.validations.each do |value|
        @attr_name = value[0]
        @validator = value[1]
        @rules = value[2] if value[2] != nil
        self.send("#{@validator}".to_sym)
      end
    end

    def presence
      raise 'данный аттрибут не инициализирован' if @attr_name == nil || @attr_name == ""
    end

    def format
      raise 'несоответствие шаблону регулярного выражения' if @attr_name !~ @rules
    end

    def type
      rais 'несоответствие типа' if @attr_name.to_s != @rules
    end
  end
end

# это небольшой класс для тестирования модуля
# но у меня почему то регулярка всегда выдает FALSE
# я никак не моуг разобраться, прошу вашей помощи
#
# class Test
#   include Validation

#   NAME_FORMAT = "/^[а-яА-ЯёЁ\\s]+$/"

#   attr_accessor :name

#   validate :name, :presence
#   validate :name, :format, NAME_FORMAT
# end

# t = Test.new
# t.name = "банан"
# t.valid?
# t2 = Test.new
# t2.name = "banana"
# t2.valid?