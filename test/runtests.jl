using Test

# Primary @testset

# Error reporting.
println("="^50)
@info("The following errors are expected output.")
include(joinpath("errors", "make.jl"))
@info("END of expected error output.")
println("="^50)
