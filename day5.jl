using DelimitedFiles

grid = zeros(Int, 1000, 1000)
open("day5.txt", "r") do io
    min_x = min_y = 500
    max_x = max_y = 0
    while !eof(io)
        (x1, y1, x2, y2) = collect(parse(Int, x.match) for x in eachmatch(r"\d+", readline(io)))
        min_x = min(min_x, x1, x2)
        min_y = min(min_y, y1, y2)
        max_x = max(max_x, x1, x2)
        max_y = max(max_y, y1, y2)

        if x1 == x2 || y1 == y2
            for x in min(x1, x2):max(x1, x2)
                for y in min(y1, y2):max(y1, y2)
                    grid[x, y] += 1
                end
            end
        end
    end
    @show min_x, min_y, max_x, max_y
    @show count(x->x>1, grid)
end

grid = zeros(Int, 1000, 1000)
open("day5.txt", "r") do io
    while !eof(io)
        (x1, y1, x2, y2) = collect(parse(Int, x.match) for x in eachmatch(r"\d+", readline(io)))

        x = x1
        y = y1
        while x != x2 || y != y2
            grid[x, y] += 1
            if x1 != x2
                x += x1 < x2 ? 1 : -1
            end
            if y1 != y2
                y += y1 < y2 ? 1 : -1
            end
        end
        grid[x, y] += 1
    end
    @show count(x->x>1, grid)
end
