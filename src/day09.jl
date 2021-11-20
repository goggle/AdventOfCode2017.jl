module Day09

using AdventOfCode2017

function day09(input::String = readInput(joinpath(@__DIR__, "..", "data", "day09.txt")))
    cleaned_input, part2 = clean_garbage(rstrip(input))
    return [part1(cleaned_input), part2]
end

function clean_garbage(input::AbstractString)
    clean = Vector{Char}()
    ingarbage = false
    part2 = 0
    i = 1
    while i <= length(input)
        ch = input[i]
        if ingarbage
            if ch == '!'
                i += 1
            elseif ch == '>'
                ingarbage = false
            else
                part2 += 1
            end
        else
            if ch == '<'
                ingarbage = true
            else
                push!(clean, ch)
            end
        end
        i += 1
    end
    return clean, part2
end

function part1(input::Vector{Char})
    level = 0
    sum = 0
    for ch in input
        if ch == '{'
            level += 1
            sum += level
        elseif ch == '}'
            level -= 1
        end
    end
    return sum
end

end # module