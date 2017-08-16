
class Route
  attr_accessor :start_station, :end_station, :middle_station, :all_stations

  def initialize(start, finish)
    @start_station = start
    @end_station = finish
    @middle_station = []
    @all_stations = []
  end

  def add_station(name)
    middle_station << name
  end

  def del_station(name)
    middle_station.delete_if { |station| station == name }
  end

  def get_all_stations
    self.all_stations = middle_station.unshift(start_station).push(end_station)
    all_stations
  end
end