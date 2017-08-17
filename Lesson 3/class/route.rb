class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [] << first_station << last_station
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def delete_station(name)
    self.stations.delete_if { |station| station.name == name }
  end
end