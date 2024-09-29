include("structs.jl")
using JuMP
using Ipopt
using Match 


function optim!(portafolio::Portafolio; f = "")
    # se define el modelo
    model = Model(optimizer_with_attributes(Ipopt.Optimizer, "print_level" => 0))
    num_ = length(portafolio)
    history_returns = collect(values(get_returns(portafolio.prices)))
    matriz_cov_ret = cov(hcat(history_returns...))
    mean_returns = mean.(history_returns)
    @variable(model, w[1:num_] >= 0)

    @match f begin
        "min_risk" => @objective(model, Min, w'*matriz_cov_ret*w) 
        "max_return" => @objective(model, Max, sum(w .* mean_returns)) 
        _ => @objective(model, Max, sum(w .* mean_returns) / √(w'*matriz_cov_ret*w)) # default returns/risk 
    end

    @constraint(model, eq1, sum(w) == 1)

    optimize!(model)
    w = value.(w)
    portafolio.weights = w

end


