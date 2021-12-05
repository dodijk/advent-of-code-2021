using DelimitedFiles

diagnostics = readdlm("day3.txt", String)

gamma = epsilon = ""
for i in 1:length(diagnostics[1])
    count_1s = count(x->x[i] == '1', diagnostics)
    count_0s = length(diagnostics) - count_1s
    global gamma = gamma * (count_1s >= count_0s ? '1' : '0')
    global epsilon = epsilon * (count_1s < count_0s ? '1' : '0')
end 
@show parse(Int, gamma, base=2), parse(Int, epsilon, base=2)
@show parse(Int, gamma, base=2) * parse(Int, epsilon, base=2)

while length(diagnostics) > 1
    for i in 1:length(diagnostics[1])
        count_1s = count(x->x[i] == '1', diagnostics)
        count_0s = length(diagnostics) - count_1s
        keep = count_1s >= count_0s ? '1' : '0'
        global diagnostics = filter(x->(x[i] == keep), diagnostics)
    end 
    break
end
@assert length(diagnostics) == 1
@show oxygen = parse(Int, diagnostics[1], base=2)

diagnostics = readdlm("day3.txt", String)
while length(diagnostics) > 1
    for i in 1:length(diagnostics[1])
        count_1s = count(x->x[i] == '1', diagnostics)
        count_0s = length(diagnostics) - count_1s
        keep = count_1s < count_0s ? '1' : '0'
        global diagnostics = filter(x->(x[i] == keep), diagnostics)
        if length(diagnostics) == 1 break end
    end 
end
@assert length(diagnostics) == 1
@show scrubber = parse(Int, diagnostics[1], base=2)
@show oxygen * scrubber 
