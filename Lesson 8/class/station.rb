class Station

  @@stations = []

  def self.all
    @@stations
  end

  # здесь я оставил все в public так как используется обьектами из вне
  attr_accessor :trains, :name

  NAME_FORMAT = /^[а-яА-ЯёЁ\s]+$/
  
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  # метод, который принимает блок и проходит по всем поездам на станции
  def show_trains()
    block = ->(train) do
      puts %{
        Номер поезда:\t#{train.number}
        Тип поезда:\t#{train.type}
        К-во вагонов:\t#{train.num_of_vagons}

        #{info_of_vagons(train).each{|value| value}}
      }
    end
    trains.each{|train| _trains(train, &block)}
  end

  def info_of_vagons(train)
    train.vagons.map.with_index do |vagon, index|
      if vagon.type == "passenger"
        ratio = "#{vagon.get_free_places} / #{vagon.get_not_free_places}"
      elsif vagon.type == "cargo"
        ratio = "#{vagon.get_free_volume} / #{vagon.get_not_free_volume}"
      end

      %{
        * Информация о вагонах:
          Номер вагона: #{index+1}
          Тип вагона: #{vagon.type}
          Своб. место: #{ratio}
      }
    end
  end

  def valid?
    validate!
    true
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
    raise "название станции содержит латинские буквы" if name !~ NAME_FORMAT
    raise "название станции не должно иметь разделяющих пробелов" if name.split.size > 2
  end

  private

  def _trains(t)
    yield(t)
  end
end