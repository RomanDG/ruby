# Квадратное уравнение.

puts "Введите первый коэффициент:"
a = gets.chomp.to_i

puts "Введите второй коэффициент:"
b = gets.chomp.to_i

puts "Введите третий коэффициент:"
c = gets.chomp.to_i

d = b**2 - 4*a*c

if d < 0
	puts "Дискриминант = #{d}, корней нет"
elsif d == 0
	puts "Дискриминант = #{d}, корни равны #{(-b + Math.sqrt(d)) / (2*a)}"
elsif d > 0
	x1 = (-b + Math.sqrt(d)) / (2*a)
	x2 = (-b - Math.sqrt(d)) / (2*a)
	puts "Дискриминант = #{d}, корень - 1 равен: #{x1}, корень - 2 равен: #{x2}"
end