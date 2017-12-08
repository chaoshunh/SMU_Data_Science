data handicap;
infile '\\Client\C$\Users\patrickcorynichols\Desktop\Data Science\Stats\Data Sets\case0601.csv' DLM = ',' FIRSTOBS = 2;
INPUT Score Handicap $;
RUN;

PROC SORT data = handicap;
BY handicap;
RUN;

PROC BOXPLOT;
Plot score*handicap;
RUN;

PROC TTEST data = handicap alpha = .001666667;
	CLASS handicap;
	VAR score;
	WHERE handicap = 'Amputee' or handicap = 'Wheelcha';
RUN;

PROC UNIVARIATE data = handicap;
	CLASS handicap;
	VAR score;
	QQPLOT;
	HISTOGRAM;
RUN;

PROC means data = handicap;
	CLASS handicap;
	VAR score;
RUN;

PROC TTEST data = handicap alpha = 0.016666667;
	CLASS handicap;
	VAR score;
RUN;


PROC GLM data = handicap alpha = 0.05;
	CLASS handicap;
	MODEL score = handicap;
	WHERE handicap = 'Amputee' or handicap = 'Wheelcha' or handicap = 'Crutches';
	MEANS handicap / bon CLDIFF;
RUN;

data income;
infile '\\Client\C$\Users\patrickcorynichols\Desktop\Data Science\Stats\Data Sets\ex0525.csv' DLM = ',' FIRSTOBS = 2;
INPUT Subject $ Educ $ Income2005;
RUN;

PROC GLM data = income;
	CLASS educ;
	MODEL Income2005 = educ;
	MEANS educ / tukey dunnett('12') CLDIFF;
RUN;
