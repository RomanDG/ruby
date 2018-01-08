require_relative 'class/station'
require_relative 'class/route'
require_relative 'class/train/train'
require_relative 'class/vagon/vagon'

class App

  def initialize
    @trains = []
    @stations = []
    @routes = []

    @main_menu = [
      "введите номер интересующей вас категории:",
      "[1] - станции",
      "[2] - поезда",
      "[3] - маршруты"
    ]

    @stations_menu = [
      "введите номер желаемого действия:",
      "[1] - создать станцию",
      "[2] - показать все станции",
      "[3] - показать все поезда на станции",
      "[4] - показать полную информацию по станциям, и поездам находящимся на них",
      "[5] - возврат в главное меню"
    ]

    @trains_menu = [
      "введите номер желаемого действия:",
      "[1] - создать поезд",
      "[2] - добавить маршрут для поезда",
      "[3] - присоединить вагон",
      "[4] - отсоединить вагон",
      "[5] - ехать на станцию вперед",
      "[6] - вернуться на станцию назад",
      "[7] - занять место / обьем в вагоне",
      "[8] - возврат в главное меню"
    ]

    @routes_menu = [
      "введите номер желаемого действия:",
      "[1] - создать маршрут",
      "[2] - добавить станцию",
      "[3] - удалить станцию",
      "[4] - возврат в главное меню"
    ]    
  end

  def run_application
    loop do
      @main_menu.each { |item| puts item }
      action = gets.chomp.to_i
      case action
      when 1
        stations
      when 2
        trains
      when 3
        routes
      end
    end
  end

  private
    attr_accessor :trains, :stations, :routes
    attr_reader :main_menu, :stations_menu, :trains_menu, :routs_menu

    # methods for actions with the stations
    def stations
      loop do
        @stations_menu.each { |item| puts item}
        action = gets.chomp.to_i
        case action
        when 1
          create_station
        when 2
          show_all_stations         
        when 3
          show_all_trains_on_station          
        when 4
          show_full_info
        when 5
          break
        end
      end
    end

    def show_full_info
      @stations.each do |station|
        puts "Станция #{station.name}:"
        station.show_trains
        puts "----------"
      end
    end

    def create_station
      loop do 
        puts "введите название станции:"
        data = gets.chomp
        if data.empty?
          puts "выввели пустую строку, попробуйте снова..."
          next
        else
          @stations.push(Station.new(data))
          break
        end
      end      
    end

    def show_all_stations
      @stations.each { |station| puts "станция: #{station.name}" }
    end

    def show_all_trains_on_station
      loop do 
        puts "введите название станции:"
        data = gets.chomp
        if data.empty?
          puts "выввели пустую строку, попробуйте снова..."
          next
        else
          @stations.each { |station| puts station.trains if station.name == data }
          break
        end
      end      
    end

    # methods for actions with the trains
    def trains
      loop do
        @trains_menu.each { |item| puts item}
        action = gets.chomp.to_i
        case action
        when 1
          create_train
        when 2
          add_route_for_train         
        when 3
          add_vagon_to_train          
        when 4
          remove_vagon_from_train
        when 5
          go_ahead
        when 6
          go_back
        when 7
          take_space_of_vagon
        when 8
          break
        end
      end
    end

    def take_space_of_vagon
      train = trains_list
      loop do
        puts "выберите номер вагона:"

        @trains[train].vagons.each_with_index do |vagon, index|
          puts "[#{index}] - вагон номер #{index+1}"
        end
          puts "введите номер пункта, для дальнейших операций с выбраным поездом:"
        vagon_number = gets.chomp.to_i - 1   

        if @trains[train].type == "cargo".intern
          puts "введите обьем:"
          volume = gets.chomp.to_i          
          @trains[train].vagons[vagon_number-1].take_volume(volume)
        elsif @trains[train].type == "passenger".intern
          puts "введите количество:"
          places = gets.chomp.to_i
          @trains[train].vagons[vagon_number-1].add_place(places)
        end

        puts "увеличено / занято, для повтора нажмите: [1],
        для возврата в главное меню введите: [exit]"
        data = gets.chomp
        break if data == "exit"
        next  if data.to_i == 1
      end 
    end

    def trains_list
      puts "список поездов:"
      @trains.each_with_index do |train, index|
        puts "[#{index}] - поезд номер #{train.number}, тип поезда: #{train.type}" 
      end
      puts "введите номер пункта, для дальнейших операций с выбраным поездом:"
      train_number = gets.chomp.to_i - 1   
    end

    def create_train
      loop do
        begin
          puts "введите номер и тип поезда ( напр: AD-123 cargo / passenger ):"
          number, type = gets.chomp.split(" ")
          if number.empty? && type.empty?
            puts "выввели пустую строку, попробуйте снова..."
            next
          else
            if type == 'cargo'
              @trains << CargoTrain.new(number)
            elsif type == 'passenger'
              @trains << PassengerTrain.new(number)
            else
              puts "вы ошиблись в названии типа поезда, попробуйте снова"
              next
            end
            puts "поезд успешно создан."
            break
          end
        rescue
          puts "неправильный номер поезда, попробуйте еще раз"
          retry
        end
      end      
    end

    def add_route_for_train
      train = trains_list
      puts "введите номер нужного маршрута:"
      @routes.each_with_index do |route, index|
        puts "[#{index}] - #{route.stations.each {|station| station.name}}"
      end
      route_number = gets.chomp.to_i
      @trains[train].set_route(@routes[route_number])      
    end

    def add_vagon_to_train
      train = trains_list
      loop do
        if @trains[train].type == "cargo".intern
          puts "введите обьем вагона:"
          volume = gets.chomp.to_i          
          @trains[train].add_vagon(CargoVagon.new(volume))
        elsif @trains[train].type == "passenger".intern
          puts "введите количество мест в вагоне:"
          places = gets.chomp.to_i
          @trains[train].add_vagon(PassengerVagon.new(places))
        end
        puts "вагон добавлен, для добавления нового вагона введите: [1],
        для возврата в главное меню введите: [exit]"
        data = gets.chomp
        break if data == "exit"
        next  if data.to_i == 1
      end   
    end

    def remove_vagon_from_train
      train = trains_list
      loop do
        if @trains[train].vagons.size >= 1
          @trains[train].delete_vagon
          puts "вагон отсоединен, для отсоединения еще одного вагона введите: [1],
          для возврата в главное меню введите: [exit]"
          data = gets.chomp
          break if data == "exit"
          next  if data.to_i == 1
        else
          puts "железнодорожный состав пуст, вы не можете отстоединить вагон"
          break
        end 
        next
      end     
    end

    def go_ahead
      train = trains_list
      loop do
        @trains[train].go_ahead
        puts "вы успешно переместились вперед, выберити следующее действие:"
        puts "[exit] - для выхожа в главное менюб [1] - для движения на следующую станцию"
        data = gets.chomp
        break if data == "exit"
        next  if data.to_i == 1 
      end           
    end

    def go_back
      train = trains_list
      loop do
        @trains[train].go_back
        puts "вы успешно вернулись назад, выберити следующее действие:"
        puts "[exit] - для выхожа в главное менюб [1] - для возвращения еще на 1 станцию"
        data = gets.chomp
        break if data == "exit"
        next  if data.to_i == 1 
      end
    end

    # methods for actions with the trains
    def routes
      loop do
        @routes_menu.each { |item| puts item}
        action = gets.chomp.to_i
        case action
        when 1
          create_route
        when 2
          add_station
        when 3
          remove_station         
        when 4
          break
        end
      end
    end

    def create_route
      loop do
        puts "перед вами список всех доступных станций:"
        @stations.each_with_index { |station, index| puts "[#{index}] - станция: #{station.name}" }
        puts "выберите и укажите первую и последнюю станцию в маршруте по пункту, например [1 3]:"
        first, last = gets.chomp.split(" ")
        @routes.push(Route.new(@stations[first.to_i], @stations[last.to_i]))
        puts "маршрут спешно создан"
        break
      end      
    end

    def add_station
      puts "перед вами список всех доступных маршрутов:"
      @routes.each_with_index { |route, index| puts "[#{index}] - маршрут: #{route.stations}" }  
      puts "выберите и укажите номер маршрута по пункту, над которым будет производиться действие"    
      route_num = gets.chomp.to_i

      puts "перед вами список всех доступных станций:"
      @stations.each_with_index { |station, index| puts "[#{index}] - станция: #{station.name}" }
      puts "выберите и укажите номер станции по пункту, над которой будет производиться действие"
      station_num = gets.chomp.to_i              
      @routes[route_num].add_station(@stations[station_num])
      puts "станция успешно добавлена в маршрут"
    end

    def remove_station
      puts "перед вами список всех доступных маршрутов:"
      @routes.each_with_index { |route, index| puts "[#{index}] - маршрут: #{route.stations}" }  
      puts "выберите и укажите номер маршрута по пункту, над которым будет производиться действие"    
      route_num = gets.chomp.to_i

      puts "перед вами список всех доступных станций на данном маршруте:"
      @routes[route_num].each_with_index do |station, index|
        puts "[#{index}] - станция: #{station.name}"
      end
      puts "выберите и укажите номер станции по пункту, над которой будет производиться действие"              
      @tation_num = gets.chomp.to_i
      @routes[route_num].delete_station(@stations[station_num].name)
      puts "станция успешно удалена из маршрута"
    end
end

Application = App.new
Application.run_application