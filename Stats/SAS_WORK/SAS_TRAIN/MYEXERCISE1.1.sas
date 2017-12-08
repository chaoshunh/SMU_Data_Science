DATA TEMP;
INPUT ID SBP DBP SEX $ AGE WT;
datalines;
1 120 80 M 15 115
2 130 70 F 25 180
3 140 100 M 89 170
4 120 80 F 30 150
5 125 80 F 20 110
;
run;
proc print data = temp;
TITLE 'Exercise 1.1 - Cory Nichols'
run;
proc means data = temp;
run;


DATA RECOVERY;
INPUT LNAME $ RECTIME;
datalines;
JONES 3.1
SMITH 3.6
HARRIS 4.2
MCCULLEY 2.1
BROWN 2.8
CURTIS 3.8
JOHNSTON 1.8
;
run;
title "NICHOLS ASSIGNMENT";
proc print data = recovery; run;
proc means data = recovery; run;
