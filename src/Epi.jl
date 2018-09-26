module Epi

using NamedArrays

include("Utils.jl")
include("crossTable.jl")

export crossTable
export colSum, rowSum, removeMissing, unlist

end
