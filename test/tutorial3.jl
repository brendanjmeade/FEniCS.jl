using FEniCS
using PyCall
using PyPlot

@pyimport fenics
@pyimport numpy as np
T = 2.0            # final time
num_steps = 10     # number of time steps
dt = T / num_steps # time step size
alpha = 3          # parameter alpha
beta = 1.2
nx = ny = 8
mesh = UnitSquareMesh(nx, ny)
V = FunctionSpace(mesh, "P", 1)
u_D = Expression(fenics.Expression("1 + x[0]*x[0] + alpha*x[1]*x[1] + beta*t",
degree=2, alpha=alpha, beta=beta, t=0))

bc = DirichletBC(V, u_D, "on_boundary")
u_n = interpolate(u_D, V)
u = TrialFunction(V)
v = TestFunction(V)
f = Constant(beta - 2 - 2*alpha)
F = u*v*dx + dt*dot(grad(u), grad(v))*dx - (u_n + dt*f)*v*dx

a, L = lhs(F),rhs(F)

u = FEniCS.Function(V)
t = 0

for n = 0:(num_steps-1)
    t=t+dt
    u_D.pyobject[:t]=t
    lvsolve(a,L,u,bc)
    #figure(1)
    #FEniCS.plot(u)
    u_e= interpolate(u_D,V)
    vv = FEniCS.get_array(u_e)
    ww = FEniCS.get_array(u)
    error = maximum(abs.(vv-ww))
    #@printf "t = %f: error = %10g" t error
    assign(u_n,u)
end
#colorbar()
print("Tutorial 3 finished")
true
