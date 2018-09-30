"""
    crossTable(x, y; row=true)

Make cross-tabulation table between arrays `x` and `y`. 

Optional `row` report row percentage where `row=false` report column percentage, `digits` specifies the digits use in `round` function.

Return table of complete cases only, i.e., missing values are removed. This table can be used as the input to `chisquaretest`, `oddsratio`, and `riskratio` functions.

## Examples
```julia
julia> using Epi

julia> gender = ["Female", "Male"][rand(1:2, 100)];

julia> age = ["0-5", "6-10", "11-15"][rand(1:3, 100)];

julia> tm_ = crossTable(age, gender);
Frequency (row percentage)
4×3 Named Array{Text{String},2}
A ╲ B │      Male     Female      Total
──────┼────────────────────────────────
11-15 │ 16 (0.53)  14 (0.47)   30 (1.0)
0-5   │ 15 (0.43)  20 (0.57)   35 (1.0)
6-10  │ 18 (0.51)  17 (0.49)   35 (1.0)
Total │ 49 (0.49)  51 (0.51)  100 (1.0)

julia> tm_ = crossTable(age, gender, row=false);
Frequency (column percentage)
4×3 Named Array{Text{String},2}
A ╲ B │      Male     Female      Total
──────┼────────────────────────────────
11-15 │ 16 (0.33)  14 (0.27)   30 (0.3)
0-5   │ 15 (0.31)  20 (0.39)  35 (0.35)
6-10  │ 18 (0.37)  17 (0.33)  35 (0.35)
Total │  49 (1.0)   51 (1.0)  100 (1.0)
```
"""
function crossTable(x::AbstractArray, y::AbstractArray; row=true, digits=2)
	if length(x)!=length(y) error("Different length") end
	data = removeMissing(hcat(x, y))
	xx, yy = (unique(data[:, 1]), unique(data[:, 2]))
	nr, nc = (length(xx), length(yy))
	if nc | nr > 7 print("Consider grouping the variables") end
	A = NamedArray{Int}(nr, nc)
	for i in 1:nr, j in 1:nc
		A[i, j] = crossCount(xx[i], yy[j], data)
	end
 	A = hcat(A, sum(A, dims=2))
 	A = vcat(A, sum(A, dims=1))
	setnames!(A, push!(string.(xx), string("Total")), 1)
	setnames!(A, push!(string.(yy), string("Total")), 2)
	if row
		pc = round.(A ./ A[:, end], digits=digits)
		println("Frequency (row percentage)")
		println(NamedArray(Text.(string.(Array(A), " (", pc, ")")), 
		                   (names(A, 1), names(A, 2))))
	else
		println("Frequency (column percentage)")
		pr = round.(A ./ A[end, :]', digits=digits)
		println(NamedArray(Text.(string.(Array(A), " (", pr, ")")), 
		                   (names(A, 1), names(A, 2))))
	end
	A # return Frequency table, no %
end
