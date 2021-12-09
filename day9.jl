matrix = zeros(Int8, 100, 100)

open("day9.txt") do io
    i = 0
    while !eof(io)
        i += 1
        matrix[i, 1:length(matrix[1,:])] = map(x -> parse(Int8, x), collect(readline(io)))
    end
    @show matrix
end

bassin = zeros(Int8, length(matrix[:, 1]), length(matrix[1,:]))

function expand_bassin!(matrix::Matrix{Int8}, i::Int, j::Int, visited::Vector{Tuple{Int8, Int8}})
    for (x, y) in ((i-1, j), (i+1, j), (i, j-1), (i, j+1))
        if (x, y) in visited || x < 1 || y < 1 || x > length(matrix[:, 1]) || y > length(matrix[1,:])
            continue
        end
        if matrix[x,y] < 9
            push!(visited, (x,y))
            expand_bassin!(matrix, x, y, visited)
        end
    end
    return visited
end

function expand_bassin!(matrix::Matrix{Int8}, i::Int, j::Int)
    expand_bassin!(matrix, i, j, Tuple{Int8, Int8}[])
end
function compute_size(matrix::Matrix{Int8}, i::Int, j::Int)
    length(expand_bassin!(matrix, i, j))
end

lowpoint = zeros(Bool, length(matrix[:, 1]), length(matrix[1,:]))
for i in 1:length(matrix[:, 1])
    for j in 1:length(matrix[1,:])
        if j > 1 && matrix[i,j] >= matrix[i,j-1] continue end
        if j < length(matrix[1,:]) && matrix[i,j] >= matrix[i,j+1] continue end
        if i > 1 && matrix[i,j] >= matrix[i-1,j] continue end
        if i < length(matrix[:, 1]) && matrix[i,j] >= matrix[i+1,j] continue end
        lowpoint[i, j] = true

        bassin[i, j] = compute_size(matrix, i, j)
    end
end
@show sum(lowpoint .* matrix .+ lowpoint .* 1)

largest = sort(bassin[:])[end-2:end]
@show Int64(largest[1]) * largest[2] * largest[3]
