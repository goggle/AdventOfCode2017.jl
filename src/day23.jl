module Day23

using AdventOfCode2017
using Primes

function day23(input::String = readInput(joinpath(@__DIR__, "..", "data", "day23.txt")))
    instructions = parse_input(input)
    p1 = part1(instructions)
    return [p1, part2()]
end

function parse_input(input::String)
    instructions = []
    for line in split(rstrip(input), "\n")
        instr, a, b = split(line, " ")
        aa = tryparse(Int, a)
        if aa !== nothing
            a = aa
        else
            a = a[1]
        end
        bb = tryparse(Int, b)
        if bb !== nothing
            b = bb
        else
            b = b[1]
        end
        if instr == "set"
            push!(instructions, (set, (a, b)))
        elseif instr == "sub"
            push!(instructions, (sub, (a, b)))
        elseif instr == "mul"
            push!(instructions, (mul, (a, b)))
        elseif instr == "jnz"
            push!(instructions, (jnz, (a, b)))
        end
    end
    return instructions
end

function set(registers::Dict{Char,Int}, pc::Int, x::Char, y::Int)
    registers[x] = y
    return pc + 1
end

function set(registers::Dict{Char,Int}, pc::Int, x::Char, y::Char)
    registers[x] = registers[y]
    return pc + 1
end

function sub(registers::Dict{Char,Int}, pc::Int, x::Char, y::Int)
    registers[x] -= y
    return pc + 1
end

function sub(registers::Dict{Char,Int}, pc::Int, x::Char, y::Char)
    registers[x] -= registers[y]
    return pc + 1
end

function mul(registers::Dict{Char,Int}, pc::Int, x::Char, y::Int)
    registers[x] *= y
    return pc + 1
end

function mul(registers::Dict{Char,Int}, pc::Int, x::Char, y::Char)
    registers[x] *= registers[y]
    return pc + 1
end

function jnz(registers::Dict{Char,Int}, pc::Int, x::Char, y::Int)
    registers[x] != 0 && return pc + y
    return pc + 1
end

function jnz(registers::Dict{Char,Int}, pc::Int, x::Int, y::Int)
    x != 0 && return pc + y
    return pc + 1
end

function part1(instructions)
    p1 = 0
    len = length(instructions)
    pc = 1
    registers = Dict{Char,Int}()
    for c ∈ ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h')
        registers[c] = 0
    end
    while pc ∈ 1:len
        if instructions[pc][1] == mul
            p1 += 1
        end
        pc = instructions[pc][1](registers, pc, instructions[pc][2]...)
    end
    return p1
end

function part2()
    # Note: Since this is a reverse-engeneering puzzle,
    # you need to analyze the code from the input file,
    # so this solution only works for my specific input!
    nonprimes = 0
    b = 106700
    c = 123700
    while true
        if !isprime(b)
            nonprimes += 1
        end
        b == c && break
        b += 17
    end
    return nonprimes
end


end # module
