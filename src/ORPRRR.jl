"""
    oddsratio(a, b, c, d; alpha=.05, exact=false)	
    oddsratio(A, B; alpha=.05, exact=false)	# todo

Calculate odds ratio of 2x2 table (Case-Control Studies).
If A, B are vectors, a two-way table is generated using `crossTable` and OR is calculated.

Exact method is not implemented.

|             | case | non-cases |         |
|:------------|:-----|:----------|:--------|
| exposed     | a    | b         | a+b     |
| non-exposed | c    | d         | c+d     |
|             | a+c  | b+d       | a+b+c+d |

## Example outputs

```julia
B = 2×2 Named Array{Int64,2}
Exposed ╲ Case │  +   -
───────────────┼───────
+              │ 25  12
-              │  9  69
1×3 Named Array{Float64,2}
      ╲  │      OR    lower    upper
─────────┼──────────────────────────
OR 95%CI │ 15.9722  6.00717  42.4679
```
"""
function oddsratio(a, b, c, d; alpha=0.05, exact=false)
		if any(i==0 for i in [a b c d]) @error("Zero cell(s), cannot compute OR's variance") end
		B = NamedArray([a b; c d], ( ["+", "-"], ["+", "-"] ), ("Exposed", "Case"))
		rowname = string("OR ", string(100*(1-alpha)), "%CI")
		A = NamedArray([.0 .0 .0], ( [rowname], ["OR", "lower", "upper"] ), ("", ""))
		A[1] = (a * d) / (b * c)
		v = sum([1/i for i in [a, b, c, d]])
		z = quantile(Normal(), 1-alpha/2)
		A[2], A[3] = A[1] * [exp(-z*sqrt(v)) exp(z*sqrt(v))]
		@show B 
		A
end

"""
    riskratio(a, b, c, d; alpha=.05)	
    riskratio(A, B; alpha=.05, exact=false)	# todo

Calculate risk ratio (RR) of 2x2 table; this can also be used for calculating prevalence ratio (PR).

If A, B are vectors, a two-way table is generated using `crossTable` and RR is calculated.

|             | case | non-cases |         |
|:------------|:-----|:----------|:--------|
| exposed     | a    | b         | a+b     |
| non-exposed | c    | d         | c+d     |
|             | a+c  | b+d       | a+b+c+d |

## Example outputs

```julia
julia> riskratio(122,355,22,965, alpha=0.01)
B = 2×2 Named Array{Int64,2}
Exposed ╲ Case │   +    -
───────────────┼─────────
+              │ 122  355
-              │  22  965
1×3 Named Array{Float64,2}
        ╲  │      RR    lower    upper
───────────┼──────────────────────────
RR 99.0%CI │ 11.4746  6.43047  20.4752
```
"""
function riskratio(a, b, c, d; alpha=0.05)
		if any(i==0 for i in [a c]) error("Zero cell(s), cannot compute RR's variance") end
		B = NamedArray([a b; c d], ( ["+", "-"], ["+", "-"] ), ("Exposed", "Case"))
		rowname = string("RR ", string(100*(1-alpha)), "%CI")
		A = NamedArray([.0 .0 .0], ( [rowname], ["RR", "lower", "upper"] ), ("", ""))
		p11, p12 = (a/(a+b), c/(c+d))
		A[1] = p11 / p12
		v = (1-p11)/a + (1-p12)/c
		z = quantile(Normal(), 1-alpha/2)
		A[2], A[3] = A[1] * [exp(-z*sqrt(v)) exp(z*sqrt(v))]
		@show B 
		A
end
