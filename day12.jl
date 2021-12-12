using DelimitedFiles

function parse_graph(filename)
    graph = Dict{String, Array{String}}()
    for (a, b) in eachrow(readdlm(filename, '-'))
        if !haskey(graph, a) graph[a] = Array{String}(undef, 0) end
        if !haskey(graph, b) graph[b] = Array{String}(undef, 0) end
        if !in(b, graph[a]) push!(graph[a], b) end
        if !in(a, graph[b]) push!(graph[b], a) end
    end
    return graph
end

function can_visit(neighbor::String, path::Array{String}, twice::Bool)
    in_path = in(neighbor, path)
    if !twice || !in_path
        return !in_path
    elseif neighbor == "start" || neighbor == "end"
        return false
    else
        for lower in filter(x->all(islowercase.(collect(x))), path[2:end])
            if count(x-> x==lower, path) > 1
                return false
            end
        end
        return true
    end
end

function find_route!(graph::Dict{String, Array{String}}, routes::Array{Array{String}}, path::Array{String}, twice::Bool)
    for neighbor in graph[path[end]]
        if neighbor == "end" && !in(vcat(path, [neighbor]), routes)
            push!(routes, vcat(path, [neighbor]))
        elseif all(isuppercase.(collect(neighbor))) || can_visit(neighbor, path, twice)
            find_route!(graph, routes, vcat(path, [neighbor]), twice)
        end
    end
    return routes
end

function find_route!(graph::Dict{String, Array{String}}, twice::Bool=false)
    return find_route!(graph, Array{Array{String}}(undef, 0), ["start"], twice)
end

in_routes = expected -> in(filter(x -> x != "", expected), routes)

routes = find_route!(parse_graph("day12example1.txt"))
@assert length(routes) == 10
@assert eachrow(readdlm("day12expected1.txt", ',')) .|> in_routes |> x -> x == ones(Bool, length(routes))

routes = find_route!(parse_graph("day12example2.txt"))
@assert length(routes) == 19
@assert eachrow(readdlm("day12expected2.txt", ',')) .|> in_routes |> x -> x == ones(Bool, length(routes))

@assert length(find_route!(parse_graph("day12example3.txt"))) == 226

@show length(find_route!(parse_graph("day12.txt")))

@assert length(find_route!(parse_graph("day12example1.txt"), true)) == 36
@assert length(find_route!(parse_graph("day12example2.txt"), true)) == 103
@assert length(find_route!(parse_graph("day12example3.txt"), true)) == 3509
@show length(find_route!(parse_graph("day12.txt"), true))