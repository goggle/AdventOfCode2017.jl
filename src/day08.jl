module Day08

using AdventOfCode2017

struct Instruction
    reg::String
    command
    val::Int
    condreg::String
    comp
    compval::Int
end

function day08(input::String = readInput(joinpath(@__DIR__, "..", "data", "day08.txt")))
    registers, instructions = parse_input(input)
    return solve(registers, instructions)
end

function parse_input(input::String)
    lines = split(rstrip(input), "\n")
    instructions = Vector{Instruction}(undef, length(lines))
    registers = Dict{String,Int}()
    for (i, line) in enumerate(lines)
        sp = split(line)
        reg = sp[1]
        registers[reg] = 0
        if sp[2] == "inc"
            command = inc!
        else
            command = dec!
        end
        val = parse(Int, sp[3])
        condreg = sp[5]
        registers[condreg] = 0
        if sp[6] == "=="
            comp = ==
        elseif sp[6] == "!="
            comp = !=
        elseif sp[6] == "<"
            comp = <
        elseif sp[6] == "<="
            comp = <=
        elseif sp[6] == ">"
            comp = >
        elseif sp[6] == ">="
            comp = >=
        end
        compval = parse(Int, sp[7])
        instructions[i] = Instruction(reg, command, val, condreg, comp, compval) 
    end
    return registers, instructions
end

function solve(registers, instructions)
    part2 = 0
    for instr in instructions
        if instr.comp(registers[instr.condreg], instr.compval)
            instr.command(registers, instr.reg, instr.val)
        end
        if registers[instr.reg] > part2
            part2 = registers[instr.reg]
        end
    end
    part1 = maximum(values(registers))
    return [part1, part2]
end

function inc!(registers::Dict{String,Int}, reg::String, val::Int)
    registers[reg] += val
end

function dec!(registers::Dict{String,Int}, reg::String, val::Int)
    registers[reg] -= val
end

end # module