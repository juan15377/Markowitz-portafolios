include("structs.jl")
using JuMP


function optim!(portafolio::Portafolio, f = "min_risk")
    # se define el modelo
    model = Model(optimizer_with_attributes(Ipopt.Optimizer, "print_level" => 0))
    num_ = length(keys(rendimientos))

    @variable(model, w[1:num_] >= 0)

    @objective(model, Min, transpose(w)*matriz*w)

    @constraint(model, eq1, sum(w) == 1)

    optimize!(model)
    portafolio.weights = w

end

