module Day10

using AdventOfCode2017

function day10(input::String = readInput(joinpath(@__DIR__, "..", "data", "day10.txt")))
    lengths = parse.(UInt8, split(rstrip(input), ","))
    a = collect(0:255)
    run!(lengths; a)
    part1 = a[1]*a[2]

    lengths = vcat(Vector{UInt8}(rstrip(input)), Vector{UInt8}([17, 31, 73, 47, 23]))    
    return [part1, part2(lengths)]
end

function reverse!(a::Vector{Int}, start::Int, len::UInt8)
    n = length(a)
    start = mod1(start, n)
    e = mod1(start + len - 1, n)
    if start <= e
        a[start:e] = reverse(a[start:e])
    else
        l = 0
        while l < len ÷ 2
            a[start], a[e] = a[e], a[start]
            start = mod1(start + 1, n)
            e = mod1(e - 1, n)
            l += 1
        end
    end
end

function run!(lengths::Vector{UInt8}; a::Vector{Int} = collect(0:255), curr = 1, skip = 0)
    n = length(a)
    current = curr
    skipsize = skip
    for len in lengths
        s = current
        e = mod1(current + len - 1, n)
        reverse!(a, s, len)
        current = mod1(current + len + skipsize, n)
        skipsize += 1
    end
    current, skipsize
end

function part2(lengths::Vector{UInt8})
    hash = collect(0:255)
    curr = 1
    skip = 0
    for i = 1:64
        curr, skip = run!(lengths; a=hash, curr=curr, skip=skip)
    end
    densehash = Vector{UInt8}(undef, 16)
    for i = 1:16
        densehash[i] = xor(hash[(16*(i-1)+1):16*i]...)
    end
    return bytes2hex(densehash)
end

end # module