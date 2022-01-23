module Day20

using AdventOfCode2017
using StaticArrays

function day20(input::String = readInput(joinpath(@__DIR__, "..", "data", "day20.txt")))
    p, v, a = parse_input(input)
    # return input
    p1 = part1(p, v, a)
    p2 = part2(p, v, a)
    return [p1, p2]
end

function parse_input(input::String)
    p = Vector{SVector{3,Int}}()
    v = Vector{SVector{3,Int}}()
    a = Vector{SVector{3,Int}}()
    r = r"p\s*=\s*<(-?\d+),(-?\d+),(-?\d+)>\s*,\s*v\s*=\s*<(-?\d+),(-?\d+),(-?\d+)>\s*,\s*a\s*=\s*<(-?\d+),(-?\d+),(-?\d+)>"
    for line ∈ split(rstrip(input), "\n")
        m = match(r, line)
        numbers = parse.(Int, m.captures)
        push!(p, numbers[1:3])
        push!(v, numbers[4:6])
        push!(a, numbers[7:9])
    end
    return p, v, a

end

function part1(p, v, a::Vector{SVector{3,Int}})
    adist = map(x -> abs.(x) |> sum, a)
    amindist = findmin(adist)[1]
    aminind = findall(x -> x == amindist, adist)
    v = v[aminind]
    p = p[aminind]
    inds = collect(0:length(a)-1)[aminind]
    vdist = map(x -> abs.(x) |> sum, v)
    vmindist = findmin(vdist)[1]
    vminind = findall(x -> x == vmindist, vdist)
    p = p[vminind]
    inds = inds[vminind]
    pdist = map(x -> abs.(x) |> sum, p)
    pmindist = findmin(pdist)[1]
    pminind = findfirst(x -> x == pmindist, pdist)
    return inds[pminind]
end

function part2(p, v, a)
    maxtime = estimate_time(p, v, a)
    uniqueinds = uniqueidx(p)
    p = @view p[uniqueinds]
    v = @view v[uniqueinds]
    a = @view a[uniqueinds]
    n = 1
    while n <= maxtime
        nv = v + a
        np = p + nv
        uniqueinds = uniqueidx(np)
        p = @view np[uniqueinds]
        v = @view nv[uniqueinds]
        a = @view a[uniqueinds]
        if n % 40 == 0
            maxtime = estimate_time(p, v, a)
        end
        n += 1
    end
    return length(p)
end

function uniqueidx(v)
    duplidx = Set{Int}()
    for i = 1:length(v)
        for j = i+1:length(v)
            if v[i] == v[j]
                push!(duplidx, i, j)
            end
        end
    end
    return [i for i ∈ 1:length(v) if i ∉ duplidx]
end

# function estimate_time(p::Vector{SVector{3,Int}}, vel::Vector{SVector{3,Int}}, acc::Vector{SVector{3,Int}})
function estimate_time(p, vel, acc)
    # This is a very bad estimate...
    maxtime = 0
    for i = 1:length(p)
        for j = 1:length(p)
            i == j && continue
            dp = p[i] - p[j]
            dv = vel[i] - vel[j]
            da = acc[i] - acc[j]
            a = da / 2
            b = dv + a
            c = dp
            for k = 1:3
                if a[k] == 0
                    b[k] == 0 && continue
                    n = ceil(Int, -c[k]/b[k])
                    if n > maxtime
                        maxtime = n
                    end
                    continue
                end
                D = b[k]^2 - 4*a[k]*c[k]
                if D >= 0
                    n = ceil(Int, (-b[k] + sqrt(D))/(2*a[k]))
                    if n > maxtime
                        maxtime = n
                    end
                end
            end
        end
    end
    return maxtime
end


end # module