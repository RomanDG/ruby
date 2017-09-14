class Route
  # здесь я оставил все в public так как используется обьектами из вне
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def delete_station(name)
    index = stations.index { |station| station.name == name }
    return if index.nil? || index == 0 || index == stations.size - 1
    stations.delete_at(index)
  end
end