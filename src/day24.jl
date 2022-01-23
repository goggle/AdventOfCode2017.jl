module Day24

using AdventOfCode2017

struct Component
    one::Int
    two::Int
end

function Base.:(==)(c::Component, o::Component)
    return (c[1] == o[1] && c[2] == o[2]) || (c[1] == o[2] && c[2] == o[1])
end

function Base.getindex(c::Component, i::Int)
    i == 1 && return c.one
    return c.two
end

# function Base.show(io::IO, c::Component)
#     print(io, "[$(c.one), $(c.two)]")
# end

function day24(input::String = readInput(joinpath(@__DIR__, "..", "data", "day24.txt")))
    components = map(x -> Component(parse(Int, x[1]), parse(Int, x[2])), split.(split(rstrip(input), '\n'), '/'))
    p1, longest = part1(components)
    p2 = part2(components, longest)
    return [p1, p2]
end

function part1(components)
    maxsum, longest = 0, 0
    for elem ∈ components
        elem[1] != 0 && continue
        s, l = solve(components, [elem], [0], elem[1] + elem[2], [1], a -> true)
        if s > maxsum
            maxsum = s
        end
        if l > longest
            longest = l
        end
    end
    return maxsum, longest
end

function part2(components, longest)
    maxsum = 0
    for elem ∈ components
        elem[1] != 0 && continue
        s, _ = solve(components, [elem], [0], elem[1] + elem[2], [1], a -> length(a) == longest)
        if s > maxsum
            maxsum = s
        end
    end
    return maxsum
end

function solve(components, path, maxsum, s, longest, condition)
    for elem ∈ components
        if (path[end][2] == elem[1] || path[end][2] == elem[2]) && elem ∉ path
            if path[end][2] != elem[1]
                elem = Component(elem[2], elem[1])
            end
            push!(path, elem)
            s += elem[1] + elem[2]
            solve(components, path, maxsum, s, longest, condition)
            if condition(path) && s > maxsum[1]
                maxsum[1] = s
            end
            if length(path) > longest[1]
                longest[1] = length(path)
            end
            pop!(path)
            s -= (elem[1] + elem[2])
        end
    end
    return maxsum[1], longest[1]
end

end # module