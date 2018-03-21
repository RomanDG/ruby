module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    class_variable_set(:@@tmp_var, [])
    def validate(*args)
      args.each { |val| @@tmp_var << val }
      valid?
      @@tmp_var = []
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
      firs_arg = @@tmp_var[0]
      attr_name = self.instance_variable_get("@#{firs_arg}".to_sym)
      case @@tmp_var[1]
      when :presence
        raise 'данный аттрибут не инициализирован' if attr_name == nil || attr_name == ""
      when :format
        if self.class = Train
          raise 'вы ввели не правильный номер поезда' if attr_name !~ @@tmp_var[2]
        elsif self.class = Station
          raise 'название станции содержит латинские буквы' if attr_name !~ @@tmp_var[2]
        end
      when :type
          rais 'несоответствие типа' if attr_name.to_s != @@tmp_var[2]
      end
    end
  end
end