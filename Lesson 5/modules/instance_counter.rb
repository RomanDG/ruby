module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = 0
    def instances(is_new = false)
      if is_new == true
        @@instances += 1
      else
        @@instances
      end
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.instances(true)
    end
  end
end

# условие:
# register_instance, который увеличивает счетчик кол-ва экземпляров класса 
# и который можно вызвать из конструктора. При этом данный метод не должен 
# быть публичным

# если я не буду делать проверку: if is_new == true, то будет показывать
# на 1 экземпляр больше