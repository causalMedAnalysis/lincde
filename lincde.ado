*!TITLE: LINCDE - estimating controlled direct effects using linear models
*!AUTHOR: Geoffrey T. Wodtke, Department of Sociology, University of Chicago
*!
*! version 0.1
*!

program define lincde, eclass

	version 15	

	syntax varlist(min=1 max=1 numeric) [if][in] [pweight], ///
		dvar(varname numeric) ///
		mvar(varname numeric) ///
		d(real) ///
		dstar(real) ///
		m(real) ///
		[cvars(varlist numeric)] ///
		[NOINTERaction] ///
		[cxd] ///
		[cxm] ///
		[reps(integer 200)] ///
		[strata(varname numeric)] ///
		[cluster(varname numeric)] ///
		[level(cilevel)] ///
		[seed(passthru)] ///
		[saving(string)] ///
		[detail]

	qui {
		marksample touse
		count if `touse'
		if r(N) == 0 error 2000
	}

	if ("`detail'" != "") {
		lincdebs `varlist' [`weight' `exp'] if `touse' , ///
			dvar(`dvar') mvar(`mvar') d(`d') dstar(`dstar') m(`m') ///
			cvars(`cvars') `nointeraction' `cxd' `cxm'
	}
	
	if ("`saving'" != "") {
		bootstrap CDE=r(cde), force ///
			reps(`reps') strata(`strata') cluster(`cluster') level(`level') `seed' ///
			saving(`saving', replace) noheader notable: ///
			lincdebs `varlist' [`weight' `exp'] if `touse' , ///
				dvar(`dvar') mvar(`mvar') d(`d') dstar(`dstar') m(`m') ///
				cvars(`cvars') `nointeraction' `cxd' `cxm'
	}

	if ("`saving'" == "") {
		bootstrap CDE=r(cde), force ///
			reps(`reps') strata(`strata') cluster(`cluster') level(`level') `seed' ///
			noheader notable: ///
			lincdebs `varlist' [`weight' `exp'] if `touse' , ///
				dvar(`dvar') mvar(`mvar') d(`d') dstar(`dstar') m(`m') ///
				cvars(`cvars') `nointeraction' `cxd' `cxm'
	}
			
	estat bootstrap, p noheader
	di "Note: CDE evaluated at m=`m'"

end lincde
