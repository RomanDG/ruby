class Station

  @@stations = []

  def self.all
    @@stations
  end

  # здесь я оставил все в public так как используется обьектами из вне
  attr_accessor :trains, :name

  LANG_STATION_NAME = /^[а-яА-ЯёЁ\s]+$/
  
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
  end

  # не совсем понятно для чего нужен метод, "valid?", и для чего он должен возвращать: true false
  # если при инициализации идет проверка данных и выбрасывается исключение, котрое по задумке должно
  # обрабатываться в main.rb. какой смысл? может быть я чего то не понимаю из-за того что этот метод 
  # будет задействован в будущем. пока не ясно. а может и я вообще не так понял задание :)
  def valid?
    validate!
  rescue
    false
  end

  def add_train(train)  
    self.trains.push(train)
  end

  def delete_train(train)
    self.trains.delete_if do |item|
      item.type == train.type && item.number == train.number
    end
  end

  def get_trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  protected

  def validate!
    raise "название станции содержит латинские буквы" if name !~ LANG_STATION_NAME
    raise "название станции содержит больше двух слов" if name.split.size > 2
    true
  end
end