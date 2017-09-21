module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @instances = 0
    def instances
      @instances ||= 0
    end

    def increment_instances
      @instances += 1
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.increment_instances
    end
  end
end