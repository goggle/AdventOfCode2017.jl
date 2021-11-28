module Day15

using AdventOfCode2017

function day15(input::String = readInput(joinpath(@__DIR__, "..", "data", "day15.txt")))
    start = parse.(Int, map(x -> x[end], split.(split(rstrip(input), "\n"))))
    return [part1!(copy(start)), part2!(start)]
end

function part1!(numbers::Vector{Int})
    s = 0
    for i = 1:40_000_000
        numbers[1] = mod(numbers[1] * 16807, 2147483647)
        numbers[2] = mod(numbers[2] * 48271, 2147483647)
        if match16(numbers)
            s += 1
        end
    end
    return s
end

function part2!(numbers::Vector{Int})
    s = 0
    for i = 1:5_000_000
        while true
            numbers[1] = mod(numbers[1] * 16807, 2147483647)
            mod(numbers[1], 4) == 0 && break
        end
        while true
            numbers[2] = mod(numbers[2] * 48271, 2147483647)
            mod(numbers[2], 8) == 0 && break
        end
        if match16(numbers)
            s += 1
        end
    end
    return s
end

function match16(numbers::Vector{Int})
    for i = 0:15
        mod(numbers[1] >> i, 2) != mod(numbers[2] >> i, 2) && return false
    end
    return true
end

end # module
