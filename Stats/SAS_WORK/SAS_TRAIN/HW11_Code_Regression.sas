data crime;
infile '\\Client\C$\Users\Patrickcorynichols\Desktop\Data Science\Stats\Data Sets\crime2006.csv' FIRSTOBS = 2 DLM = ',';
INPUT State $ Pop VCR Murder Rape Rob Assault Prop Burg Larc Vehicle;
logpop = log(pop);
logvcr = log(vcr);
RUN;

PROC PRINT data = crime;
RUN;

PROC GPLOT data = crime;
PLOT vcr*pop;
SYMBOL1 V = Dot C = BLACK I= RL L =1;
RUN;

/*x needs to be transformed, values bunched*/
PROC GPLOT data = crime;
PLOT vcr*pop;
RUN;

PROC REG data = crime;
MODEL vcr=pop / clb cli clm lackfit;
RUN;

data chemical;
input time conc;
datalines;
1 2.57
1 2.84
1 3.10
3 1.07
3 1.15
3 1.22
5 0.49
5 0.53
5 0.58
7 0.16
7 0.17
7 0.21
9 0.07
9 0.08
9 0.09
;
RUN;

PROC REG data = chemical;
MODEL conc = time / CLM CLI CLB lackfit;
RUN;

PROC ANOVA data = chemical;
CLASS time;
MODEL conc = time;
MEANS time / tukey cldiff;
RUN;
