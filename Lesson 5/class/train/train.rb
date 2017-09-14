require_relative '../../modules/production_company'

class Train
  @@trains = []

  def self.add(hash)
    @@trains << hash
  end

  def self.find(num)
    result = @@trains.select do |item|
      item[:number] == num
    end
    result != [] ? result[0][:obj_train] : nil
  end

  include ProductionCompany
  # это public магия, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может испоьзовать их 
  attr_reader :vagons, :number, :type, :route, :speed
  attr_writer :route, :vagons

  def initialize(number, type)
    @number = number
    @type = type
    @vagons = []
    self.class.add({number: num, obj_train: self})
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может менять скорость
  def change_speed(value)
    @speed = [0, speed + value].max
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может останавливаться
  def stop_run
    @speed = 0
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может добавлять вагон
  def add_vagon(vagon)
    self.vagons << vagon if speed == 0
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может отцеплять вагон
  def delete_vagon
    self.vagons.pop if speed == 0
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может устанавливать маршрут
  def set_route(value)
    self.route = value
    @current_position = 0
    current_station.add_train(self)
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может двигаться на станцию вперед
  def go_ahead
    if current_position < route.stations.size
      current_station.delete_train(self)
      @current_position += 1
      current_station.add_train(self)
    end
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может двигаться на станцию назад
  def go_back
    if current_position >= 1
      current_station.delete_train(self)
      @current_position -= 1
      current_station.add_train(self)
    end
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может двигаться на станцию назад
  def current_station
    route.stations[@current_position]
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может двигаться на станцию назад
  def next_station
    route.stations[@current_position + 1]
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может двигаться на станцию назад
  def prev_station
    route.stations[@current_position - 1] if @current_position > 0
  end  

private
  # вынесен в private, так как это свойство ( теперь даже 2 метода,
  # благодаря магии ) исключительно данного класса
  attr_accessor :current_position
 
end

require_relative 'cargo_train'
require_relative 'passenger_train'