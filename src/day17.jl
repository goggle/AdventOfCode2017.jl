module Day17

using AdventOfCode2017

function day17(input::String = readInput(joinpath(@__DIR__, "..", "data", "day17.txt")))
    nsteps = parse(Int, input)
    next = build_circular_list(nsteps, 2017)
    p1 = next[next[findfirst(next .== 2018)]] - 1
    return [p1, part2(nsteps)]
end

function build_circular_list(nsteps::Int, m::Int)
    next = zeros(Int, m + 1)
    next[1] = 1
    p = 1
    len = 1
    for n = 1:m
        for _ = 1:mod(nsteps, len)
            p = next[p]
        end
        next[n+1] = next[p]
        next[p] = n+1
        p = next[p]
        len += 1
    end
    return next
end

function part2(nsteps::Int)
    # Do not build the circular list explicitely.
    # Instead, only keep track of the values that are
    # inserted after the 0.
    cp = 0
    cn = 0
    l = 1
    for n = 1:50_000_000
        cp = mod(cp + nsteps, l)
        if cp == 0
            cn = n
        end
        l += 1
        cp = mod(cp + 1, l)
    end
    return cn
end


end # module