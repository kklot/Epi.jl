module Epi

using NamedArray

include("crossTable.jl")
# crossTable(copd[:ageonset], copd[:gender])
# crossTable(copd[:gender], copd[:ageonset])

export crossTable

end # module
