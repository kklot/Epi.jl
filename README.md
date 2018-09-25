
<a id='Example.jl-Documentation-1'></a>

# Epi.jl Documentation

> Amassing functions, not mature...

Short-term plan:

- Functions for 2x2 table (add chi-square, Fisher, M-H, Kappa... from e.g., `HypothesisTests.jl`. Design-specific methods e.g., case-control/Cohort, case-cohort, matched case-control. ROC and epidemic curve.

<a id='Epi.crossTable-Tuple{Any,Any}' href='#Epi.crossTable-Tuple{Any,Any}'>#</a>
**`Epi.crossTable`** &mdash; *Method*.



```
crossTable(x, y)
```

Make cross-tabulation between `x` and `y`.


<a target='_blank' href='https://github.com/kklot/Epi.jl/blob/3c55ee3fc513b82e2bf43fb72e2c156fc1755afb/src/crossTable.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Epi.colSum-Tuple{Any}' href='#Epi.colSum-Tuple{Any}'>#</a>
**`Epi.colSum`** &mdash; *Method*.



```
	colSum(A)
```

Calculate column sum for two dimensional array `A`.

> Until a better comes...



<a target='_blank' href='https://github.com/kklot/Epi.jl/blob/3c55ee3fc513b82e2bf43fb72e2c156fc1755afb/src/Utils.jl#L9-L15' class='documenter-source'>source</a><br>

<a id='Epi.rowSum-Tuple{Any}' href='#Epi.rowSum-Tuple{Any}'>#</a>
**`Epi.rowSum`** &mdash; *Method*.



```
	rowSum(A)
```

Calculate row sum for two dimensional array `A`.

> Until a better comes...



<a target='_blank' href='https://github.com/kklot/Epi.jl/blob/3c55ee3fc513b82e2bf43fb72e2c156fc1755afb/src/Utils.jl#L20-L26' class='documenter-source'>source</a><br>

