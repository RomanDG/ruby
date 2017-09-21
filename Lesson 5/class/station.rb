class Station
  @@stations = []

  def self.all
    @@stations
  end

  # здесь я оставил все в public так как используется обьектами из вне
  attr_accessor :trains, :name
  
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  def add_train(train)  
    self.trains.push(train)
  end

  def delete_train(train)
    self.trains.delete_if do |item|
      item.type == train.type && item.number == train.number
    end
  end

  def get_trains_by_type(type)
    trains.select { |train| train.type == type }
  end
end