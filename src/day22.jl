module Day22

using AdventOfCode2017
using DataStructures

@enum State clean weakend infected flagged

function day22(input::String = readInput(joinpath(@__DIR__, "..", "data", "day22.txt")))
    infections, start = parse_input(input)
    p1 = part1(infections, start)
    p2 = part2(infections, start)
    return [p1, p2]
end

function parse_input(input::String)
    infectedM = map(x -> x[1] == '#' ? true : false, reduce(vcat, permutedims.(split.(split(input), ""))))
    starti, startj = size(infectedM) .÷ 2 .+ 1
    infected = DefaultDict{CartesianIndex{2},Bool}(false)
    for i = 1:size(infectedM, 1)
        for j = 1:size(infectedM, 2)
            if infectedM[i,j]
                infected[CartesianIndex(i,j)] = true
            end
        end
    end
    return infected, CartesianIndex(starti, startj)
end

function part1(infections, start)
    infections = copy(infections)
    p1 = 0
    current = start
    dir = CartesianIndex(-1, 0)
    for _ ∈ 1:10_000
        if infections[current]
            dir = turnl(dir, -1)
        else
            dir = turnl(dir, 1)
        end
        if !infections[current]
            infections[current] = true
            p1 += 1
        else
            infections[current] = false
        end
        current += dir
    end
    return p1
end

function turnl(dir, n)
    directions = (CartesianIndex(-1, 0), CartesianIndex(0, -1), CartesianIndex(1, 0), CartesianIndex(0, 1))
    return directions[mod1(findfirst(==(dir), directions) + n, 4)]
end

function part2(infections, start)
    p2 = 0
    d = DefaultDict{CartesianIndex{2},State}(clean)
    for key ∈ keys(infections)
        d[key] = infected
    end
    current = start
    dir = CartesianIndex(-1, 0)
    for _ ∈ 1:10_000_000
        if d[current] == clean
            dir = turnl(dir, 1)
        elseif d[current] == infected
            dir = turnl(dir, -1)
        elseif d[current] == flagged
            dir = turnl(dir, 2)
        end
        if d[current] == clean
            d[current] = weakend
        elseif d[current] == weakend
            p2 += 1
            d[current] = infected
        elseif d[current] == infected
            d[current] = flagged
        elseif d[current] == flagged
            d[current] = clean
        end
        current += dir
    end
    return p2
end

end # module