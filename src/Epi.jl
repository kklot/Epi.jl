module Epi

using NamedArrays, Distributions

include("Utils.jl")
include("crossTable.jl")
include("ORPRRR.jl")
include("chisquare.jl")

export crossTable
export removeMissing, unlist
export oddsratio, riskratio
export chisquaretest

end
