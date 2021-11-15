module Day03

using AdventOfCode2017

function day03(input::String = readInput(joinpath(@__DIR__, "..", "data", "day03.txt")))
    inp = parse(Int, input)
    return [part1(inp), part2(inp)]
end

function part1(input::Int)
    n = ceil(Int, sqrt(input)) + 1
    memory = zeros(Int, n, n)
    sind = CartesianIndex(n ÷ 2 + 1, n ÷ 2 + 1)
    memory[sind] = 1
    direction = CartesianIndex(0, 1)
    ind = sind + direction
    memory[ind] = 2
    number = 3
    dir = 0

    while number <= input
        ind, dir = setnext(number, ind, dir, memory)
        number += 1
    end
    return abs.((sind - ind).I) |> sum
end

function part2(input::Int)
    n = ceil(Int, sqrt(input)) + 1
    memory = zeros(Int, n, n)
    sind = CartesianIndex(n ÷ 2 + 1, n ÷ 2 + 1)
    memory[sind] = 1
    direction = CartesianIndex(0, 1)
    ind = sind + direction
    memory[ind] = 1
    number = 3
    dir = 0

    while number <= input
        ind, dir = setnext(number, ind, dir, memory)
        number = 0
        for i = -1:1
            for j = -1:1
                i == 0 && j == 0 && continue
                number += memory[ind + CartesianIndex(i, j)]
            end
        end
        memory[ind] = number
    end
    return number
end

function getdirection(n::Int)
    n == 0 && return CartesianIndex(0, 1)
    n == 1 && return CartesianIndex(-1, 0)
    n == 2 && return CartesianIndex(0, -1)
    n == 3 && return CartesianIndex(1, 0)
end

function leftdirection(n::Int)
    return getdirection(mod(n + 1, 4))
end

function setnext(number::Int, ind::CartesianIndex{2}, dir::Int, memory::Matrix{Int})
    leftdir = leftdirection(dir)
    leftind = ind + leftdir
    if memory[leftind] == 0
        memory[leftind] = number
        return leftind, mod(dir + 1, 4)
    end
    ind = ind + getdirection(dir)
    memory[ind] = number
    return ind, dir
end

end # module