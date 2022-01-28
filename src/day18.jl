module Day18

using AdventOfCode2017
using DataStructures

function day18(input::String = readInput(joinpath(@__DIR__, "..", "data", "day18.txt")))
    instructions = parse_input(input)
    p1 = run_part1(instructions)
    p2 = run_part2(instructions)
    return [p1, p2]
end

function parse_input(input)
    lines = split(rstrip(input), "\n")
    instructions = []
    for line ∈ lines
        elems = split(line)
        if elems[1] == "snd"
            push!(instructions, (snd, (elems[2][1], '0')))
        elseif elems[1] == "set"
            arg = tryparse(Int, elems[3])
            if arg === nothing
                push!(instructions, (set, (elems[2][1], elems[3][1])))
            else
                push!(instructions, (set, (elems[2][1], arg)))
            end
        elseif elems[1] == "add"
            arg = tryparse(Int, elems[3])
            if arg === nothing
                push!(instructions, (add, (elems[2][1], elems[3][1])))
            else
                push!(instructions, (add, (elems[2][1], arg)))
            end
        elseif elems[1] == "mul"
            arg = tryparse(Int, elems[3])
            if arg === nothing
                push!(instructions, (mul, (elems[2][1], elems[3][1])))
            else
                push!(instructions, (mul, (elems[2][1], arg)))
            end
        elseif elems[1] == "mod"
            arg = tryparse(Int, elems[3])
            if arg === nothing
                push!(instructions, (mod, (elems[2][1], elems[3][1])))
            else
                push!(instructions, (mod, (elems[2][1], arg)))
            end
        elseif elems[1] == "rcv"
            push!(instructions, (rcv, (elems[2][1], '0')))
        elseif elems[1] == "jgz"
            arg1 = tryparse(Int, elems[2])
            arg2 = tryparse(Int, elems[3])
            if arg1 === nothing
                arg1 = elems[2][1]
            end
            if arg2 === nothing
                arg2 = elems[3][1]
            end
            push!(instructions, (jgz, (arg1, arg2)))
        end
    end
    return instructions
end

function snd(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, ::Char)
    push!(lastsound, registers[x])
    return pc + 1
end

function set(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Int)
    registers[x] = y
    return pc + 1
end

function set(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Char)
    registers[x] = registers[y]
    return pc + 1
end

function add(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Int)
    registers[x] += y
    return pc + 1
end

function add(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Char)
    registers[x] += registers[y]
    return pc + 1
end

function mul(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Int)
    registers[x] *= y
    return pc + 1
end

function mul(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Char)
    registers[x] *= registers[y]
    return pc + 1
end

function mod(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Int)
    registers[x] %= y
    return pc + 1
end

function mod(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Char)
    registers[x] %= registers[y]
    return pc + 1
end

function rcv(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, ::Char)
    registers[x] != 0 && return -1
    return pc + 1
end

function jgz(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Int)
    registers[x] > 0 && return pc + y
    return pc + 1
end

function jgz(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Char, y::Char)
    registers[x] > 0 && return pc + registers[y]
    return pc + 1
end

function jgz(registers::DefaultDict{Char,Int}, lastsound::Vector{Int}, pc::Int, x::Int, y::Int)
    x > 0 && return pc + y
    return pc + 1
end

function run_part1(instructions)
    registers = DefaultDict{Char,Int}(0)
    lastsound = Vector{Int}()
    pc = 1
    while pc ∈ 1:length(instructions)
        pc = instructions[pc][1](registers, lastsound, pc, instructions[pc][2]...)
    end
    return lastsound[end]
end

function run_part2(instructions)
    p2 = 0
    registers = (DefaultDict{Char,Int}(0), DefaultDict{Char,Int}(0))
    registers[1]['p'] = 0
    registers[2]['p'] = 1
    lastsound = (Vector{Int}(), Vector{Int}())
    pc = [1, 1]
    while true
        for i ∈ 1:2
            while instructions[pc[i]][1] != rcv
                if i == 2 && instructions[pc[i]][1] == snd
                    p2 += 1
                end
                pc[i] = instructions[pc[i]][1](registers[i], lastsound[i], pc[i], instructions[pc[i]][2]...)
            end
        end
        if all(a -> isempty(a), lastsound)
            return p2
        end
        for (i, r) ∈ zip(1:2, 2:-1:1)
            if !isempty(lastsound[r])
                registers[i][instructions[pc[i]][2][1]] = popfirst!(lastsound[r])
                pc[i] += 1
            end
        end
    end
end

end # module