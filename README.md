
<a id='Epi.jl-Documentation-1'></a>

# Epi.jl Documentation

> Amassing functions, not mature...

Short-term plan:

- Functions for 2x2 table (add chi-square, Fisher, M-H, Kappa... from e.g., `HypothesisTests.jl`. Design-specific methods e.g., case-control/Cohort, case-cohort, matched case-control. ROC and epidemic curve.

<a id='Epi.crossTable-Tuple{Any,Any}' href='#Epi.crossTable-Tuple{Any,Any}'>#</a>
**`Epi.crossTable`** &mdash; *Method*.



```
crossTable(x, y; row=true, column=false)
```

Make cross-tabulation table between arrays `x` and `y`. 

Optional `row` and `column` report row and column percentage respectively (not yet implemented).

Return table of complete cases only, i.e., missing values are removed.


<a target='_blank' href='https://github.com/kklot/Epi.jl/blob/1f6384311becb42cc589670f13023183b640918b/src/crossTable.jl#L1-L9' class='documenter-source'>source</a><br>

<a id='Epi.colSum-Tuple{Any}' href='#Epi.colSum-Tuple{Any}'>#</a>
**`Epi.colSum`** &mdash; *Method*.



```
colSum(A)
```

Calculate column sum for two dimensional array `A`.

> Until a better comes...



<a target='_blank' href='https://github.com/kklot/Epi.jl/blob/1f6384311becb42cc589670f13023183b640918b/src/Utils.jl#L9-L15' class='documenter-source'>source</a><br>

<a id='Epi.rowSum-Tuple{Any}' href='#Epi.rowSum-Tuple{Any}'>#</a>
**`Epi.rowSum`** &mdash; *Method*.



```
rowSum(A)
```

Calculate row sum for two dimensional array `A`.

> Until a better comes...



<a target='_blank' href='https://github.com/kklot/Epi.jl/blob/1f6384311becb42cc589670f13023183b640918b/src/Utils.jl#L20-L26' class='documenter-source'>source</a><br>

<a id='Epi.removeMissing-Tuple{Any}' href='#Epi.removeMissing-Tuple{Any}'>#</a>
**`Epi.removeMissing`** &mdash; *Method*.



```
removeMissing(A; cols=missing)
```

Removing missing values in an array `A`. By default remove all rows with missing values in **any of the columns**. Otherwise removing only missing data only in those columns specified by `cols`.

Return the modified `A`.


<a target='_blank' href='https://github.com/kklot/Epi.jl/blob/1f6384311becb42cc589670f13023183b640918b/src/Utils.jl#L31-L37' class='documenter-source'>source</a><br>

<a id='Epi.unlist-Tuple{Any}' href='#Epi.unlist-Tuple{Any}'>#</a>
**`Epi.unlist`** &mdash; *Method*.



unlist(A; unify=false)

R's style 'unlist''. `A` can be a 1-dimensional array of arrays (the motivation of this function), or a 2-dimensional array (not tested exhaustively).

`unify=true` wraps the result in the `unique()` function before return.


<a target='_blank' href='https://github.com/kklot/Epi.jl/blob/1f6384311becb42cc589670f13023183b640918b/src/Utils.jl#L45-L51' class='documenter-source'>source</a><br>
