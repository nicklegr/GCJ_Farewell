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
  n, k = ris
  as = ris

  maxes = []
  n.times do
    maxes << 0
  end

  for i in 0...(1<<n)
    elems = []
    for j in 0...n
      if ((i>>j)&1) != 0
        elems << as[j]
      end
    end

    ok = true
    elems.combination(2) do |e|
      if (e[0]-e[1]).abs < k
        ok = false
        break
      end
    end

    set_size = i.popcount32

    if ok
      for j in 0...n
        if ((i>>j)&1) != 0
          maxes[j] = set_size if maxes[j] < set_size
        end
      end
    end
  end

  puts "Case ##{case_index}: #{maxes.join(" ")}"
end

STDERR.puts("time: #{Time.now - t_start} s")
