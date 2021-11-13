module Day02

using AdventOfCode2017

function day02(input::String = readInput(joinpath(@__DIR__, "..", "data", "day02.txt")))
    rows = [parse.(Int, x) for x in split.(split(rstrip(input), "\n"), "\t")]
    return [part1(rows), part2(rows)]
end

function part1(rows)
    checksum = 0
    for row in rows
        checksum += maximum(row) - minimum(row)
    end
    return checksum
end

function part2(rows)
    checksum = 0
    for row in rows
        for i = 1:length(row)
            for j = i+1:length(row)
                if mod(row[i], row[j]) == 0
                    checksum += row[i] ÷ row[j]
                    @goto next_row
                end
                if mod(row[j], row[i]) == 0
                    checksum += row[j] ÷ row[i]
                    @goto next_row
                end
            end
        end
        @label next_row
    end
    return checksum
end

end # module