DATA prostate (replace = yes);
INFILE '\\Client\C$\Users\patrickcorynichols\Desktop\prostate.csv' DLM = ','  FIRSTOBS = 2;
INPUT id $ PSA cancvol weight age bph sem capspen disease $;
RUN;


data prostate2 (replace = yes) ;
SET prostate (KEEP = PSA disease);
logpsa = LOG(PSA);
RUN;

PROC SORT data = prostate2;
BY disease psa;
RUN;


PROC boxplot data = prostate2;
plot PSA*disease;
plot logPSA*disease;
RUN;

PROC univariate data = prostate2;
CLASS disease;
VAR PSA;
histogram;
qqplot;
RUN;

PROC GLM data = prostate2;
	CLASS disease;
	MODEL  logpsa = disease;
	CONTRAST 'Contrasts for Disease'
	disease -1 0 1;
RUN;

data hsb2;
infile '\\Client\C$\Users\patrickcorynichols\Desktop\hsb2.csv' DLM = ',' FIRSTOBS = 2;
INPUT id $ female $ race $ ses $ schtyp $ prog $ read write math science socst;
RUN;

PROC TTEST h0 = 50 data = hsb2;
var write;
RUN;

PROC TTEST data = hsb2;
CLASS female;
VAR write;
RUN;

PROC NPAR1WAY WILCOXON data = hsb2;
CLASS female;
VAR write;
RUN;

PROC GLM data = hsb2;
CLASS race;
MODEL write = race;
RUN;

PROC NPAR1WAY WILCOXON data = hsb2;
CLASS race;
VAR write;
RUN;

PROC PRINT data = hsb2;
where race = '1' or race = '4';
RUN;
PROC NPAR1WAY WILCOXON data = hsb2;
CLASS race;
VAR write;
WHERE race = '4' 
	or race = '1';
RUN;

PROC SORT data = hsb2;
BY race write;
RUN;

PROC GLM data = hsb2;
	CLASS race;
	MODEL write = race;
	CONTRAST 'Test' 
	RACE -1 0 0 1;
RUN;

PROC GLM data = prostate2;
	CLASS disease;
	MODEL  logpsa = disease;
	CONTRAST 'Contrasts for Disease'
	disease -1 0 1;
RUN;
