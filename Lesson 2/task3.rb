
mass = []
index = 0

loop do
  if index < 3
    mass << 1
  else
    mass << mass[index-1] + mass[index-2]
  end

  if mass[index] > 100
    mass.delete_at(-1) && break
  end
  index += 1
end