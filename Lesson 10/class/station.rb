require_relative '../modules/validation'

class Station
  @@stations = []

  def self.all
    @@stations
  end

  include Validation

  NAME_FORMAT = /^[а-яА-ЯёЁ\s]+$/

  # здесь я оставил все в public так как используется обьектами из вне
  attr_accessor :trains, :name

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def initialize(name)
    @name = name
    @trains = []
    # validate!
    @@stations << self
  end

  # метод, который принимает блок и проходит по всем поездам на станции
  def show_trains
    trains.each do |train|
      yield(train)
    end
  end

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  def add_train(train)
    trains.push(train)
  end

  def delete_train(train)
    trains.delete_if do |item|
      item.type == train.type && item.number == train.number
    end
  end

  def get_trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  protected

  # def validate!
  #   raise 'название станции содержит латинские буквы' if name !~ NAME_FORMAT
  #   raise 'название станции не должно иметь разделяющих пробелов' if name.split.size > 2
  # end
end
