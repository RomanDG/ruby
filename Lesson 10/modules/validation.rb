module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # т.е. если я правильно понял, валидации теперь будут вызываться так ( например ):
  # создали станцию - a ( обьект класса Station ), вызываем - a.valid?
  # и тут у нас уже проверяются все правила валидации для конкретного обьекта
  module ClassMethods
    def validate(*args)
      instance_variable_set("@#{args[0]}".to_sym, [])
      args.each { |val| instance_eval("@#{args[0]}") << val }
      #valid?
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
      self.class.instance_variables.each do |value|
        @attr_name = self.class.instance_eval("@#{value}")[0]
        @validator = self.class.instance_eval("@#{value}")[1]
        @rules = self.class.instance_eval("@#{value}")[2] if self.class.instance_eval("@#{value}")[2] != nil
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