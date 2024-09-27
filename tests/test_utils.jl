include("../src/Utils.jl")
using Test

## get_prices 
# Importar el módulo `Test`
using Test
using Dates

# Definir las pruebas
examples_1 = ["AMZN", "META"]
start_date = DateTime(2015, 9, 15)
end_date = DateTime(2020, 12, 31)
interval = "1d"

prices = get_prices(examples_1, start_date, end_date, interval)  # Ejecuta la función


@testset "Tests of function get_prices" begin
    prices = get_prices(examples_1, start_date, end_date, interval)  # Ejecuta la función
    @test !isempty(keys(prices)) # Verifica que prices no esté vacío
    @test length(keys(prices)) == length(examples_1)  # Verifica que devuelva datos para todas las acciones solicitadas
end

@testset "Tests of function return" begin

    prices = get_prices(examples_1, start_date, end_date, interval)  # Ejecuta la función
    returns = returns_prices(prices)

    @test !isempty(keys(prices)) # Verifica que prices no esté vacío
    @test length(keys(prices)) == length(examples_1)  # Verifica que devuelva datos para todas las acciones solicitadas
end

