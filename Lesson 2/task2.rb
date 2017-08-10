
mass = []

for i in (10..100)
  i % 5 == 0 && mass << i
end