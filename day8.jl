example = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
cdfeb fcadb cdfeb cdbaf"

function parse_digits(line::String)
    digits = collect(String(sort(collect(String(x.match)))) for x in eachmatch(r"\w+", line))
    return digits[1:10], digits[11:end]
end

open("day8.txt") do io
    easy = 0
    while !eof(io)
        signals, output = parse_digits(readline(io))
        easy += count(x-> x < 5 || x > 6, map(length, output))
    end
    @show easy
end

function infer_digits(signals, output)
    decoded = collect("" for i in 1:10)
    for signal in signals
        if length(signal) == 2
            decoded[1] = signal
        elseif length(signal) == 3
            decoded[7] = signal
        elseif length(signal) == 4
            decoded[4] = signal
        elseif length(signal) == 7
            decoded[8] = signal        
        end
    end
    for signal in signals
        if length(signal) == 6
            if !issubset(decoded[7], signal)
                decoded[6] = signal
            elseif issubset(decoded[4], signal)
                 decoded[9] = signal
            else
                 decoded[10] = signal
            end
        end
    end
    for signal in signals
        if length(signal) == 5
            if issubset(decoded[1], signal)
                decoded[3] = signal
            elseif length(intersect(decoded[9], signal)) == 5
                decoded[5] = signal
            else
                decoded[2] = signal
            end
        end
    end
    return Dict(decoded[i] => i < 10 ? '0' + i : '0' for i = 1:10)
end

open("day8.txt") do io
    total = 0
    while !eof(io)
        signals, output = parse_digits(readline(io))
        signal_map = infer_digits(signals, output)
        total += parse(Int, String(collect(signal_map[x] for x in output)))
    end
    @show total
end