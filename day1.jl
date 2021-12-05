using DelimitedFiles

depths = readdlm("day1.txt", ' ', Int)

diff = depths[2:end] - depths[1:end-1]
@show sum(diff .> 0)

sums = depths[1:end-2] + depths[2:end-1] + depths[3:end]
@show sum((sums[2:end] - sums[1:end-1]) .> 0)