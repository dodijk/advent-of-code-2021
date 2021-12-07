example = "16,1,2,0,4,2,7,1,2,14"

crabs = collect(parse(Int8, x.match) for x in eachmatch(r"\d+", example))

open("day7.txt") do io
    global crabs = collect(parse(Int, x.match) for x in eachmatch(r"\d+", readline(io)))
end

best = 0, -1
for i in minimum(crabs):maximum(crabs)
     steps = sum(map(abs, crabs .- i))
     if best[2] < 0 || steps < best[2]
        global best = i, steps
     end
end
@show best

# Part 2

open("day7.txt") do io
    global crabs = collect(parse(Int, x.match) for x in eachmatch(r"\d+", readline(io)))
end

function distance(d, i)
    sum(1:abs(d - i))
end

best = 0, -1
for i in minimum(crabs):maximum(crabs)
     steps = sum(distance.(crabs, i))
     if best[2] < 0 || steps < best[2]
        global best = i, steps
     end
end
@show best