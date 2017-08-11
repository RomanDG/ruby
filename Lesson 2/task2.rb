
arr = []

for i in (10..100)
  i % 5 == 0 && arr << i
end