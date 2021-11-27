using AdventOfCode2017
using Test

@testset "Day 1" begin
    @test AdventOfCode2017.Day01.day01() == [1182, 1152]
end

@testset "Day 2" begin
    @test AdventOfCode2017.Day02.day02() == [32121, 197]
end

@testset "Day 3" begin
    @test AdventOfCode2017.Day03.part1(12) == 3
    @test AdventOfCode2017.Day03.part1(23) == 2
    @test AdventOfCode2017.Day03.part1(1024) == 31

    @test AdventOfCode2017.Day03.day03() == [430, 312453]
end

@testset "Day 4" begin
    @test AdventOfCode2017.Day04.day04() == [325, 119]
end

@testset "Day 5" begin
    @test AdventOfCode2017.Day05.day05() == [387096, 28040648]
end

@testset "Day 6" begin
    @test AdventOfCode2017.Day06.day06() == [4074, 2793]
end

@testset "Day 7" begin
    @test AdventOfCode2017.Day07.day07() == ["cqmvs", 2310]
end

@testset "Day 8" begin
    @test AdventOfCode2017.Day08.day08() == [7296, 8186]
end

@testset "Day 9" begin
    @test AdventOfCode2017.Day09.day09() == [11347, 5404]
end

@testset "Day 10" begin
    @test AdventOfCode2017.Day10.day10() == [20056, "d9a7de4a809c56bf3a9465cb84392c8e"]
end

@testset "Day 11" begin
    @test AdventOfCode2017.Day11.day11() == [834, 1569]
end

@testset "Day 12" begin
    @test AdventOfCode2017.Day12.day12() == [288, 211]
end

@testset "Day 13" begin
    @test AdventOfCode2017.Day13.day13() == [1728, 3946838]
end