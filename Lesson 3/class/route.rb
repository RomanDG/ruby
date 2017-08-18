class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def delete_station(name)
    self.stations.delete_if do |station|
      station.name == name && stations.index(station) != 0 && stations.index(station) != stations.size-1
    end
  end
end