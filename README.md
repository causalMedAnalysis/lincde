# lincde: Module to Estimate Controlled Direct Effects using Linear Models

## Overview

**lincde** is a Stata module designed to estimate controlled direct effects using linear models.

## Syntax

```stata
lincde depvar [if] [in] [pweight], dvar(varname) mvar(varname) d(real) dstar(real) m(real) cvars(varlist) [options]
```

### Required Arguments

- `depvar`: Specifies the outcome variable.
- `dvar(varname)`: Specifies the treatment (exposure) variable.
- `mvar(varname)`: Specifies the mediator variable.
- `d(real)`: Specifies the reference level of treatment.
- `dstar(real)`: Specifies the alternative level of treatment. Together, (d - dstar) defines the treatment contrast of interest.
- `m(real)`: Specifies the level of the mediator at which the controlled direct effect is evaluated.

### Options

- `cvars(varlist)`: Specifies the list of baseline covariates to be included in the analysis. Categorical variables must be coded as dummy variables.
- `nointeraction`: Specifies whether a treatment-mediator interaction is excluded from the outcome model. By default, the interaction is included.
- `cxd`: Includes all two-way interactions between the treatment and baseline covariates in the outcome model.
- `cxm`: Includes all two-way interactions between the mediator and baseline covariates in the outcome model.
- `detail`: Prints the fitted model used to construct the effect estimates.
- `bootstrap_options: All `bootstrap` options are available.

## Description

The `lincde` module estimates controlled direct effects using a linear model for the outcome, conditional on treatment, the mediator, and the baseline covariates (if specified) after centering them around their sample means, and it computes inferential statistics using the nonparametric bootstrap.

- **Controlled direct effect**: The effect of treatment on the outcome, holding the mediator constant at a specific level. If there is no treatment-mediator interaction, the controlled direct effect is constant across different mediator values.

## Examples

### Example 1: No interaction between treatment and mediator

```stata
. use nlsy79.dta
. lincde std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) m(0) nointer reps(1000)
```

### Example 2: Treatment-mediator interaction

```stata
. lincde std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) m(0) reps(1000)
```

### Example 3: Treatment-mediator interaction and covariate-treatment interactions

```stata
. lincde std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) m(0) cxd reps(1000)
```

## Saved Results

The following results are saved in `e()`:

- **Matrices:**
  - `e(b)`: Matrix containing the controlled direct effect estimate.

## Author

**Geoffrey T. Wodtke**  
Department of Sociology  
University of Chicago  
Email: [wodtke@uchicago.edu](mailto:wodtke@uchicago.edu)

## References

- Wodtke GT and Zhou X. *Causal Mediation Analysis*. In preparation.

## See Also

- Stata manual: [regress](https://www.stata.com/manuals/rregress.pdf), [bootstrap](https://www.stata.com/manuals/rbootstrap.pdf)
