module Day07

using AdventOfCode2017

struct Node
    name::AbstractString
    value::Int
    children::Vector{AbstractString}
end

function day07(input::String = readInput(joinpath(@__DIR__, "..", "data", "day07.txt")))
    d = parse_input(input)
    p1 = part1(d)
    return [p1, part2(p1, d)]
end

function parse_input(input::AbstractString)
    d = Dict{AbstractString, Node}()
    lines = split(rstrip(input), "\n")
    for line in lines
        elems = split(line)
        name = elems[1]
        value = parse(Int, rstrip(lstrip(elems[2], '('), ')'))
        children = Vector{AbstractString}()
        for i = 4:length(elems)
            child = rstrip(elems[i], ',')
            push!(children, child)
        end
        d[name] = Node(name, value, children)
    end
    return d
end

function part1(dict::Dict{AbstractString, Node})
    for name in keys(dict)
        if isroot(name, dict)
            return name
        end
    end
end

function isroot(name::AbstractString, dict::Dict{AbstractString, Node})
    s = Set{String}()
    traverse!(s, name, dict)
    length(s) == length(dict) && return true
    return false
end

function traverse!(s::Set{String}, name::AbstractString, dict::Dict{AbstractString, Node})
    push!(s, name)
    for child in dict[name].children
        traverse!(s, child, dict)
    end
end

function getweight(name::AbstractString, dict::Dict{AbstractString, Node})
    s = Set{String}()
    traverse!(s, name, dict)
    su = 0
    for name in s
        su += dict[name].value
    end
    return su
end

function part2(root::AbstractString, d::Dict{AbstractString, Node})
    current = root
    correction = 0
    while true
        children = d[current].children
        values = [getweight(child, d) for child in children]
        if all(x -> x == values[1], values)
            break
        end
        nocc = [(i, count(==(i), values)) for i in unique(values)]
        wrong_val = correct_val = 0
        for (i, n) in nocc
            if n == 1
                wrong_val = i
            else
                correct_val = i
            end
        end
        correction = correct_val - wrong_val
        for (i, val) in enumerate(values)
            if val == wrong_val
                current = children[i]
                break
            end
        end
    end
    return d[current].value + correction
end

end # module