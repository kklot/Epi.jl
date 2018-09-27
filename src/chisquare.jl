"""
    chisquaretest(A)		

calculate chi-square statistic and the p-value of a two-way Row x Colums. `A` is a matrix return from `crossTable` (which includes row total and column total).
"""
function chisquaretest(A)
	Ae = NamedArray{Float64}(size(A).-1)
	for i in 1:(size(A, 1)-1), j in 1:(size(A, 2)-1)
		eij = A[i, end] * A[end, j] / A[end, end]
		Ae[i, j] = (A[i, j] - eij)^2 / eij
	end
	chi, df = (sum(Ae), prod(size(Ae).-1)) 
	println("Chi-square: ", chi, " with ", df, " degree of freedom", "\np-value: ", ccdf(Chisq(df), chi) )
end
