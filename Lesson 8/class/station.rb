class Station

  @@stations = []

  def self.all
    @@stations
  end

  # здесь я оставил все в public так как используется обьектами из вне
  attr_accessor :trains, :name

  NAME_FORMAT = /^[а-яА-ЯёЁ\s]+$/
  
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  # метод, который принимает блок и проходит по всем поездам на станции
  def show_trains(&block)
    yield(trains)
  end

  def valid?
    validate!
    true
  rescue
    false
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

  protected

  def validate!
    raise "название станции содержит латинские буквы" if name !~ NAME_FORMAT
    raise "название станции не должно иметь разделяющих пробелов" if name.split.size > 2
  end
end