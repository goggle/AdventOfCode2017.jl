module Day05

using AdventOfCode2017

function day05(input::String = readInput(joinpath(@__DIR__, "..", "data", "day05.txt")))
    offsets = parse.(Int, split(input))
    return [part1!(copy(offsets)), part2!(offsets)]
end

function part1!(offsets)
    counter = 0
    n = length(offsets)
    i = 1
    while i >= 1 && i <= n
        off = offsets[i]
        offsets[i] += 1
        i += off
        counter += 1
    end
    return counter
end

function part2!(offsets)
    counter = 0
    n = length(offsets)
    i = 1
    while i >= 1 && i <= n
        off = offsets[i]
        if offsets[i] >= 3
            offsets[i] -= 1
        else
            offsets[i] += 1
        end
        i += off
        counter += 1
    end
    return counter
end

end # module