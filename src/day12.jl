module Day12

using AdventOfCode2017

function day12(input::String = readInput(joinpath(@__DIR__, "..", "data", "day12.txt")))
    groups = generate_groups(input)
    group0 = get_set(groups, 0, Int[])
    return [length(group0), length(groups)]
end

function generate_groups(input::String)
    lines = split(rstrip(input), "\n")
    sets = Vector{Set{Int}}()
    for line in lines
        left, right = strip.(split(line, "<->"))
        lefti = parse(Int, left)
        righti = parse.(Int, split(right, ","))
        set = get_set(sets, lefti, righti)
        if set === nothing
            push!(sets, Set{Int}([lefti, righti...]))
        else
            push!(set, lefti)
            for r in righti
                push!(set, r)
            end
        end
    end

    # Merge the groups as long as necessary:
    changed = true
    merged_groups = Vector{Set{Int}}()
    while changed
        changed = false
        merged_groups = Vector{Set{Int}}()
        for group in sets
            merged = false
            for mg in merged_groups
                if any(x -> x ∈ mg, group)
                    push!(mg, group...)
                    merged = true
                    changed = true
                    break                
                end
            end
            if !merged
                push!(merged_groups, group)
            end
        end
        sets = merged_groups
    end
    return merged_groups
end

function get_set(sets::Vector{Set{Int}}, left::Int, right::Vector{Int})
    for set in sets
        left ∈ set && return set
        for r in right
            r ∈ set && return set
        end
    end
end

end # module