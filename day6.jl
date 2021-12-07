example = "3,4,3,1,2"
fish = collect(parse(Int8, x.match) for x in eachmatch(r"\d+", example))

open("day6.txt", "r") do io
    global fish = collect(parse(Int, x.match) for x in eachmatch(r"\d+", readline(io)))
end

for day in 1:18
    fish .-= 1
    reset = fish .< 0
    global fish .+= 7 * reset
    append!(fish, 8 for i in 1:count(reset))
end
@show length(fish)

fish = collect(parse(Int8, x.match) for x in eachmatch(r"\d+", example))
open("day6.txt", "r") do io
    global fish = collect(parse(Int, x.match) for x in eachmatch(r"\d+", readline(io)))
end

counts = zeros(Int, 9)
for day in fish
    counts[day+1] += 1
end
for day in 1:256
    new = popfirst!(counts)
    push!(counts, new)
    counts[7] += new
end
@show counts, sum(counts)