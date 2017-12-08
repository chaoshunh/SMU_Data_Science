/* THIS IS AN EXAMPLE OF ONE WAY MANOVA */

data pottery;
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
;
RUN;
proc univariate data = pottery NOPRINT;
VAR na fe mg ca al;
HISTOGRAM;
RUN;

proc sgscatter data =pottery;
matrix na fe mg ca al;
run;

proc g3d data = pottery;
plot na*fe;
run;

proc glm data = pottery;
	class site;
	model al fe mg ca na = site;
	output out = resids r = ral rfe rmg rca rna;
	run;

proc print;
run;

PROC UNIVARIATE data = pottery;
VAR na fe;
HISTOGRAM;
QQPLOT;
RUN;

PROC SORT data = pottery;
BY site;
RUN;

PROC SGSCATTER data = pottery;
MATRIX al fe mg ca na;
RUN;

/* CHECK FOR HOMOGENEITY OF COVARIANCE MATRICES USING BARTLETTS TEST pool = test*/
proc discrim pool = test data = pottery;
class site;
var al fe mg ca na;
run;
/* PROCEED WITH MANOVA */
/* manova h identifies the hypothesis we wish to test (group site) */
/* printe gives us error sums of squares and cp matrix, h is hypothesis TESSCP */
/* the divisor gives us the fraction for the estimate, estimate actually ESTIMATES the difference */
/* goal is to set up orthorgonal or independent contrasts which sum to zero when sum of all cross 
products over sum group sizes is taken */
/* for single variable comparisons with multiple tests, use p value bonferroni adjusted @ a/p (num vars) */
/* contrast statements test the SIGNIFICANCE of the constrasts, not the estimate */
/* divisor does not impact results of contrast statement */
/* multiple contrasts also bonferroni adjusted */
/* for example, the contrast of C+L-A-I for aluminum p threshold
 = a/p = .01 because there are FIVE variables */
proc glm;
class site;
model al fe mg ca na = site;
contrast 'C+L-A-I' site 8 -2 8 -14;
contrast 'A vs I' site 1 0 -1 0;
contrast 'C vs L' site 0 1 0 -1;
estimate 'C+L-A-I' site 8 -2 8 -14 / divisor = 16;
estimate 'A vs I' site 1 0 -1 0;
estimate 'C vs L' site 0 1 0 -1;
lsmeans site / stderr;
manova h = site / printe printh;
run;


/* PROFILE PLOTS FOR MANOVA */

options ls=78;
title "Profile Plot for Pottery Data";
data pottery2;
  set pottery;
  chemical="al"; amount=al; output;
  chemical="fe"; amount=fe; output;
  chemical="mg"; amount=mg; output;
  chemical="ca"; amount=ca; output;
  chemical="na"; amount=na; output;
  run;
proc sort data = pottery2;
  by site chemical;
  run;

/* get amounts by site and chemical, summarize by mean*/
proc means data =pottery2;
  by site chemical;
  var amount;
  output out=a mean=mean;
  run;
/*create profile plot */
proc gplot;
  axis1 length=3 in;
  axis2 length=4.5 in;
  plot mean*chemical=site / vaxis=axis1 haxis=axis2;
  symbol1 v=J f=special h=2 l=1 i=join color=black;
  symbol2 v=K f=special h=2 l=1 i=join color=black;
  symbol3 v=L f=special h=2 l=1 i=join color=black;
  symbol4 v=M f=special h=2 l=1 i=join color=black;
run;





DATA wolves;
  LENGTH location $2 wolf $5 sex $1;
  INPUT location $ wolf $ sex $ x1-x9;
  subject=_n_;
  LABEL
       X1 = 'palatallength'
       X2 = 'postpalatallength'
       X3 = 'zygomaticwidth'
       X4 = 'palatalwidth-1'
       X5 = 'palatalwidth-2'
       X6 = 'postgforaminawidth'
       X7 = 'interorbitalwidth'
       X8 = 'braincasewidth'
       X9 = 'crownlength';
cards;
rm rmm1 m 126 104 141 81.0 31.8 65.7 50.9 44.0 18.2
rm rmm2 m 128 111 151 80.4 33.8 69.8 52.7 43.2 18.5
rm rmm3 m 126 108 152 85.7 34.7 69.1 49.3 45.6 17.9
rm rmm4 m 125 109 141 83.1 34.0 68.0 48.2 43.8 18.4
rm rmm5 m 126 107 143 81.9 34.0 66.1 49.0 42.4 17.9
rm rmm6 m 128 110 143 80.6 33.0 65.0 46.4 40.2 18.2
rm rmf1 f 116 102 131 76.7 31.5 65.0 45.4 39.0 16.8
rm rmf2 f 120 103 130 75.1 30.2 63.8 44.4 41.1 16.9
rm rmf3 f 116 103 125 74.7 31.6 62.4 41.3 44.2 17.0
ar arm1 m 117  99 134 83.4 34.8 68.0 40.7 37.1 17.2
ar arm2 m 115 100 149 81.0 33.1 66.7 47.2 40.5 17.7
ar arm3 m 117 106 142 82.0 32.6 66.0 44.9 38.2 18.2
ar arm4 m 117 101 144 82.4 32.8 67.5 45.3 41.5 19.0
ar arm5 m 117 103 149 82.8 35.1 70.3 48.3 43.7 17.8
ar arm6 m 119 101 143 81.5 34.1 69.1 50.1 41.1 18.7
ar arm7 m 115 102 146 81.4 33.7 66.4 47.7 42.0 18.2
ar arm8 m 117 100 144 81.3 37.2 66.8 41.4 37.6 17.7
ar arm9 m 114 102 141 84.1 31.8 67.8 47.8 37.8 17.2
ar arm10 m 110  94 132 76.9 30.1 62.1 42.0 40.4 18.1
ar arf1 f 112  94 134 79.5 32.1 63.3 44.9 42.7 17.7
ar arf2 f 109  91 133 77.9 30.6 61.9 45.2 41.2 17.1
ar arf3 f 112  99 139 77.2 32.7 67.4 46.9 40.9 18.3
ar arf4 f 112  99 133 78.5 32.5 65.5 44.2 34.1 17.5
ar arf5 f 113  97 146 84.2 35.4 68.7 51.0 43.6 17.2
ar arf6 f 107  97 137 78.1 30.7 61.6 44.9 37.3 16.5
;
RUN;

proc print data = wolves;
run;

proc discrim data = wolves crossvalidate pool = test;
class sex;
var x1 x2 x3 x4 x5 x6 x7 x8 x9;
run;

proc glm data = wolves;
class sex;
model x1 x2 x3 x4 x5 x6 x7 x8 x9 = sex;
manova h = sex /printe printh;
run;
