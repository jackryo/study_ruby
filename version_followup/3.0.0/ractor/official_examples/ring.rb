RN = 20
CR = Ractor.current

# 先頭となる ractor
r = Ractor.new do
  p Ractor.receive
  CR << :fin
end

(RN - 1).times {
  r = Ractor.new r do |next_r|
    n = Ractor.receive
    p n
    # インクリメントして次の ractor に send する
    # next とあるが、一つ前のループで作った ractor 
    next_r << n + 1
  end
}

p :setup_ok
# 一番後ろの ractor に数値を渡す
r << 1
p Ractor.receive