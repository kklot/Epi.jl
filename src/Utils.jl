"""
Function to count for a cross-table for Epi package.
> Internal
"""
function crossCount(i, j) # Look, data dependent
	count(x->x==j, data[findall(x->x==i, data[:, 1]), 2])
end

"""
		colSum(A)

Calculate column sum for two dimensional array `A`.

> Until a better comes...
"""
function colSum(A)
	[sum(A[i,:]) for i in 1:size(A, 1)]
end

"""
		rowSum(A)

Calculate row sum for two dimensional array `A`.

> Until a better comes...
"""
function rowSum(A)
	[sum(A[:,i]) for i in 1:size(A, 2)]
end
