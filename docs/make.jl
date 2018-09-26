push!(LOAD_PATH,"../src/")
using Documenter, Epi

makedocs(
    modules = [Epi],
    format = :html,
    sitename="Epi.jl",
    pages = ["Home" => "index.md"]
)

deploydocs(
    repo = "github.com/kklot/Epi.jl.git",
    target = "build",
    branch = "gh-pages",
    latest = "master",
    deps = nothing,
    make = nothing,
    julia = "1.0",
    osname = "osx"
)
