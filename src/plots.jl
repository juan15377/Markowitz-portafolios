using CairoMakie
using GLMakie

function plot(portafolio::Portafolio)
    if !portafolio.is_optim
        error("portafolio is not optimized")
    end

end

function plot(p::Prices)
    fig = Figure(; size=(1000, 600))
    ax = Axis(fig[1, 1], ylabel = "Price", xlabel = "Time")
    for tag in keys(p)
        adjclose = collect(p[tag].AdjClose) |> x -> map(y -> y[2], x)
        time = 1:length(adjclose)
        lines!(ax, time, adjclose, label = tag)
    end
    fig[1,2] = axislegend(ax; titlecolor=:white, 
                            framecolor=:grey, 
                            polystrokewidth=5, 
                            polystrokecolor=(:white, 2), 
                            rowgap=10,  
                            labelcolor=:black)

    return fig
end
