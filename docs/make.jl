push!(LOAD_PATH,"../src/")
using Documenter, Epi

makedocs(
    modules = [Epi],
    sitename="Epi.jl",
    pages = ["Home" => "index.md"]
)

deploydocs(
    repo = "github.com/kklot/Epi.jl.git",
    julia = "1.0",
    osname = "linux"
)
