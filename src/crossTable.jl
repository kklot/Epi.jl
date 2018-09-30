"""
    crossTable(x, y; row=true, column=false)

Make cross-tabulation table between arrays `x` and `y`. 

Optional `row` and `column` report row and column percentage respectively, `digits` specifies the digits use in `round` function.

Return table of complete cases only, i.e., missing values are removed.

## Examples
```julia
julia> using Epi

julia> gender = ["Female", "Male"][rand(1:2, 100)];

julia> age = ["0-5", "6-10", "11-15"][rand(1:3, 100)];

julia> tm_ = crossTable(age, gender, row=true);
Frequency (row percentage)
4×3 Named Array{Text{String},2}
A ╲ B │         1          2          3
──────┼────────────────────────────────
1     │ 20 (0.57)  15 (0.43)   35 (1.0)
2     │ 18 (0.56)  14 (0.44)   32 (1.0)
3     │ 17 (0.52)  16 (0.48)   33 (1.0)
4     │ 55 (0.55)  45 (0.45)  100 (1.0)

julia> chisquaretest(tm_)
Chi-square: 0.247 with 2 degrees of freedom
	p-value: 0.8837
Likelihood-ratio Chi-square: 0.2466 with 2 degrees of freedom
	p-value: 0.8839
```
"""
function crossTable(x::AbstractArray, y::AbstractArray; row=true, column=false, digits=2)
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
		println(NamedArray(Text.(string.(Array(A), " (", pc, ")"))))
		return A # return Frequency table, no %
	end
	if column 
		println("Frequency (column percentage)")
		pr = round.(A ./ A[end, :]', digits=digits)
		NamedArray(Text.(string.(A, " (", pc, ")")))
		A; # return Frequency table, no %
	end
end
