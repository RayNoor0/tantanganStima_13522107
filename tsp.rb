
def tsp(lastNode, visitedNode)
    if(visitedNode == $np-1)
        if($sisi[lastNode][0] != nil)
            return $memo[lastNode][visitedNode] + $sisi[lastNode][0]
        else
            return nil
        end
    end

    res = nil
    (0..$n-1).each do |i|
        next if visitedNode & 1<<i == 1<<i
        next if $sisi[lastNode][i] == nil
        curres = nil
        if($memo[i][visitedNode | 1<<i] == nil)
            $memo[i][visitedNode | 1<<i] = $memo[lastNode][visitedNode] + $sisi[lastNode][i]
            curres = tsp(i, visitedNode| 1<<i)    
        else
            if($memo[i][visitedNode|1<<i] >  $memo[lastNode][visitedNode] + $sisi[lastNode][i])
                $memo[i][visitedNode|1<<i] = $memo[lastNode][visitedNode] + $sisi[lastNode][i]
                curres = tsp(i, visitedNode| 1<<i)
            end
        end

        if(curres != nil)
            if(res == nil)
                res = curres
            else
                res = [res, curres].min
            end
        end
    end
    return res
end

def solve()
    if($n == 1)
        return 0
    else
        $memo[0][1] = 0
        return tsp(0,1)
    end
end

# awalprogram
# take input
$n = -1
while ($n < 1) do
    puts "Masukkan jumlah simpul:"
    $n = gets.chomp.to_i
end
$np = 2**$n
$sisi = Array.new($n) { Array.new($n) }
$memo = Array.new($n) { Array.new($np) }

# input data
puts "Masukkan data sisi dalam bentuk weighted adjacency matrix"
puts "Masukkan perbaris dengan contoh seperti berikut"
puts "0 10 15 20"
puts "5 0 9 10"
puts "6 13 0 12"
puts "8 8 9 0"
puts "data sisi:"
i = 0
while i<$n do
    arrayInp = gets.chomp.split().map { |e| e.to_i  }
    (0..$n-1).each do |j|
        next if(arrayInp[j] <= 0)
        $sisi[i][j] = arrayInp[j]
        j += 1
    end
    i += 1
    j = 0
end

result = solve()

if(result == nil)
    puts "Solusi tidak ditemukan"
else
    puts "Panjang rute terdekat untuk kasus ini adalah #{result}"
end
