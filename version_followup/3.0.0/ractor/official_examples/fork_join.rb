# フィボナッチ数列
# fib(0) = 0, fib(1) = 1, fib(n) = fib(n-2) + fib(n-1) (n > 1)
def fib n
  if n == 0
    0
  elsif n == 1
    1
  else
    fib(n-2) + fib(n-1)
  end
end

RN = 10
rs = (1..RN).map do |i|
  Ractor.new i do |i|
    [i, fib(i)]
  end
end

until rs.empty?
  r, v = Ractor.select(*rs)
  rs.delete r
  p answer: v
end