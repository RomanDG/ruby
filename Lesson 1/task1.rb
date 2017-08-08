# Идеальный вес.

puts "Напишите ваше имя:"
name = gets.chomp.capitalize!

puts "Напишите ваш рост:"
height = gets.chomp.to_i

puts "Напишите ваш вес:"
weight = gets.chomp.to_i

if weight < ( height - 110 )
	puts "#{name} ваш вес уже оптимальный"
else
	puts "#{name} вам надо похудеть, минимум на #{weight - ( height - 110 )} килограмм"
end
