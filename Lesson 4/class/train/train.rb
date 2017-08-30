class Train
  # это public магия, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может испоьзовать их  
  attr_reader :speed, :vagons, :number, :type, :route, :vagon
  attr_writer :route, :speed, :vagons, :vagon

  def initialize(number, type)
    @number = number
    @type = type
    @vagons = []
    @speed = 0
    @route = nil
    @current_position = nil
    @vagon = nil
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может менять скорость
  def change_speed(value)
    self.speed = [0, self.speed + value].max
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может останавливаться
  def stop_run
    self.speed = 0
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может добавлять вагон
  def add_vagon(vagon)
    self.vagons.push(vagon) if speed == 0
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
      current_station.delete_train(type, number)
      @current_position += 1
      current_station.add_train(self)
    end
  end

  # это public метод, так как любой обьект наследуемого класса
  # (пассажирский или грузовой поезд) может двигаться на станцию назад
  def go_back
    if current_position >= 1
      current_station.delete_train(type, number)
      @current_position -= 1
      current_station.add_train(self)
    end
  end


private
  # вынесен в private, так как это свойство ( теперь даже 2 метода,
  # благодаря магии ) исключительно данного класса
  attr_accessor :current_position

  # вынесен в private, так как данный метод, используется исключительно
  # внутри этого класса, другими методами движения вперед и назад для 
  # получения координат
  def current_station
    route.stations[current_position]
  end

  # вынесен в private, так как данный метод, пока нигде не испотзуется
  # и мы спрятали его, "от греха подальше" :) . Скорее всего он так же будет
  # использоваться только внутри класса, как и вышенаписаный метод
  def next_station
    route.stations[current_position + 1]
  end

  # вынесен в private, так как данный метод, пока нигде не испотзуется
  # и мы спрятали его, "от греха подальше" :) . Скорее всего он так же будет
  # использоваться только внутри класса, как и вышенаписаный метод
  def prev_station
    route.stations[current_position - 1] if current_position > 0
  end  
end

require_relative 'cargo_train'
require_relative 'passenger_train'