
class Station
  attr_accessor :name, :trains
  
  def initialize name
    @name = name
    @trains = []
    puts "станция #{name}"
  end

  #добавляем обьект класса Train
  def add_train(train)  
    trains.push(train)
  end

  def del_train(type, number)
    trains.delete_if do |train|
      train.type == type && train.number == number
    end
  end

  def get_all_trains
    puts "на станции находятся поезда:"
    trains.each do |train|
      puts "#{train.type} поезд номер - #{train.number}"
    end
  end

  def get_trains_by_type(type)
    if type == "пассажирский"
      type_trains = "пассажирские"
    elsif type == "грузовой"
      type_trains = "грузовые"
    end
    puts "на станции находятся #{type_trains} поезда:"
    trains.each do |train|
      puts "#{train.type} поезд номер - #{train.number}" if train.type == type
    end    
  end
end