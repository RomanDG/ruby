hash = Hash.new
num = 1;

("a".."z").each do |i|
  hash[i.intern] = num
  num += 1
end