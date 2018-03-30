module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations
    def validate(*args)
      self.validations ||= []
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
        self.send("#{value[1]}".to_sym, instance_eval("@#{value[0]}"), value[2])
      end
    end

    def presence(*value)
      attr_name = value
      raise 'данный аттрибут не инициализирован' if attr_name == nil || attr_name == ""
    end

    def format(*value)
      attr_name, rules = value
      raise 'несоответствие шаблону регулярного выражения' if attr_name !~ /#{rules}/
    end

    def type(*value)
      attr_name, rules = value
      rais 'несоответствие типа' if attr_name.to_s != /#{rules}/
    end
  end
end

# это небольшой класс для тестирования модуля

class Test
  include Validation

  NAME_FORMAT = /^[а-яА-ЯёЁ\\s]+$/

  attr_accessor :name

  validate :name, :presence
  validate :name, :format, NAME_FORMAT
end

t = Test.new
t.name = "банан"
t.valid?
t2 = Test.new
t2.name = "banana"
t2.valid?