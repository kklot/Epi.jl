"""
    crossTable(x, y)

Make cross-tabulation between `x` and `y`.
"""
function crossTable(x, y)
	if length(x)!=length(y) error("Different length") end
	data = hcat(x, y)
	xx, yy = (unique(x), unique(y))
	nr, nc = (length(xx), length(yy))
	if nc | nr > 7 print("Consider grouping the variables\nToo many categories\n") end
	A = NamedArray{Union{Missing, Int}}(nr, nc)
	for i in 1:nr, j in 1:nc
		A[i, j] = crossCount(xx[i], yy[j])
	end
 	A = hcat(A, colSum(A))
 	A = vcat(A, transpose(rowSum(A)))
	setnames!(A, push!(convert.(String, xx), String("Total")), 1)
	setnames!(A, push!(convert.(String, yy), String("Total")), 2)
	A
end
