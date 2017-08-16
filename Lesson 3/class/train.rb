
class Train
  attr_accessor :number, :type, :num_wagons, :speed, :route, :current_position

  def initialize(number, type, num_wagons)
    @number = number
    @type = type
    @num_wagons = num_wagons
    @speed = 0
    @route = nil
    @current_position = nil
  end

  def current_speed
    speed
  end

  def set_speed(value)
    self.speed = value
  end

  def stop_run
    self.speed = 0
  end

  def get_num_wagons
    num_wagons
  end

  def add_wagon
    self.num_wagons += 1 if speed == 0
  end

  def del_wagon
    self.num_wagons -= 1 if speed == 0
  end

  def set_route(value)
    self.route = value
    self.current_position = 0
  end

  def go_ahead
    self.current_position += 1 if current_position < route.get_all_stations.size
  end

  def go_back
    self.current_position -= 1 if current_position >= 1
  end

  def current_station
    route.get_all_stations.at(current_position)
    #station.at(current_position)
  end

  def next_station
    if current_position < route.get_all_stations.size
      route.get_all_stations[current_position + 1]
    else
      puts "вы на последней станции: #{route.get_all_stations[current_position]}"
    end
  end

  def prev_station
    if current_position >= 1
      route.get_all_stations[current_position - 1]
    else
      puts "вы на первой станции: #{route.get_all_stations[current_position]}"
    end
  end

end