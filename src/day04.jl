module Day04

using AdventOfCode2017

function day04(input::String = readInput(joinpath(@__DIR__, "..", "data", "day04.txt")))
    lines = split(rstrip(input), "\n")
    return [part1(lines), part2(lines)]
end

function part1(lines)
    count(length(x) == length(unique(x)) for x in split.(lines))
end

function part2(lines)
    nvalid = 0
    for line in lines
        valid = true
        sline = split(line)
        for i = 1:length(sline)
            chars1 = collect.(sline[i])
            for j = i+1:length(sline)
                chars2 = collect.(sline[j])
                length(chars1) != length(chars2) && continue
                if sort(chars1) == sort(chars2)
                    valid = false
                    @goto exit
                end
            end
        end
        @label exit
        nvalid += valid
    end
    return nvalid
end

end # module