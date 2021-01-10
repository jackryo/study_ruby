def make_ractor r, i
  Ractor.new r, i do |r, i|
    loop do
      msg = Ractor.receive
      raise if /e/ =~ msg
      r.send msg + "r#{i}"
    end
  end
end

r = Ractor.current
rs = (1..10).map { |i|
  r = make_ractor(r, i)
}

msg = 'e0'
begin
  r.send msg
  p Ractor.select(*rs, Ractor.current)
rescue Ractor::RemoteError
  # エラーとなる文字列を受け取った時、一番最後尾の ractor を作り直す
  r = rs[-1] = make_ractor(rs[-2], rs.size)
  msg = 'x0'
  retry
end