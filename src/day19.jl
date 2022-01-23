module Day19

using AdventOfCode2017

function day19(input::String = readInput(joinpath(@__DIR__, "..", "data", "day19.txt")))
    board = map(x -> x[1], reduce(vcat, permutedims.(split.(split(replace(input, " " => '#')), ""))))
    start = findfirst(x -> x == '|', board[1,:])
    current = CartesianIndex(1, start)
    nsteps = 0
    dir = CartesianIndex(1, 0)
    collected = []
    while true
        nsteps += 1
        if isletter(board[current])
            push!(collected, board[current])
        end
        if board[current + dir] != '#'
            current += dir
        elseif board[current + left(dir)] != '#'
            dir = left(dir)
            current += dir
        elseif board[current + right(dir)] != '#'
            dir = right(dir)
            current += dir
        else
            break
        end
    end
    return [join(collected), nsteps]
end

left(ind::CartesianIndex) = CartesianIndex(-ind[2], ind[1])
right(ind::CartesianIndex) = CartesianIndex(ind[2], -ind[1])

end # module