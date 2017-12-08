data income (replace = yes);
	infile '\\Client\C$\Users\patrickcorynichols\Desktop\Data Science\Stats\Data Sets\ex0525.csv' DLM = ',' FIRSTOBS = 2;
	INPUT Subject $  Educ $ Income2005;
	LogInc = LOG(Income2005);
RUN;

PROC SORT data = income;
	by Educ Income2005 LogInc;
RUN;

proc boxplot;
	plot Loginc*Educ;
RUN;

proc univariate data = income;
	CLASS EDUC;
	VAR Loginc;
	QQPLOT;
	HISTOGRAM;
RUN;

proc univariate data = income;
	CLASS EDUC;
	VAR LogInc;
	Histogram;
RUN;


PROC MEANS data = income;
CLASS educ;
RUN;


PROC ANOVA DATA = income ORDER = DATA;
	CLASS EDUC;
	MODEL Loginc=Educ;
	MEANS EDUC/TUKEY CLDIFF;
RUN;
QUIT;

PROC NPAR1WAY WILCOXON;
	CLASS EDUC;
	VAR Income2005;
	EXACT / n = 5000;
RUN;

proc multtest permutation;
class educ;
test mean(Income2005);
RUN;

ODS RTF;
ODS GRAPHICS ON;
proc glm data=income;
   class EDUC;
   model LOGINC = EDUC; 
   OUTPUT OUT = FITDATA P = YHAT R = RESID;
PROC GPLOT;
	PLOT RESID*EDUC;
	PLOT RESID*YHAT;
RUN;
ODS RTF CLOSE;
ODS GRAPHICS OFF;

proc glm data = income;
class educ;
model inc = educ;
random educ / adjust = tukey;
run;


PROC MIXED data = income CL covtest;
	class educ;
	model Inc = educ;
	random educ;
	lsmeans educ / adjust = tukey pdiff;
run;


