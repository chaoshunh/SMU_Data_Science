data test;
input Location $ Reach $ Bias Count Gender $;
DATALINES;
Other	Regional	0	1241 F
Other	Regional	0	1211 M
Other	Regional	1	500 S
South	Local	0	430 F
South	Local	0	493 M
Other	Local	0	519 F
Other	Regional	1	322 S
Other	Local	1	1591 M
Other	Regional	0	808 F
Other	Regional	1	867 S
Other	Local	0	741 F
Other	Local	1	831 F
South	Local	0	315 M
South	Local	0	99 F
South	Local	1	315 F
South	Local	0	501 S
South	Regional	0	133 S
South	Local	0	235 F
South	Local	0	211 M
South	Local	0	388 M
South	Local	1	513 M
South	Local	0	663 M
South	Local	1	639 F
South	Local	0	322 M
South	Regional	0	717 M
South	Local	0	277 S
South	Local	1	323 F
South	Regional	1	332 S
Other	Local	0	402 S
Other	Regional	1	655 F
Other	Local	1	1007 M
Other	Regional	1	304 F
Other	Local	1	339 M
Other	Local	1	1312 M
South	Local	0	218 M
South	Local	0	694 M
Other	Local	1	396 M
Other	Regional	0	1005 M
Other	Local	1	30 M
Other	Local	0	632 M
;

data logitout;
set test;
logcount = log(count);
sqrtcount = sqrt(count);
IF reach = 'Regional' THEN reaind=1; ELSE reaind=0;
IF location = 'Other' THEN locind = 1; ELSE locind =0;
IF gender = 'M' THEN genind = 1; ELSE genind =0;
react = reaind*count;
locct = locind*count;
genrct = genind*count;
run;
PROC PRINT DATA = test;
RUN; 

PROC MEANS data= test;
VAR count;
run;
PROC UNIVARIATE data = test;
VAR count;
HISTOGRAM;
QQPLOT;
RUN;

PROC GPLOT data=logitout;
PLOT count*reachind;
PLOT count*genind;
PLOT count*locind;
RUN;

/* data does not veer from normality enough */ 
PROC UNIVARIATE data = logitout;
VAR logcount sqrtcount;
HISTOGRAM;
QQPLOT;
RUN;
/* Begin Model Investigations */
PROC LOGISTIC data = logitout DESCENDING;
CLASS LOCATION REACH GENDER;
MODEL bias = LOCATION REACH GENDER count react locct genrct;
RUN;
/* GENDER highly insignificant */

PROC LOGISTIC data = logitout DESCENDING;
CLASS LOCATION REACH GENDER;
MODEL bias = LOCATION REACH count react locct;
RUN;
/* LOCATION interaction with count highly insignificant */

PROC LOGISTIC data = logitout DESCENDING;
CLASS LOCATION REACH GENDER;
MODEL bias = LOCATION REACH count react;
RUN;


/* STEPWISE method for model selection - not optimal because of experimentwise error rate */
PROC LOGISTIC data = test DESCENDING;
CLASS LOCATION REACH GENDER;
MODEL bias = location reach count gender / SELECTION = stepwise IPLOTS INFLUENCE CL LACKFIT;
effectplot interaction (x = location sliceby = reach) / at(location = 'South' 'Other');
RUN;

/* THIS IS THE FINAL MODEL */
PROC LOGISTIC data = test DESCENDING;
CLASS LOCATION REACH GENDER;
MODEL bias = location reach | count / IPLOTS INFLUENCE CL LACKFIT CTABLE;
effectplot fit /obs(jitter(y=0.02));
effectplot slicefit (sliceby=location)/at(reach=all) clm alpha = .3;
output out = logits predprobs = I p=probpreb;
RUN;
