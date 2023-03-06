### Calculate a Lorentz attractor
### Code from https://tng-daryl.medium.com/visualizing-the-lorenz-attractor-in-julia-c9417f219e9b

using DifferentialEquations
using Plots

function parameterized_lorenz!(du,u,p,t)
    
    x, y, z = u      #variables are part of vector array u
    σ, ρ, β, = p     #coefficients are part of vector array p
    
    du[1] = dx = σ*(y-x)
    du[2] = dy = x*(ρ-z) - y
    du[3] = dz = x*y - β*z
end

#Initial conditions. x=1.0, y=0.0, z=0.0
u0 = [1.0, 0.0, 0.0]   #Timespan of the simulation. 100 in this case. 
tspan = (0.0, 100.0)   #Coefficients of the functions. 
p = [10.0, 28.0, 8/3]  #Feeding the inputs to the solver
prob = ODEProblem(parameterized_lorenz!, u0, tspan, p)
sol = solve(prob)

plot1 = plot(sol, 
             vars = (1,2,3), 
             xlabel="x",  
             ylabel="y", 
             zlabel="z",
             label="x against y against z")
plot2 = plot(sol, label = ["x" "y" "z"])
plot(plot1, plot2, layout = (1, 2))
