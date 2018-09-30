"""
    chisquaretest(A, adjusted=false)

calculate chi-square statistic and the p-value of a two-way Row x Colums. `A` is a matrix return from `crossTable` (which conveniently includes row total and column total).

The following statistics are reported

- Expectation values table
- Chi-Square Test
- Likelihood-ratio test
- Continuity-Adjusted Chi-Square Test (if `adjusted=true`)
- Mantel-Haenszel Chi-Square Test (not implemented)
- Fisher’s Exact Test (not implemented)

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
function chisquaretest(A; adjusted=false, expect=true)
	nr, nc = (size(A).-1)
	emat = Matrix{Float64}(undef, nr, nc)
	for i in 1:nr, j in 1:nc
		emat[i, j] = A[i, end] * A[end, j] / A[end, end]
	end
	cells = Array(A[1:nr, 1:nc]);
	kdf = prod(size(cells).-1)
	chi = sum((cells - emat).^2 .* (1 ./ emat))
	G2  = 2*sum(removeNaN(unlist(cells .* log.(cells .* (1 ./ emat) ))))  
	if adjusted 
		Adj = sum( max.(0, abs.(cells - emat).-0.5) .^2 .* (1 ./ emat) )
	end
	if (any(cells[i]==0 for i in eachindex(cells))) 
		@info "Zero cells are omitted in calculating likelihood-ratio" 
	end
	println("Chi-square: ", trunc(chi, digits=4), " with $kdf degrees of freedom", "\n\tp-value: ", trunc(ccdf(Chisq(kdf), chi), digits=4))
	if adjusted 
		println("Continuity-Adjusted Chi-square: ", trunc(Adj, digits=4), " with $kdf degrees of freedom", "\n\tp-value: ", trunc(ccdf(Chisq(kdf), Adj), digits=4))
	end
	println("Likelihood-ratio Chi-square: ", trunc(G2, digits=4), " with $kdf degrees of freedom", "\n\tp-value: ", trunc(ccdf(Chisq(kdf), G2), digits=4))
	if expect
		println("\n", "="^35)
		println("Expectation values table")
		println("Frequency (expected value)")
		println("\n", "-"^35)
		NamedArray(Text.(string.(cells, " (", trunc.(emat, digits=2), ")")), 
		           (names(A)[1][1:end-1], names(A)[2][1:end-1]))
	end
end
