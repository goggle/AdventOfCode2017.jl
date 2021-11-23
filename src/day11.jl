module Day11

using AdventOfCode2017

function day11(input::String = readInput(joinpath(@__DIR__, "..", "data", "day11.txt")))
    instructions = split(rstrip(input), ",")
    coords = [0, 0, 0]
    part2 = 0
    for instruction in instructions
        move!(coords, instruction)
        tmp = maximum(abs.(coords))
        if tmp > part2
            part2 = tmp
        end
    end
    return [maximum(abs.(coords)), part2]
end

function move!(coords::Vector{Int}, direction::AbstractString)
    if direction == "n"
        coords .+= [0, -1, 1]
    elseif direction == "s"
        coords .+= [0, 1, -1]
    elseif direction == "se"
        coords .+= [1, 0, -1]
    elseif direction == "nw"
        coords .+= [-1, 0, 1]
    elseif direction == "sw"
        coords .+= [-1, 1, 0]
    elseif direction == "ne"
        coords .+= [1, -1, 0]
    end
end


end # module
