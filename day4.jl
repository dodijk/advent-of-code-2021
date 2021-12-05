mutable struct Board
    numbers::Array{Int}
    unmarked::Array{Bool}
    is_completed::Bool

    function Board(numbers::Array{Int})
        new(numbers, ones(size(numbers)), false)
    end
end

function load_boards()
    boards = Vector{Board}()
    order = Vector{Int64}()
    open("day4.txt", "r") do io
        append!(order, collect(parse(Int, x.match) for x in eachmatch(r"\d+", readline(io)))) 
        @assert readline(io) == ""
        while !eof(io)
            board = Array{Int}(undef, (5, 5))
            for i in 1:5
                board[i*5-4:i*5] = collect(parse(Int, x.match) for x in eachmatch(r"\d+", readline(io)))
            end
            append!(boards, [Board(board)])
            @assert readline(io) == ""
        end
    end
    return order, boards
end

function mark!(board::Board, number::Int)
    board.unmarked .= (board.numbers .!= number) .* board.unmarked
end

function is_complete(board::Board)
    return any(sum(eachrow(board.unmarked)) .== 0) || any(sum(eachcol(board.unmarked)) .== 0)
end

function play(order, boards)
    for drawn in order
        for (index, board) in enumerate(boards)
            mark!(board, drawn)
            if is_complete(board)
                return sum(board.numbers .* board.unmarked) * drawn
            end
        end
    end
end
order, boards = load_boards()
@show play(order, boards)

function play2(order, boards)
    global winner = undef
    for drawn in order
        for (index, board) in enumerate(boards)
            if board.is_completed continue end
            mark!(board, drawn)
            if is_complete(board)
                winner = sum(board.numbers .* board.unmarked) * drawn
                boards[index].is_completed = true
            end
        end
    end
    return winner
end
order, boards = load_boards()
@show play2(order, boards)