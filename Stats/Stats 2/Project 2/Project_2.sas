
/* import initial data set */
PROC IMPORT out = proj2
DATAFILE = '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Classes\Stats\Data Sets\sleuth3csv\ex0222.csv'
DBMS = CSV REPLACE;
GETNAMES = YES;
RUN;

/* create second data set with transformed responses */
DATA project;
SET proj2;
logarith = log(arith);
logword = log(word);
logmath = log(math);
logparag = log(parag);
sqrarith = sqrt(arith);
sqrword = sqrt(word);
sqrmath = sqrt(math);
sqrparag = sqrt(parag);
invarith = 1/arith;
invword = 1/word;
invmath = 1/math;
invparag = 1/parag;
RUN;

proc print data = project;
run;

/* basic means analysis */
proc means data = project n range std var min max median mean q1 q3;
var arith word parag math;
run;

proc sort data = project;
by gender;
run;
/* basic means analysis by gender */
proc means data = project n range std var min max median mean q1 q3;
by gender;
var arith word parag math;
run;
/* univariate normality checks */
PROC UNIVARIATE NOPRINT data = project;
VAR arith math parag word;
HISTOGRAM;
QQPLOT;
RUN;
/* bivariate normality checks for ellipses */
PROC SGSCATTER;
MATRIX arith word parag math;
RUN;
/* bartlett's / box test for homogoneity of variance co-variances */
/* this test was repeated 4x for transformed variables */
PROC DISCRIM data = project pool=test;
class gender;
var arith math word parag;
run;
/* correlation table for response variables */
PROC CORR;
VAR arith word parag math;
RUN;
/* scatter grouped by gender for arithmetic and math to confirm visual correlation */
PROC SGPLOT;
scatter x =arith y=math / group = gender;
run;
/* regression line with confidence limits grouped by gender for arithmetic 
and math to confirm visual correlation */
PROC SGPLOT;
	reg x=arith y=math / 
	group = gender CLM CLI;
run;
/* regression line with confidence limits grouped by gender for parag
and word to confirm visual correlation */
PROC SGPLOT;
	reg x=parag y=word / 
	group = gender CLM CLI;
run;

/* the following code sets up the profile plot for all four variables */
data project_profiles;
set project;
varscore ="arith";amount=arith;output;
varscore="math";amount=math;output;
varscore="word";amount=word;output;
varscore="parag";amount=parag;output;
run;

proc sort data=project_profiles;
	by gender varscore;
run;

proc means data=project_profiles;
	by gender varscore;
	var amount;
	output out = a mean=mean;
run;

proc gplot data = a;
axis1 length = 3in;
axis2 length= 4.5in;
plot mean*varscore=gender /vaxis=axis1 haxis=axis2;
symbol1 v=J f=special h=2 l=1 i=join color=black; 
symbol2 v=L f=special h=2 l=1 i=join color=black;
run; 
/* manova analysis with supporting CCA */
PROC GLM data = project;
	CLASS gender;
	MODEL arith word parag math = gender;
	CONTRAST 'Gender Difference Contrast' gender  -1 1;
	ESTIMATE 'Gender Difference Estimate' gender -1 1;
	lsmeans gender / stderr;
	MANOVA h = gender / canonical printe printh;
RUN;
QUIT;


