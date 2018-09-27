"""
    chisquaretest(A)		

calculate chi-square statistic and the p-value of a two-way Row x Colums. `A` is a matrix return from `crossTable` (which includes row total and column total).

The following statistics are reported

- Expectation values table
- Chi-Square Test
- Likelihood-ratio test
- Continuity-Adjusted Chi-Square Test
- Mantel-Haenszel Chi-Square Test (not implemented)
- Fisher’s Exact Test (not implemented)

"""
function chisquaretest(A)
	Ch = NamedArray{Float64}(size(A).-1)
	G2 = similar(Ch); Aj = similar(Ch); emat = similar(Ch)
	for i in 1:(size(A, 1)-1), j in 1:(size(A, 2)-1)
		eij = A[i, end] * A[end, j] / A[end, end]
		Ch[i, j] = (A[i, j] - eij)^2 / eij # chi-square statistic
		Aj[i, j] = max(0, abs(A[i, j] - eij)-0.5)^2 / eij # chi-square adj. statistic
		G2[i, j] = A[i, j] * log(A[i, j] / eij)  # G2 likelihood
		emat[i, j] = eij
	end
	chi, chiadj, kdf, g2 = (sum(Ch), sum(Aj), prod(size(Ch).-1), 2*sum(removeNaN(unlist(G2))))
	@info "Zero cells are omitted in calculating likelihood-ratio statistic"
	println("Expectation values")
	@show emat
	println("Chi-square: ", trunc(chi, digits=4), " with ", kdf, " degrees of freedom", "\n\tp-value: ", trunc(ccdf(Chisq(kdf), chi), digits=4))
	println("Continuity-Adjusted Chi-square: ", trunc(chiadj, digits=4), " with ", kdf, " degrees of freedom", "\n\tp-value: ", trunc(ccdf(Chisq(kdf), chiadj), digits=4))
	println("Likelihood-ratio Chi-square: ", trunc(g2, digits=4), " with ", kdf, " degrees of freedom", "\n\tp-value: ", trunc(ccdf(Chisq(kdf), g2), digits=4))
end
