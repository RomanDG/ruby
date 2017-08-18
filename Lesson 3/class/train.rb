class Train
  attr_reader :speed, :num_wagons, :number, :type, :route, :current_position
  attr_writer :route, :current_position, :speed, :num_wagons

  def initialize(number, type, num_wagons)
    @number = number
    @type = type
    @num_wagons = num_wagons
    @speed = 0
    @route = nil
    @current_position = nil
  end

  def change_speed(value)
    self.speed = [0, self.speed + value].max
  end

  def stop_run
    self.speed = 0
  end

  def add_wagon
    self.num_wagons += 1 if speed == 0
  end

  def delete_wagon
    self.num_wagons -= 1 if speed == 0
  end

  def set_route(value)
    self.route = value
    self.current_position = 0
    current_station.add_train(self)
  end

  def go_ahead
    if current_position < route.stations.size
      current_station.delete_train(type, number)
      self.current_position += 1
      current_station.add_train(self)
    end
  end

  def go_back
    if current_position >= 1
      current_station.delete_train(type, number)
      self.current_position -= 1
      current_station.add_train(self)
    end
  end

  def current_station
    route.stations[current_position]
  end

  def next_station
    route.stations[current_position + 1]
  end

  def prev_station
    route.stations[current_position - 1] if current_position > 0
  end
end