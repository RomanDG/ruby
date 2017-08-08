# Прямоугольный треугольник.

puts "Напишите длину первой стороны треугольника:"
a = gets.chomp.to_f

puts "Напишите длину второй стороны треугольника:"
b = gets.chomp.to_f

puts "Напишите длину третьей стороны треугольника:"
c = gets.chomp.to_f


if a > b && a > c
	hyp, cat1, cat2 = a, b, c
elsif b > a && b > c
	hyp, cat1, cat2 = b, a, c
elsif c > a && c > b
	hyp, cat1, cat2 = c, a, b
end

puts "Треугольник является прямоугольным" if ((cat1**2 + cat2**2) == hyp**2)

if a == b || a == c || b == c
		puts "Треугольник является равнобедренным"
end

if a == b && a == c && b == c
		puts "Треугольник является равнобедренным и равносторонним"
end

