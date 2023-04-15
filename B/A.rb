require 'pp'

def ppd(*arg)
  if $DEBUG
    arg.each do |e|
      PP.pp(e, STDERR)
    end
  end
end

def putsd(*arg)
  if $DEBUG
    STDERR.puts(*arg)
  end
end

def parrd(arr)
  putsd arr.join(" ")
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  count.times do
    words << readline.chomp
  end
  words
end

def puts_sync(str)
  puts str
  STDOUT.flush
end

def array_2d(r, c)
  ret = []
  r.times do
    ret << [0] * c
  end
  ret
end

class Integer
  def popcount32
    bits = self
    bits = (bits & 0x55555555) + (bits >>  1 & 0x55555555)
    bits = (bits & 0x33333333) + (bits >>  2 & 0x33333333)
    bits = (bits & 0x0f0f0f0f) + (bits >>  4 & 0x0f0f0f0f)
    bits = (bits & 0x00ff00ff) + (bits >>  8 & 0x00ff00ff)
    return (bits & 0x0000ffff) + (bits >> 16 & 0x0000ffff)
  end

  def combination(k)
    self.factorial/(k.factorial*(self-k).factorial)
  end

  def permutation(k)
    self.factorial/(self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  n = ri
  as = ris
  la, ra, lb, rb = ris

  cul_a = [0]
  for i in 0...n
    cul_a << cul_a[i] + as[i]
  end
ppd cul_a

  sum = 0
  if ra < lb
    # 111122211111111
    # aaaaaa
    #          bbbb
    a = ra
    b = lb
    loop do
      a += 1 if a < b
      b -= 1 if a < b
      break if a == b
    end
    # sum = as[0..a-1].sum
    sum = cul_a[a] - cul_a[0]
  elsif rb < la
    # 111122211111111
    #          aaaa
    # bbbbbb
    a = la
    b = rb
    loop do
      a -= 1 if b < a
      b += 1 if b < a
      break if a == b
    end
    # sum = as[a-1..-1].sum
    sum = cul_a[n] - cul_a[a-1]
  elsif ra == lb
    # 12345678
    # aaaaa
    #     bbbb
    # sum = as[0..ra-1].sum
    sum = cul_a[ra] - cul_a[0]
  elsif rb == la
    # 12345678
    #     aaaa
    # bbbbb
    # sum = as[la-1..-1].sum
    sum = cul_a[n] - cul_a[la-1]
  else
    # 12345678
    # aaaaa
    #    bbbbb
    # a4 -> b5
    # a5 -> b4 or b6の和が多い側
    for i in la-1..ra-1
      # sum_l = as[0..i].sum
      # sum_r = as[i...n].sum
      sum_l = cul_a[i+1] - cul_a[0]
      sum_r = cul_a[n] - cul_a[i]

      sum_i = [sum_l, sum_r].min
ppd "#{i}, #{sum_i}"
      sum = [sum, sum_i].max
    end
  end

  puts "Case ##{case_index}: #{sum}"
end

STDERR.puts("time: #{Time.now - t_start} s")

__END__

少しもかぶってない場合は一番bobに近い方から開始
111122211111111
aaaaaa
         bbbb
その後お互い距離を詰めるのが最適

12345678
aaaaa
    bbbb
a5,b6

12345678
aaaaa
   bbbbb
a4 -> b5
a5 -> b4 or b6の和が多い側

119111111
aaaaa
   bbbbbb
