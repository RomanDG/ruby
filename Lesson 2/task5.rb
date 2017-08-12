puts "напишите число"
day = gets.chomp.to_i

puts "напишите месяц"
month = gets.chomp.to_i

puts "напишите год"
year = gets.chomp.to_i

month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
number = 0

number += day

if ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)
  number += 1 if month > 2
end

for i in (1..12)
  i < month && number += month_days[i-0]
end

puts "порядковый номер даты в году: #{number}"