using NamedArray

"""
Cross-tabulation/frequency table
"""
function crossTable(x, y)
	if length(x)!=length(y) error("Different length") end
	data = hcat(x, y)
	xx = unique(x)
	yy = unique(y)
	nr = length(xx)
	nc = length(yy)
	if nc | nr > 7 print("Consider grouping the variables\n
	                     Too many categories\n") end
	A = NamedArray{Union{Missing, Int}}(nr, nc)
	setnames!(A, convert.(String, xx), 1)
	setnames!(A, convert.(String, yy), 2)
	for i in 1:nr, j in 1:nc
		A[i, j] = crossCount(xx[i], yy[j])
	end
	A
end

function crossCount(i, j) # Look, data dependent
	count(x->x==j, data[findall(x->x==i, data[:, 1]), 2])
end
