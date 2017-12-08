PROC IMPORT out=retailcb
DATAFILE = '\\Client\C$\Users\PatrickCoryNichols\Desktop\cb.txt'
DBMS = TAB REPLACE;
GETNAMES = YES;
run;

data retailcblog;
set retailcb;
logchargebacks = log(chargebacks);
logbillings = log(billings);
sqrtbillings = sqrt(billings);
invbillings = 1/billings;
invchargebacks = 1/chargebacks;
sqrtchargebacks = sqrt(chargebacks);
run;

PROC UNIVARIATE data = retailcblog NOPRINT;
HISTOGRAM billings logbillings logchargebacks sqrtbillings invbillings invchargebacks;
QQPLOT billings logbillings logchargebacks sqrtbillings invbillings invchargebacks;
run;

PROC UNIVARIATE data = retailcblog NOPRINT;
HISTOGRAM chargebacks logchargebacks;
run;

/* outlier identified, averaged as this is a rare occurrence and fits more with random shock */
proc sgplot data = retailcblog;
scatter y = chargebacks x = period;
run;


PROC ARIMA data = retailcblog;
identify var = chargebacks nlag=6;
run;

/* looks like AR1 term is needed to account for serial correlation */
PROC ARIMA data = retailcblog;
identify var = chargebacks(1);
run;

PROC AUTOREG data = retailcblog;
model chargebacks = invbillings  / nlag=1 method=ml;
run;

PROC REG data = retailcblog;
model chargebacks = invbillings;
run;


