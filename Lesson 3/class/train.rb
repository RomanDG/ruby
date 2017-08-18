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

  def speed_up(value)
    self.speed += value unless value.negative?  # можно было и так: if value > 0, но увидел что и на этот случай есть метод :)
  end

  def speed_down(value)
    self.speed -= value
    speed = 0 if speed <= 0
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
    self.route.stations[current_position].add_train(self)
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