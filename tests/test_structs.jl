using Test

include("../src/structs.jl")

examples_1 = ["AMZN", "META"]
start_date = DateTime(2015, 9, 15)
end_date = DateTime(2020, 12, 31)
interval = "1d"

YahooOpt(start_date, end_date, interval, :history)

@testset "Tests of struct Portafolio" begin
    Portafolio(examples_1, 100_000, start_date, end_date, interval)  # Ejecuta la función
end

p = Portafolio(examples_1, 100_000, start_date, end_date, interval)