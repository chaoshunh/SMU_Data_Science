data dogs;
infile '\\Client\C$\Users\patrickcorynichols\Desktop\Data Science\Stats\Data Sets\Exam1DogData.csv' dlm = ',' firstobs = 2;
INPUT response dog$;
Lresponse = log(response);
RUN;

PROC SORT data = dogs;
by dog;
RUN;

PROC TTEST data = dogs;
CLASS dog;
VAR Lresponse;
RUN;

PROC TTEST data = dogs alpha = 0.01 sides = u;
CLASS dog;
VAR response;
RUN;


PROC NPAR1WAY WILCOXON data = dogs;
CLASS dog;
VAR response;
EXACT / n = 10000;
RUN;

PROC PRINT data = dogs;
RUN;

PROC MEANS data = dogs;
CLASS dog;
VAR response lresponse;
RUN;

PROC BOXPLOT data = dogs;
plot response*dog;
RUN;

PROC BOXPLOT data = dogs;
plot Lresponse*dog;
RUN;

PROC GLM data = dogs;
CLASS dog;
MODEL response = dog;
means dog / hovtest = bf;
RUN;

PROC GLM data = dogs;
CLASS dog;
MODEL Lresponse = dog;
means dog / hovtest = bf;
RUN;
data city;
infile '\\Client\C$\Users\patrickcorynichols\Desktop\Data Science\Stats\Data Sets\CityRate.csv' dlm = ',' firstobs = 2;
INPUT rate city$;
IF city = 'Chicago' THEN region = 'North';
ELSE IF city = 'Dallas' THEN region = 'South';
ELSE IF city = 'NY' THEN region = 'North';
ELSE IF city = 'Phoenix' THEN region = 'South';
ELSE IF city = 'LA' THEN region = 'South';
Lograte = log(rate);
RUN;



PROC SORT data = city;
by city;
RUN;

PROC PRINT data = city;
RUN;

PROC MEANS data = city;
CLASS city;
VAR rate lograte;
RUN;

PROC GLM data = city;
CLASS city;
MODEL rate = city;
means city / hovtest = bf;
run;

PROC BOXPLOT data = city;
plot rate*city;
RUN;

PROC UNIVARIATE data = city;
CLASS city;
VAR lograte;
histogram;
qqplot;
RUN;
PROC UNIVARIATE data = city;
CLASS city;
VAR rate;
histogram;
qqplot;
RUN;


PROC GLM data = city alpha = 0.05;
	CLASS city;
	MODEL  rate = city;
	CONTRAST 'Contrasts for North v South'
	city 1.5 -1 -1 1.5 -1;
RUN; 

PROC ANOVA data = city;
	CLASS city;
	MODEL rate = city;
RUN;

PROC GLM data = city alpha = 0.05;
    CLASS city;
    MODEL rate = city;
    CONTRAST 'Title here'
    city 1 -1 0 0 0 ;
RUN;

PROC GLM data = city alpha = 0.05;
    CLASS city;
    MODEL rate = city;
	MEANS city / tukey bon ; 
RUN;

proc power; 
onesamplemeans 
mean = 3 
nullmean = 0 
ntotal = . 
stddev = 10 
power = .8; run; 

PROC NPAR1WAY WILCOXON data = city;
CLASS city;
VAR rate;


PROC MEANS data = city;
CLASS city;
VAR rate;
RUN;

PROC Ttest data = city;
CLASS city;
VAR rate;
WHERE city = 'Dallas' or city = 'Chicago';
RUN;
