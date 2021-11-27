module Day13

using AdventOfCode2017

function day13(input::String = readInput(joinpath(@__DIR__, "..", "data", "day13.txt")))
    sp = split.(split(rstrip(input), "\n"), ":")
    layers = [parse(Int, x[1]) for x in sp]
    ranges = [parse(Int, x[2]) for x in sp]
    return [part1(layers, ranges), part2(layers, ranges)]
end

function part1(layers::Vector{Int}, ranges::Vector{Int})
    s = 0
    for (l, r) in zip(layers, ranges)
        if isatstart(r, l)
            s += l * r
        end
    end
    return s
end

function part2(layers::Vector{Int}, ranges::Vector{Int})
    delay = 1
    # Brute force seems to be fast enough for this problem:
    while true
        @label next
        for (l, r) in zip(layers, ranges)
            if isatstart(r, l + delay)
                delay += 1
                @goto next
            end
        end
        break
    end
    return delay
end

function isatstart(r::Int, pico::Int)
    return mod(pico, 2*(r - 1)) == 0
end

end # module
