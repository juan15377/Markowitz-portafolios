using CairoMakie
using MarketData
using Dates
using Match
using XLSX


function get_returns(prices::Prices, type = "Normal")
    f_ret = @match type begin
        "Normal" || :Normal   => (p1, p2) -> (p2 - p1)/p1 
        "Log" || :Log   => (p1, p2) -> log(p2/p1) 
    end

    r::Dict{Union{String, Symbol}, Vector{Float64}} = Dict()
    for tag ∈ keys(prices)
        prices_tag = DataFrame(prices[tag]).AdjClose
        l = length(prices_tag)
        r[tag] = map((p1_indx, p2_indx) -> f_ret(prices_tag[p1_indx], prices_tag[p2_indx]), 1:(l-1), 2:l )
    end
    return r
end 

function plot(p::Prices)
    points = []
    for tag in tags(p)
        adjclose = collect(p[tag].AdjClose) |> x -> map(y-> y[2], x)
        time = 1:length(adjclose)
        points_tag = Point2f.(time, adjclose)
        push!(points, points_tag)
    end 
    return series(points)
end 


function save_prices(prices::Prices, path::AbstractString)
    num_sheet = 1
    XLSX.openxlsx(path, mode="w") do xf

        for tag in keys(prices)
            sheet = XLSX.addsheet!(xf, tag)
            prices_df = DataFrame(prices[tag])
            sheet["A1"] = "Date"
            sheet["B1"] = "Open"
            sheet["C1"] = "High"
            sheet["D1"] = "Low"
            sheet["E1"] = "Close"
            sheet["F1"] = "AdjClose"
            sheet["G1"] = "Volume"
            sheet["A2"] = Matrix(prices_df)
            num_sheet += 1
        end 
    end
end 


tickers = ["AAPL", "MSFT", "AMZN", "GOOGL", "TSLA", "JNJ"]
examples_1 = ["AMZN", "META"]
start_date = DateTime(2019, 9, 30)
end_date = DateTime(2024, 9, 30)
interval = "1d"


prices = get_prices(tickers, start_date, end_date, interval)  # Ejecuta la función

save_prices(prices, "precios_empresas.xlsx")


function plot(portafolio::Portafolio)
    if ! portafolio.is_optim 
        error("portafolio is not optimized")
    end 

end 


