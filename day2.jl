using DelimitedFiles

steps = readdlm("day2.txt", ' ')

global horizontal = global depth = 0
for (direction, length) in eachrow(steps)
    if direction == "forward"
        global horizontal += length
    elseif direction == "down"
        global depth += length
    elseif direction == "up"
        global depth -= length
    end
end
@show horizontal, depth, horizontal*depth

global horizontal = global depth = global aim = 0
for (direction, length) in eachrow(steps)
    if direction == "forward"
        global horizontal += length
        global depth += aim * length
    elseif direction == "down"
        global aim += length
    elseif direction == "up"
        global aim -= length
    end
end
@show horizontal, depth, horizontal*depth