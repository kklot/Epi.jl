"""
    crossTable(x, y; row=true, column=false)

Make cross-tabulation table between arrays `x` and `y`. 

Optional `row` and `column` report row and column percentage respectively (not yet implemented).

Return table of complete cases only, i.e., missing values are removed.
"""
function crossTable(x, y; row=true, column=false)
	if length(x)!=length(y) error("Different length") end
	data = removeMissing(hcat(x, y))
	xx, yy = (unique(data[:, 1]), unique(data[:, 2]))
	nr, nc = (length(xx), length(yy))
	if nc | nr > 7 print("Consider grouping the variables") end
	A = NamedArray{Union{Missing, Int}}(nr, nc)
	for i in 1:nr, j in 1:nc
		A[i, j] = crossCount(xx[i], yy[j], data)
	end
 	A = hcat(A, colSum(A))
 	A = vcat(A, transpose(rowSum(A)))
	setnames!(A, push!(string.(xx), string("Total")), 1)
	setnames!(A, push!(string.(yy), string("Total")), 2)
	A
end
