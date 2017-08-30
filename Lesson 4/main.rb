require_relative 'class/station'
require_relative 'class/route'
require_relative 'class/train/train'
require_relative 'class/vagon/vagon'

$trains = []
$stations = []
$routes = []

$main_menu = [
  "введите номер интересующей вас категории:",
  "[1] - станции",
  "[2] - поезда",
  "[3] - маршруты"
]

$stations_menu = [
  "введите номер желаемого действия:",
  "[1] - показать все станции",
  "[2] - показать все поезда на станции",
  "[3] - возврат в главное меню"
]

$trains_menu = [
  "введите номер желаемого действия:",
  "[1] - добавить маршрут для поезда",
  "[2] - присоединить вагон",
  "[3] - отсоединить вагон",
  "[4] - ехать на станцию вперед",
  "[5] - вернуться на станцию назад",
  "[6] - возврат в главное меню"
]

$routs_menu = [
  "введите номер желаемого действия:",
  "[1] - добавить станцию",
  "[2] - удалить станцию",
  "[3] - возврат в главное меню"
]

def train_actions(train = -1)
  loop do
    $trains_menu.each{ |item| puts item }  # меню операций с конкретным поездом
    action = gets.chomp.to_i            
    case action
    when 1  # добавить маршрут для поезда
      puts "введите номер нужного маршрута:"
      $routes.each_with_index do |route, index|
        puts "[#{index}] - #{route.stations.each {|station| station.name}}"
      end
      route_number = gets.chomp.to_i
      $trains[train].set_route($routes[route_number])
      next
    when 2  # присоединить вагон к поезду
      loop do
        puts 
        if $trains[train].type == "cargo"
          $trains[train].add_vagon(CargoVagon.new("cargo"))
        else
          $trains[train].add_vagon(PassengerVagon.new("passenger"))
        end
        puts "вагон добавлен, для добавления нового вагона введите: [1],
        для возврата в главное меню введите: [exit]"
        data = gets.chomp
        break if data == "exit"
        next  if data.to_i == 1
      end
      next             
    when 3  # отсоединить вагон от поезда
      loop do
        if $trains[train].vagons.size >= 1
          $trains[train].delete_vagon
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
      next               
    when 4  # ехать на станцию вперед
      loop do
        $trains[train].go_ahead
        puts "вы успешно переместились вперед, выберити следующее действие:"
        puts "[exit] - для выхожа в главное менюб [1] - для движения на следующую станцию"
        data = gets.chomp
        break if data == "exit"
        next  if data.to_i == 1 
      end             
    when 5  # вернуться на станцию назад
      loop do
        $trains[train].go_back
        puts "вы успешно вернулись назад, выберити следующее действие:"
        puts "[exit] - для выхожа в главное менюб [1] - для возвращения еще на 1 станцию"
        data = gets.chomp
        break if data == "exit"
        next  if data.to_i == 1 
      end               
    when 6  #возврат в главное меню
      break
    end
  end
end

loop do
  $main_menu.each{ |item| puts item }
  action = gets.chomp.to_i
  case action
    when 1  # станции
      puts "введите номер желаемого действия:"
      puts "[1] - создать станцию"
      puts "[2] - операции с созданными станциями"
      puts "[3] - возврат в главное меню"
      action = gets.chomp.to_i
      case action
        when 1  # создание станции
          loop do 
            puts "название станции:"
            data = gets.chomp
            if data.empty?
              puts "выввели пустую строку, попробуйте снова..."
              next
            else
              $stations.push(Station.new(data))
              break
            end
          end
          next
        when 2  # операции со станциями
          loop do
            puts "введите номер желаемого действия:"
            puts "[1] - показать все станции"
            puts "[2] - показать все поезда на станции"
            puts "[3] - возврат в главное меню"
            action = gets.chomp.to_i
            case action
              when 1  # показать все станции
                $stations.each { |station| puts "станция: #{station.name}" }
                next
              when 2  # показать все поезда на станции
                loop do 
                  puts "название станции:"
                  data = gets.chomp
                  if data.empty?
                    puts "выввели пустую строку, попробуйте снова..."
                    next
                  else
                    $stations.each { |station| puts station.trains if station.name == data }
                    break
                  end
                end
                next
              when 3
                break
            end
          end
        when 3  # возврат в главное меню
          next
      end
      $stations_menu.each{ |item| puts item }
      action = gets.chomp.to_i

    when 2  # поезда
      puts "введите номер желаемого действия:"
      puts "[1] - создать поезд"
      puts "[2] - операции с созданными поездами"
      puts "[3] - возврат в главное меню"
      action = gets.chomp.to_i
      case action
        when 1  # создать поезд, и операции с уже созданным поездом
          loop do
            puts "введите номер и тип поезда ( напр: 12345 cargo / passenger ):"
            data = gets.chomp.split(" ")
            if data.empty?
              puts "выввели пустую строку, попробуйте снова..."
              next
            else
              $trains.push(Train.new(data[0], data[1]))
              puts "поезд успешно создан."
              break
            end
          end
          train_actions
          next
        when 2  # операции с поездами по номеру поезда
          puts "сиписох поездов:"
          $trains.each_with_index do |train, index|
            puts "[#{index}] - поезд номер #{train.number}, тип поезда: #{train.type}" 
          end
          puts "введите номер пункта, для дальнейших операций с выбраным поездом:"
          train_number = gets.chomp.to_i - 1          
          train_actions(train_number)
          next
      end

    when 3
      puts "введите номер желаемого действия:"
      puts "[1] - создать маршрут"
      puts "[2] - операции с созданными маршрутами"
      puts "[3] - возврат в главное меню"
      action = gets.chomp.to_i

      case action
        when 1  # создать маршрут
          loop do
            puts "перед вами список всех доступных станций:"
            $stations.each_with_index { |station, index| puts "[#{index}] - станция: #{station.name}" }
            puts "выберите и укажите первую и последнюю станцию в маршруте по пункту, например [1 3]:"
            first, last = gets.chomp.split(" ")
            $routes.push(Route.new($stations[first.to_i], $stations[last.to_i]))
            puts "маршрут спешно создан"
            break
          end
        when 2 # операции над маршрутами
          puts "перед вами список всех доступных маршрутов:"
          $routes.each_with_index { |route, index| puts "[#{index}] - маршрут: #{route.stations}" }  
          puts "выберите и укажите номер маршрута по пункту, над которым будет производиться действие"    
          route_num = gets.chomp.to_i
          loop do
            $routs_menu.each { |item| puts item }
            action = gets.chomp.to_i

            case action
            when 1
              puts "перед вами список всех доступных станций:"
              $stations.each_with_index { |station, index| puts "[#{index}] - станция: #{station.name}" }
              puts "выберите и укажите номер станции по пункту, над которой будет производиться действие"
              station_num = gets.chomp.to_i              
              $routes[route_num].add_station($stations[station_num])
              puts "станция успешно добавлена в маршрут"
              next
            when 2
              puts "перед вами список всех доступных станций на данном маршруте:"
              $routes[route_num].each_with_index do |station, index|
                puts "[#{index}] - станция: #{station.name}"
              end
              puts "выберите и укажите номер станции по пункту, над которой будет производиться действие"              
              station_num = gets.chomp.to_i
              $routes[route_num].delete_station($stations[station_num].name)
              puts "станция успешно удалена из маршрута"
              next
            when 3
              break
            end
          end
        when 3
          break
      end
  end
end
