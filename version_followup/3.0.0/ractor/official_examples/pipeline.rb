# yield/take
r1 = Ractor.new do
  'r1 >> '
end

r2 = Ractor.new r1 do |r1|
  # r1 からとってくる
  r1.take + 'r2 >> '
end

r3 = Ractor.new r2 do |r2|
  # r2 からとってくる
  r2.take + 'r3 >> finish'
end

p r3.take


# send/receive
r3 = Ractor.new Ractor.current do |cr|
  cr.send Ractor.receive + 'r3 >> finish'
end

r2 = Ractor.new r3 do |r3|
  # 受け取って r3 へ送る
  r3.send Ractor.receive + 'r2 >> '
end

r1 = Ractor.new r2 do |r2|
  # 受け取って r2 へ送る
  r2.send Ractor.receive + 'r1 >> '
end

r1 << ''
p Ractor.receive