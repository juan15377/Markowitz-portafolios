using DataFrames
using Match
using MarketData

mutable struct Prices 
    prices::Dict{String, TimeArray}
end 

# add methods getindex and setindex! for Neighborhood
function Base.getindex(p::Prices, key::String)
    return p.prices[key]
end

function Base.keys(p::Prices)
    return keys(p.prices)
end 

mutable struct Portafolio
    prices::Prices
    capital::Number
    date_start::Date 
    date_end::Date
    period::YahooOpt
    weights::Vector{Float64}

    function Portafolio(tags::Vector{String, Symbol}, prices::Prices, capital::Number, date_start::Date, date_end::Date, period::Period)

    end

end 

