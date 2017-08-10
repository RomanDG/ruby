
hash = Hash.new
all_sum = 0;

loop do
  print "напишите название товара: "
  item = gets.chomp

  break if item == "стоп"

  print "напишите цену товара: "
  price = gets.chomp.to_i

  print "напишите количество товара: "
  qty = gets.chomp.to_i

  hash[item.intern] = {price: price, qty: qty}
end

puts "хеш: #{hash}"

hash.each do |k,v|
  sum = v[:price] * v[:qty]
  all_sum += sum
  puts "итоговая сумма за покупку #{k}: #{sum}"
end

puts "итоговая сумма всех покупок: #{all_sum}"