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

@testset "Day 14" begin
    @test AdventOfCode2017.Day14.day14() == [8214, 1093]
end

@testset "Day 15" begin
    @test AdventOfCode2017.Day15.day15() == [650, 336]
end

@testset "Day 16" begin
    @test AdventOfCode2017.Day16.day16() == ["ceijbfoamgkdnlph", "pnhajoekigcbflmd"]
end

@testset "Day 17" begin
    @test AdventOfCode2017.Day17.day17("3\n") == [638, 1222153]
    @test AdventOfCode2017.Day17.day17() == [1914, 41797835]
end

@testset "Day 18" begin
    sample = "set a 1\n" *
             "add a 2\n" *
             "mul a a\n" *
             "mod a 5\n" *
             "snd a\n" *
             "set a 0\n" *
             "rcv a\n" *
             "jgz a -1\n" *
             "set a 1\n" *
             "jgz a -2\n"
    sample2 = "snd 1\n" *
              "snd 2\n" *
              "snd p\n" *
              "rcv a\n" *
              "rcv b\n" *
              "rcv c\n" *
              "rcv d\n"
end

@testset "Day 19" begin
    @test AdventOfCode2017.Day19.day19() == ["EOCZQMURF", 16312]
end

@testset "Day 20" begin
    @test AdventOfCode2017.Day20.day20() == [300, 502]
end

@testset "Day 21" begin
    sample = "../.# => ##./#../...\n" *
             ".#./..#/### => #..#/..../..../#..#\n"
    @test AdventOfCode2017.Day21.day21() == [188, 2758764]
end

@testset "Day 22" begin
    @test AdventOfCode2017.Day22.day22() == [5433, 2512599]
end

@testset "Day 23" begin
    @test AdventOfCode2017.Day23.day23() == [4225, 905]
end

@testset "Day 24" begin
    sample = "0/2\n" *
             "2/2\n" *
             "2/3\n" *
             "3/4\n" *
             "3/5\n" *
             "0/1\n" *
             "10/1\n" *
             "9/10\n"
    @test AdventOfCode2017.Day24.day24(sample) == [31, 19]
    @test AdventOfCode2017.Day24.day24() == [2006, 1994]
end