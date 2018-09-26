"""
Function to count for a cross-table for Epi package.
> Internal
"""
function crossCount(i, j, data) # Look, data dependent
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

"""
    removeMissing(A; cols=missing)

Removing missing values in an array `A`. By default remove all rows with missing values in **any of the columns**. Otherwise removing only missing data only in those columns specified by `cols`.

Return the modified `A`.
"""
function removeMissing(A; cols=missing)
	if ismissing(cols) cols=1:size(A, 2) end
	rowMissing = collect([findall(ismissing, A[:, i]) for i in cols])
	rowMissing = unlist(rowMissing, unify=true)
	A[setdiff(1:size(A, 1), rowMissing), :]
end

"""
  unlist(A; unify=false)

R's style 'unlist''. `A` can be a 1-dimensional array of arrays (the motivation of this function), or a 2-dimensional array (not tested exhaustively).

`unify=true` wraps the result in the `unique()` function before return.
"""
function unlist(A; unify=false)
	foo = Vector()
	for i in eachindex(A) append!(foo, A[i]) end
	unify ? unique(foo) : foo
end
