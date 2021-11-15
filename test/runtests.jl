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