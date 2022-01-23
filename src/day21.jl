module Day21

using AdventOfCode2017

function day21(input::String = readInput(joinpath(@__DIR__, "..", "data", "day21.txt")))
    rules = parse_input(input)
    image = ['.' '#' '.'; '.' '.' '#'; '#' '#' '#']
    step(image, rules)
end

function parse_input(input::String)
    d = Dict{Matrix{Char},Matrix{Char}}()
    for line ∈ split(rstrip(input), "\n")
        left, right = strip.(split(line, "=>"))
        leftm = map(x -> x[1], reduce(vcat, permutedims.(split.(split(replace(left, "/" => '\n')), ""))))
        rightm = map(x -> x[1], reduce(vcat, permutedims.(split.(split(replace(right, "/" => '\n')), ""))))
        d[leftm] = rightm
    end
    return d
end

function step(image, rules)
    if size(image, 1) % 2 == 0
        newsize = (size(image, 1) ÷ 2) * 3
    else
        newsize = (size(image, 1) ÷ 3) * 4
    end
    return fill('.', (newsize, newsize))
end

end # module