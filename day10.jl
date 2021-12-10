char_map = Dict('['=>']', '{'=>'}', '('=>')', '<'=>'>')
penalties = Dict(')'=>3, ']'=>57, '}'=>1197, '>'=>25137)
complete = Dict(')'=>1, ']'=>2, '}'=>3, '>'=>4)

open("day10.txt") do io
    penalty = 0
    scores = []
    while !eof(io)
        stack = []
        for c in readline(io)
            if c in keys(char_map) 
                push!(stack, c)
            elseif c in values(char_map)
                expected = char_map[pop!(stack)]
                if c != expected
                    @show expected, c
                    penalty += penalties[c]
                    stack = [] # Do not complete this line
                    break
                end
            end
        end
        if length(stack) > 0
            push!(scores, 0)
            for c in reverse(stack)
                scores[end] *= 5
                scores[end] += complete[char_map[c]]
            end
        end
    end
    @show penalty
    @show sort(scores)[Int(ceil(length(scores)/2))]
end