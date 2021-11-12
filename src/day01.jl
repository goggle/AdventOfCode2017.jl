module Day01

using AdventOfCode2017

function day01(input::String = readInput(joinpath(@__DIR__, "..", "data", "day01.txt")))
    digits = parse.(Int, split(rstrip(input), ""))
    return [part1(digits), part2(digits)]
end

function part1(digits)
    s = 0
    for i = 1:length(digits) - 1
        if digits[i] == digits[i+1]
            s += digits[i]
        end
    end
    if digits[end] == digits[1]
        s += digits[1]
    end
    return s
end

function part2(digits)
    s = 0
    for i = 1:length(digits)
        n = mod1(i + length(digits) ÷ 2, length(digits))
        if digits[i] == digits[n]
            s += digits[i]
        end
    end
    return s
end

end # module
