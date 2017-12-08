data highway;
input Rate Len Adt Trk Sp lw shl itg sigs acpt lan type;
obsno=_N_;
datalines;
4.58 4.99 69 8 55 12 10 1.20 0 4.60 8 1
2.86 16.11 73 8 60 12 10 1.43 0 4.40 4 1
3.02 9.75 49 10 60 12 10 1.54 0 4.70 4 1
2.29 10.65 61 13 65 12 10 0.94 0 3.80 6 1
1.61 20.01 28 12 70 12 10 0.65 0 2.20 4 1
6.87 5.97 30 6 55 12 10 0.34 1.84 24.80 4 2
3.85 8.57 46 8 55 12 8 0.47 0.70 11.0 4 2
6.12 5.24 25 9 55 12 10 0.38 0.38 48.50 4 2
3.29 15.79 43 12 50 12 4 0.95 1.39 7.50 4 2
5.88 8.26 23 7 50 12 5 0.12 1.21 8.20 4 2
4.20 7.03 23 6 60 12 10 0.29 1.85 5.40 4 2
4.61 13.28 20 9 50 12 2 0.15 1.21 11.20 4 2
4.80 5.40 18 14 50 12 8 0 0.56 15.20 2 2
;
run;
/* run principal components analysis using standardized data
correlation matrix is the same as using standardized data */
/* out provides data on principal components by observations plugged into eigenvectors */
proc princomp data = highway out=HighwayPC;
var Rate Len Adt Trk Sp lw shl itg sigs acpt lan;
run;

/* plot */
title 'Plot of the First Two Principal Components';
%plotit(data=HighwayPC,labelvar=obsno,
plotvars=Prin2 Prin1, color=black, colors=blue);
run;

/* output a data set called highway pc, run prin components analysis */
/* standard is mean centered, will correlation matrix */
/* can unstandardize using cov option, need to understand observations
does variability play a role? */
proc princomp data = highway cov out=HighwayPC;
var Rate Len Adt Trk Sp lw shl itg sigs acpt lan;
run;

/* PCR EXAMPLE ! eigenvectors used as new explanatory values*/
/* Take principal components and use them in a regression */
proc princomp data=UScrime out=uscrimepc;
run;
proc print data = uscrimepc; run;

title 'PCR Using CrossValidation for Component Selection';

/* method=pcr is prin components regression, cv=one = leave one out cross validation */
proc pls data=uscrime method=pcr cv=one cvtest (stat=press);
model r = age so ed ex0 ex1 LF M N NW U1 U2 W X;
run;

/* use principal components in a regression after cross validation chooses # of components */
proc pls data=uscrime method=pcr nfact=4;
model r = age so ed ex0 ex1 LF M N NW U1 U2 W X;
run;


title 'Plot of The First Two Principal Components';
%plotit(data=HighwatPC,labelvar=obsno,
plotvars=Prin2 Prin1, color=black, colors=blue);
run;


/* PLACES ANALYSIS USING PCA */
data places;
infile '\\Client\C$\Users\PatrickCoryNichols\Desktop\places.txt';
input climate housing health crime trans educate arts recreate econ id;
climate=log10(climate);
housing=log10(housing);
health=log10(health);
crime=log10(crime);
trans=log10(trans);
educate=log10(educate);
arts=log10(arts);
recreate=log10(recreate);
econ=log10(econ);
run;

/* principal components using the covariance to allow variances to influence analysis */
/* The results of principal component analysis depend on the scales at which the variables are measured.
Principal component analysis using the covariance function should only be considered if all of the variables 
have the same units of measurement.If the variables either have different units of measurement 
(i.e., pounds, feet, gallons, etc), or if we wish each variable to receive equal weight in the analysis, 
then the variables should be standardized before a principal components analysis is carried out. 
Standardize the variables by subtracting its mean from that variable and dividing it by its standard deviation */

proc princomp cov out=a;
var climate housing health crime trans educate arts recreate econ;
run;
/*correlations fo principal components with variables */
proc corr data = a;
	var prin1 prin2 prin3 climate housing health crime trans educate arts recreate econ;
	run;

/* plot principal components against one another notice no real correlation between prins */
proc gplot;
axis1 length=5in;
axis2 length=5in;
plot prin2*prin1 / vaxis=axis1 haxis=axis2;
symbol v=J f=special h=2 i=none color=black;
run;

/*principal components using the correlation matrix and standardized values (no cov) */
proc princomp  out=a;
var climate housing health crime trans educate arts recreate econ;
run;

/* principal components regression on places */
/* method pcr statement specifics principal components regression*/
proc pls data=places method=pcr;
model r = Age So Ed Ex0 Ex1 LF M N NW U1 U2 W X;
run;

/* cross validate to find # of factors for model */
proc pls data=places method=pcr cv=one cvtest(stat=press);
model r = age so ed ex0 ex1 LF M N NW U1 U2 W X;
run;

/* fit model with selected number of factors */
proc pls data =uscrime method =pcr nfact=4;
model r = age so ed ex0 ex1 LF M N NW U1 U2 W X;
output out=xscores XSCORE=T;
run;

ods listing;
proc transpose data=xloadings(drop=NumberOf Factors)
out=xloadings;
data xloadings;set xloadings;
obso = _n_;
rename col1=Factor1 col2=Fctor2 col3=Factor3 col4=Factor4;
run;

goptions border;
axis1 label=("Loading" ) major=(number=3) minor =none;
axis2 label=("Frequency");

/* Partial Least Squares can handle all breaks of assumptions in OLS */


proc pls data =uscrime method =pls nfact=4;
model r = age so ed ex0 ex1 LF M N NW U1 U2 W X;
output out=xscores XSCORE=T;
run;

/* set up test observation */
data uscrimepred;
input R age so ed ex0 ex1 LF M N NW U1 U2 W X;
datalines;
120 0 110 115 116 500 966 101 106 77 35 657 170
;
run;
data uscrime;
set uscrime uscrimepred;
run;
proc pls data = uscrime nfac=4 details method=pls;
model r = Age So Ed Ex0 Ex1 LF M N NW U1 U2 W X/solution;
output out=outpls
	predicted = yhat
	yresidual =yres
	xscore = xscr;
run;



data insurance;
input ZIP Fire Theft Age Income Race Vol Invol ;
loginc = log(income);
cards;
26    6.2   29    60.4  11744 10    5.3   0
40    9.5   44    76.5  9323  22.2  3.1   0.1
13    10.5  36    73.5  9948  19.6  4.8   1.2
57    7.7   37    66.9  10656 17.3  5.7   0.5
14    8.6   53    81.4  9730  24.5  5.9   0.7
10    34.1  68    52.6  8231  54    4     0.3
11    11    75    42.6  21480 4.9   17.9  0
25    6.9   18    78.5  11104 7.1   6.9   0
18    7.3   31    90.1  10694 5.3   7.6   0.4
47    15.1  25    89.8  9631  21.5  3.1   1.1
22    29.1  34    82.7  7995  43.1  1.3   1.9
31    2.2   14    40.2  13722 1.1   14.3  0
46    5.7   11    27.9  16250 1     12.1  0
56    2     11    7.7   13686 1.7   10.9  0
30    2.5   22    63.8  12405 1.6   10.7  0
34    3     17    51.2  12198 1.5   13.8  0
41    5.4   27    85.1  11600 1.8   8.9   0
35    2.2   9     44.4  12765 1     11.5  0
39    7.2   29    84.2  11084 2.5   8.5   0.2
51    15.1  30    89.8  10510 13.4  5.2   0.8
44    16.5  40    72.7  9784  59.8  2.7   0.8
24    18.4  32    72.9  7342  94.4  1.2   1.8
12    36.2  41    63.1  6565  86.2  0.8   1.8
7     39.7  47    83    7459  50.2  5.2   0.9
23    18.5  22    78.3  8014  74.2  1.8   1.9
8     23.3  29    79    8177  55.5  2.1   1.5
16    12.2  46    48    8212  62.3  3.4   0.6
32    5.6   23    71.5  11230 4.4   8     0.3
9     21.8  4     73.1  8330  46.2  2.6   1.3
53    21.6  31    65    5583  99.7  0.5   0.9
15    9     39    75.4  8564  73.5  2.7   0.4
38    3.6   15    20.8  12102 10.7  9.1   0
29    5     32    61.8  11876 1.5   11.6  0
36    28.6  27    78.1  9742  48.8  4     1.4
21    17.4  32    68.6  7520  98.9  1.7   2.2
37    11.3  34    73.4  7388  90.6  1.9   0.8
52    3.4   17    2     13842 1.4   12.9  0
20    11.9  46    57    11040 71.2  4.8   0.9
19    10.5  42    55.9  10332 94.1  6.6   0.9
49    10.7  43    67.5  10908 66.1  3.1   0.4
17    10.8  34    58    11156 36.4  7.8   0.9
55    4.8   19    15.2  13323 1     13    0
43    10.4  25    40.8  12960 42.5  10.2  0.5
28    15.6  28    57.8  11260 35.1  7.5   1
27    7     3     11.4  10080 47.4  7.7   0.2
33    7.1   23    49.2  11428 34    11.6  0.3
45    4.9   27    46.6  13731 3.1   10.9  0
; 
run;
proc print data=insurance; run;
/* Run summary statistics and correlation analysis */
/* on variables fire, theft, age, income, and race */
proc sgscatter data=insurance;
matrix fire theft age income race / datalabel=zip;
run;
proc univariate data=insurance plots;
var fire theft age income race;
run;
proc corr data=insurance nosimple;
var fire theft age income race;
run;
proc means data=insurance mean stddev cv min Q1 median Q3 max;
var fire theft age income loginc race;
run;
data ins2;
set insurance;
if zip=11 then delete;
run;
title 'Exploratory Data Analysis';
proc means data=ins2 mean stddev cv min Q1 median Q3 max;
var fire theft age income race;
run;
proc sgscatter data=ins2;
matrix fire theft age income race / datalabel=zip;
run;
proc univariate data=ins2 plots;
var fire theft age income race;
run;
proc corr data=ins2 nosimple;
var fire theft age income race;
run;
ODS rtf file='C:\Users\20224910\Desktop\Insurance PCA.rtf';
title 'Principal Components Analysis with 60611 Removed';
proc princomp data=ins2 cov out=InsPCcov;
var fire theft age income race;
run;
title 'Correlation Principal Components Analysis with 60611 Removed';
proc princomp data=ins2 out=InsPCstan;
var fire theft age income race;
run;
%plotit(data=InsPCstan, labelvar=zip, plotvars=Prin2 Prin1, color=black, colors=blue);
quit;
/* proc print data=InsPCstan; run; */
title 'Regression with Principal Components';
proc reg data=InsPCstan;
model vol = prin1 prin2 prin3;
run;
proc reg data=InsPCstan;
model invol = prin1 prin2 prin3;
run;
ODS rtf close;

/* Canonical Correlation Analysis */
/* Use data=ins2 for analysis without 60611 */
ODS rtf file='C:\Users\20224910\Desktop\Insurance CCA.rtf';
proc cancorr data=insurance 
        vprefix=Policy vname='Policy Type'
        wprefix=Rates wname='Associated Rates';
      var  vol invol;
      with fire theft race income age;
      title 'Voluntary and Involuntary New Insurance Policies';
   run;
ODS rtf close;
