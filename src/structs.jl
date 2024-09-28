using DataFrames
using Match
using MarketData

mutable struct Prices 
    prices::Dict{String, TimeArray}

end 

function Base.getindex(p::Prices, key::String)
    return p.prices[key]
end

function Base.keys(p::Prices)
    return keys(p.prices)
end 


function get_prices(tags::Vector{String}, start_date::T, end_date::T, interval::String) where {T <: Dates.DateTime}
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

get_prices(tickets::Vector{String}, time::YahooOpt) = get_prices(tickets, time.period1, time.period2, time.interval)

mutable struct Portafolio
    prices::Prices
    capital::Number
    period::YahooOpt
    weights::Vector{Float64}
    is_optim::Bool

    function Portafolio(tickets::Vector{String}, capital::Number, time::YahooOpt)
        prices = get_prices(tickets, time)
        weights = ones(length(tickets)) / length(tickets)

        new(prices, capital, start_date, end_date, period, weights, false)
    end


    function Portafolio(tickets::Vector{String}, capital::Number, start_date::DateTime, end_date::DateTime, period::String)
        prices = get_prices(tickets, start_date, end_date, period)
        weights = ones(length(tickets)) ./ length(tickets)

        time = YahooOpt(
                period1 = start_date,
                period2 = end_date,
                interval = period,
                events = :history)
            
        new(prices, capital, time, weights, false)
    end 

end 

