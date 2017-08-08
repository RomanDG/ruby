# Идеальный вес.

puts "Напишите ваше имя:"
name = gets.chomp.capitalize!

puts "Напишите ваш рост:"
height = gets.chomp.to_i

puts "Напишите ваш вес:"
weight = gets.chomp.to_i

ideal_weight = height - 110

if weight < ideal_weight
	puts "#{name} ваш вес уже оптимальный"
else
	puts "#{name} вам надо похудеть, минимум на #{ideal_weight} килограмм"
end
