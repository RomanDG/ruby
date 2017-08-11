
arr = []
index = 0

loop do
  if index < 3
    arr << 1
  else
    arr << arr[index-1] + arr[index-2]
  end

  if arr[index] > 100
    arr.delete_at(-1) && break
  end
  index += 1
end