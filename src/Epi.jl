module Epi

using NamedArrays

include("Utils.jl")
include("crossTable.jl")
include("ORPRRR.jl")

export crossTable
export removeMissing, unlist
export oddsratio, riskratio

end
