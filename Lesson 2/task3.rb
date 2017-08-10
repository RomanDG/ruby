
mass = []
num = 0

def fib(num)
  return num < 3 : 1 ? fib(num-1) + fib(num-2)
end

loop do
  num += 1
  fib(num) > 100 ? break : mass << fib(num)
end