module Day14

using AdventOfCode2017

function day14(input::String = readInput(joinpath(@__DIR__, "..", "data", "day14.txt")))
    grid = build_grid(input)
    p1 = grid |> count
    p2 = part2!(grid)
    return [p1, p2]
end

function build_grid(input::String)
    input = rstrip(input)
    grid = BitArray(undef, 128, 128)
    for i = 0:127
        s = input * "-$i"
        lengths = vcat(Vector{UInt8}(rstrip(s)), Vector{UInt8}([17, 31, 73, 47, 23]))
        hash = AdventOfCode2017.Day10.part2(lengths)
        bitstr = join(bitstring.(hex2bytes(hash)))
        grid[i+1, :] = [x == '1' for x in bitstr]
    end
    return grid
end

function part2!(grid::BitArray)
    ngroups = 0
    while true
        f = findfirst(x -> x == true, grid)
        f === nothing && break
        current = [f]
        ngroups += 1
        while length(current) > 0
            c = popfirst!(current)
            grid[c] = false
            for (x, y) in ((1, 0), (-1, 0), (0, 1), (0, -1))
                ci, cj = c[1] + x, c[2] + y
                !(ci >= 1 && cj >= 1 && all((ci, cj) .<= size(grid))) && continue
                if grid[ci, cj]
                    push!(current, CartesianIndex(ci, cj))
                end
            end
        end
    end
    return ngroups
end

end # module