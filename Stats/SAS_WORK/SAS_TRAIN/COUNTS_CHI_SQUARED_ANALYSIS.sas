data pneucounts;
input position $ disease $ count @@;
datalines;
Lying Yes 31 Lying No 16
Sitting Yes 3 Sitting No 36
;
run;

proc freq data = pneucounts;
/* call for expected vs observed to help get to chi squared */
tables position * disease / out = freqcount outexpect;
/* each observation gets weighted as a COUNT, not individual by subject data */
weight count;
title 'Contingency Table to Pneumonia Data';
run;

proc print data = freqcount noobs;
title2 'Pneumonia Data Set from PROC FREQ';
run;

proc freq data = pneucounts;
/* call for a cell chi squared statistic, but also overall statistic
SAS will calculate the overall chisq if chisq is called for and also
give fisher's exact approximation to permutation test 
if too small of a data set, use fisher's exact chi squared only valid if all of
expected percentages > 5*/
tables position * disease / chisq nopercent norow nocol cellchi2;
weight count;
title 'Contingency Table for Pneumonia Data';
RUN;
