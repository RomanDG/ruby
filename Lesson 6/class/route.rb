class Route
  # здесь я оставил все в public так как используется обьектами из вне
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def delete_station(name)
    index = stations.index { |station| station.name == name }
    return if index.nil? || index == 0 || index == stations.size - 1
    stations.delete_at(index)
  end

  protected

  def validate!
    raise "первый параметр для создания маршрута не является обьектом класса Station" if !stations[0].instance_of?(Station)
    raise "второй параметр для создания маршрута не является обьектом класса Station" if !stations[-1].instance_of?(Station)
    true
  end  
end