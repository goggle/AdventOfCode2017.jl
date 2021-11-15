module Day06

using AdventOfCode2017

function day06(input::String = readInput(joinpath(@__DIR__, "..", "data", "day06.txt")))
    blocks = parse.(Int, split(input))
    return solve!(copy(blocks))
end

function solve!(blocks::Vector{Int})
    part1 = 0
    counter = 0
    already_seen = Set{Vector{Int}}()
    push!(already_seen, copy(blocks))
    while true
        counter += 1
        max = maximum(blocks)
        i = findfirst(x -> x == max, blocks)
        blocks[i] = 0
        for j = 1:max
            i = mod1(i + 1, length(blocks))
            blocks[i] += 1
        end
        if blocks ∈ already_seen
            if part1 == 0
                part1 = counter
                counter = 0
                already_seen = Set{Vector{Int}}()
                push!(already_seen, copy(blocks))
            else
                return [part1, counter]
            end
        else
            push!(already_seen, copy(blocks))
        end
    end
end

end # module