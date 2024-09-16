using CairoMakie
using MarketData

function get_prices(tags::Vector{String}, start_date::DateTime, end_date::DateTime, interval::String)
    prices::Dict{String, TimeArray} = Dict()

    for tag in tags
        time = YahooOpt(
            period1 = start_date,
            period2 = end_date,
            interval = interval,
            events = :history)

        prices[tag] = yahoo(tag, time)
    end

    return Prices(prices)
end




function plot(p::Prices)


end 


function plot(p::Portafolio)

end 