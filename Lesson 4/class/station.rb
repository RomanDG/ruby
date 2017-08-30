class Station
  # здесь я оставил все в public так как используется обьектами из вне
  attr_accessor :trains, :name
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)  
    self.trains.push(train)
  end

  def delete_train(type, number)
    self.trains.delete_if do |train|
      train.type == type && train.number == number
    end
  end

  def get_trains_by_type(type)
    trains.select { |train| train.type == type }
  end
end