module Day16

using AdventOfCode2017

function day16(input::String = readInput(joinpath(@__DIR__, "..", "data", "day16.txt")))
    moves = generate_moves(input)
    a = collect(1:16)
    run!(a, moves)
    part1 = join(_to_char.(a))
    
    a = collect(1:16)
    order = 0
    while true
        run!(a, moves)
        order += 1
        a == 1:16 && break
    end
    nperm = mod(1_000_000_000, order)
    a = collect(1:16)
    for i = 1:nperm
        run!(a, moves)
    end
    part2 = join(_to_char.(a))
    return [part1, part2]
end

_to_int(c::Char) = Int(c) - 96
_to_char(i::Int) = Char(i + 96)

function generate_moves(input::String)
    moves = []
    for comm in split(rstrip(input), ",")
        if startswith(comm, "s")
            n = parse(Int, comm[2:end])
            push!(moves, (spin!, [n]))
        elseif startswith(comm, "x")
            i, j = parse.(Int, split(comm[2:end], "/"))
            push!(moves, (exchange!, [i, j]))
        elseif startswith(comm, "p")
            x, y = map(x -> x[1], split(comm[2:end], "/"))
            push!(moves, (partner!, [x, y]))
        end
    end
    return moves
end

function run!(state, moves)
    for move in moves
        move[1](state, move[2]...)
    end
end

function spin!(a::Vector{Int}, n::Int)
    l = length(a)
    for (i, el) in enumerate(vcat(a[l-n+1:l], a[1:l-n]))
        a[i] = el
    end
end

function exchange!(a::Vector{Int}, i::Int, j::Int)
    a[i+1], a[j+1] = a[j+1], a[i+1]
end

function partner!(a::Vector{Int}, x::Char, y::Char)
    n = _to_int(x)
    m = _to_int(y)
    i = findfirst(x->x==n, a)
    j = findfirst(x->x==m, a)
    a[i], a[j] = a[j], a[i]
end


end # module
