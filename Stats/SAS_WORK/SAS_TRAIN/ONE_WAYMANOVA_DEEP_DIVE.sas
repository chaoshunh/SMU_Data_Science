/* continuation of pottery */
DATA pottery;
input site $ al fe mg ca na;
datalines;
L 14.4 7.00 4.30 0.15 0.51
L 13.8 7.08 3.43 0.12 0.17
L 14.6 7.09 3.88 0.13 0.20
L 11.5 6.37 5.64 0.16 0.14
L 13.8 7.06 5.34 0.20 0.20
L 10.9 6.26 3.47 0.17 0.22
L 10.1 4.26 4.26 0.20 0.18
L 11.6 5.78 5.91 0.18 0.16
L 11.1 5.49 4.52 0.29 0.30
L 13.4 6.92 7.23 0.28 0.20
L 12.4 6.13 5.69 0.22 0.54
L 13.1 6.64 5.51 0.31 0.24
L 12.7 6.69 4.45 0.20 0.22
L 12.5 6.44 3.94 0.22 0.23
C 11.8 5.44 3.94 0.30 0.04
C 11.6 5.39 3.77 0.29 0.06
I 18.3 1.28 0.67 0.03 0.03
I 15.8 2.39 0.63 0.01 0.04
I 18.0 1.50 0.67 0.01 0.06
I 18.0 1.88 0.68 0.01 0.04
I 20.8 1.51 0.72 0.07 0.10
A 17.7 1.12 0.56 0.06 0.06
A 18.3 1.14 0.67 0.06 0.05
A 16.7 0.92 0.53 0.01 0.05
A 14.8 2.74 0.67 0.03 0.05
A 19.1 1.64 0.60 0.10 0.03
run;

/* test for homogeneity of variance covariance matrices */
proc discrim pool = test data = pottery;
class site;
var al fe mg ca na;
run;

PROC GLM data = pottery;
CLASS site;
MODEL al fe mg ca na = site;
contrast 'A vs I' site 1 0 -1 0;
lsmeans site /stderr;
MANOVA h = site;

run;
quit;


options ls=78;
title "Profile Plot for Pottery Data";

/* pivot data set to set up means capturing for profile plots */
data pottery2;
	set pottery;
  chemical="al"; amount=al; output;
  chemical="fe"; amount=fe; output;
  chemical="mg"; amount=mg; output;
  chemical="ca"; amount=ca; output;
  chemical="na"; amount=na; output;
  run;

/* sort to make graphics work */
proc sort;
  by site chemical;
  run;

/* get means in tabular data set */
proc means data = pottery2;
  by site chemical;
  var amount;
  output out=a mean=mean;
  run;
/* h is size of marker, symbol specifies each site's symbol, f = special is font, v = symbol type, i = join connects the dots with solid lines l = 1 */
proc gplot data= A;
  axis1 length=3 in;
  axis2 length=4.5 in;
  plot mean*chemical=site / vaxis=axis1 haxis=axis2;
  symbol1 v=J f=special h=2 l=1 i=join color=black;
  symbol2 v=K f=special h=2 l=1 i=join color=black;
  symbol3 v=L f=special h=2 l=1 i=join color=black;
  symbol4 v=M f=special h=2 l=1 i=join color=black;
  run;
  quit;

proc sort data=pottery2;
by chemical;
run;

proc means data = pottery2;
  by chemical;
  var amount;
  output out=b mean=mean;
  run;

data resids;
set pottery;
alres = al - 14.492;
feres = fe - 4.467;
mgres = mg - 3.1415;
cares = ca -0.1465;
nares = na - 0.1584;
run;


proc univariate data = resids;
var alres feres mgres cares nares;
HISTOGRAM;
run;

  /* the MANOVA prints individual variable ANOVAs, need to adjust for multiple tests error bias by taking bonferroni adjustment @ a/p */

/* Just as we can apply a Bonferroni correction to obtain confidence intervals, we can also apply a Bonferroni correction to assess 
  the effects of group membership on the population means of the individual variables. */

  /* Here, p = 5 variables, g = 4 groups, and a total of N = 26 observations. So, for an a = 0.05 level test, we reject

H0:µ1k=µ2k=?=µgk

  if

F>F3,22,0.01=4.82
*/

options ls=78;
title "MANOVA - Pottery Data";
data pottery;
  infile "D:\Statistics\STAT 505\data\pottery.txt";
  input site $ al fe mg ca na;
  run;
proc print;
  run;
proc glm;
/* estimate actually ESTIMATES the difference between groups, contrasts TESTS the differences */
  class site;
  model al fe mg ca na = site;
  contrast 'C+L-A-I' site  8 -2  8 -14;
  contrast 'A vs I ' site  1  0 -1   0;
  contrast 'C vs L ' site  0  1  0  -1;
  estimate 'C+L-A-I' site  8 -2  8 -14/ divisor=16;
  estimate 'A vs I ' site  1  0 -1   0;
  estimate 'C vs L ' site  0  1  0  -1;
  lsmeans site / stderr;
  manova h=site / printe printh;
  run;
