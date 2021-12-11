rows = cols = 10
matrix = zeros(Int8, rows, cols)

open("day11.txt") do io
    for (i, line) in enumerate(readlines(io))
        matrix[i, 1:cols] = map(x -> parse(Int8, x), collect(line))
    end
    @show matrix
end

flashed = 0
step = 0
while true
    global step += 1
    matrix .+= 1
    previous = -1
    previous_step = flashed
    while flashed > previous
        previous = flashed
        for (row, octos) in enumerate(eachrow(matrix))
            for (col, octo) in enumerate(octos)
                if octo > 9
                    global flashed += 1
                    matrix[row,col] = 0
                    for i in max(1, row-1):min(row+1, rows) 
                        for j in max(1, col-1):min(col+1, cols)
                            if matrix[i,j] > 0
                                matrix[i,j] += 1
                            end
                        end
                    end
                    break
                end
            end
        end
    end
    if step == 100
        @show step, flashed
    end
    if (flashed - previous_step) == rows*cols
        @show step, flashed
        break
    end
end
