require 'prime'

pipe = Ractor.new do
  loop do
    Ractor.yield Ractor.receive
  end
end

N = 1000
RN = 10
workers = (1..RN).map do
  Ractor.new pipe do |pipe|
    while n = pipe.take
      Ractor.yield [n, n.prime?]
    end
  end
end

# pipe ractor を通して、ランダムに各 ractor に i を送っていく
(1..N).each { |i|
  pipe << i
}

pp (1..N).map {
  _r, (n, b) = Ractor.select(*workers)
  n if b
# 順序がランダムなので昇順にソート
}.compact.sort