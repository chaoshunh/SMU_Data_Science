PROC IMPORT OUT = METABOLIC (rename=(VAR1=GROUP VAR2=SCORE)) REPLACE
			DATAFILE = '\\Client\C$\Users\patrickcorynichols\Desktop\hw2.rtf'
			DBMS = dlm;
			GETNAMES = NO;
			DATAROW = 1;
			DELIMITER = ',';
RUN;


DATA METABOLIC (replace = yes);
INFILE '\\Client\C$\Users\patrickcorynichols\Desktop\hw2.txt' FIRSTOBS = 1 DLM = ',';
INPUT GRP $ VAL;
LOGVAL = LOG(VAL);
RUN;

proc univariate data=METABOLIC;
	CLASS GRP;
	VAR VAL LOGVAL;
	qqplot;
   run;

PROC BOXPLOT data = METABOLIC;
	plot LOGVAL*GRP;
	plot VAL*GRP;
RUN;

proc univariate data = METABOLIC;
	class GRP;
	VAR VAL;
	histogram;
RUN;

PROC TTEST DATA = METABOLIC ALPHA = .05 h0 = 0;
	CLASS GRP;
	VAR LOGVAL;
RUN;
