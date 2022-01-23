module Day21

using AdventOfCode2017

function day21(input::String = readInput(joinpath(@__DIR__, "..", "data", "day21.txt")))
    rules = parse_input(input)
    image = ['.' '#' '.'; '.' '.' '#'; '#' '#' '#']
    for _ = 1:5
        image = step(image, rules)
    end
    p1 = count(x -> x == '#', image)
    for _ = 6:18
        image = step(image, rules)
    end
    p2 = count(x -> x == '#', image)
    return [p1, p2]
end

function parse_input(input::String)
    d = Dict{Matrix{Char},Matrix{Char}}()
    for line ∈ split(rstrip(input), "\n")
        left, right = strip.(split(line, "=>"))
        leftm = map(x -> x[1], reduce(vcat, permutedims.(split.(split(replace(left, "/" => '\n')), ""))))
        rightm = map(x -> x[1], reduce(vcat, permutedims.(split.(split(replace(right, "/" => '\n')), ""))))
        d[leftm] = rightm
    end
    return d
end

function step(image, rules)
    if size(image, 1) % 2 == 0
        newsize = (size(image, 1) ÷ 2) * 3
        div = 2
        out = 3
    else
        newsize = (size(image, 1) ÷ 3) * 4
        div = 3
        out = 4
    end
    output = fill('.', (newsize, newsize))
    n = size(image,1) ÷ div
    for i ∈ 1:n
        for j ∈ 1:n
            key = image[(i-1)*div+1:i*div,(j-1)*div+1:j*div]
            for k ∈ combinations(key)
                if haskey(rules, k)
                    output[(i-1)*out+1:i*out, (j-1)*out+1:j*out] = rules[k]
                    break
                end
            end
        end
    end
    return output
end

flip1(m) = reverse(m, dims=1)
flip2(m) = reverse(m, dims=2)

function combinations(m)
    # there are only 8 unique elements, not 12...
    return (a(b(m)) for a ∈ (identity, rotl90, rot180, rotr90) for b ∈ (identity, flip1, flip2))
end

end # module