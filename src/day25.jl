module Day25

using AdventOfCode2017
using DataStructures

function day25(input::String = readInput(joinpath(@__DIR__, "..", "data", "day25.txt")))
    initial_state, nsteps, instructions = parse_input(input)
    return solve(initial_state, nsteps, instructions)
end

function parse_input(input::String)
    sinput = split(rstrip(input), "\n")
    m = match(r"state\s+(.+)\.", sinput[1])
    initial_state = m.captures[1][1]
    m = match(r"(\d+)", sinput[2])
    nsteps = parse(Int, m.captures[1])
    starts = findall(x -> startswith(x, "In state"), sinput)
    d = Dict{Char,Dict{Int,Tuple{Int,Int,Char}}}()
    for i ∈ starts
        m = match(r"state\s+(.+):", sinput[i])
        state = m.captures[1][1]
        i += 2
        m = match(r"value\s+(\d+)", sinput[i])
        val0 = parse(Int, m.captures[1])
        i += 1
        m = match(r"to\s+the\s+(.+)\.", sinput[i])
        dir0 = m.captures[1] == "right" ? 1 : -1
        i += 1
        m = match(r"state\s+(.+)\.", sinput[i])
        state0 = m.captures[1][1]
        i += 2
        m = match(r"value\s+(\d+)", sinput[i])
        val1 = parse(Int, m.captures[1])
        i += 1
        m = match(r"to\s+the\s+(.+)\.", sinput[i])
        dir1 = m.captures[1] == "right" ? 1 : -1
        i += 1
        m = match(r"state\s+(.+)\.", sinput[i])
        state1 = m.captures[1][1]
        dzo = Dict{Int,Tuple{Int,Int,Char}}()
        dzo[0] = (val0, dir0, state0)
        dzo[1] = (val1, dir1, state1)
        d[state] = dzo
    end
    return initial_state, nsteps, d
end

function solve(initial_state, nsteps, instructions)
    d = DefaultDict{Int,Int}(0)
    i = 0
    current = initial_state
    for _ ∈ 1:nsteps
        if d[i] == 0
            d[i] = instructions[current][0][1]
            i += instructions[current][0][2]
            current = instructions[current][0][3]
        elseif d[i] == 1
            d[i] = instructions[current][1][1]
            i += instructions[current][1][2]
            current = instructions[current][1][3]
        end
    end
    return values(d) |> sum
end

end # module