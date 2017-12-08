data simpleCRD;
input time score;
datalines;
1 30
1 14
1 24
1 38
1 26
2 28
2 18
2 20
2 34
2 28
3 34
3 22
3 39
3 44
3 30
;

PROC GLM data = simplecrd;
class time;
model score = time;
run;
quit;


/* now for univariate analysis of repeated measures */
data simpleRM;
input subect time1 time2 time3;
datalines;
1 30 28 34
2 14 18 22
3 24 20 30
4 38 34 44
5 26 28 30
;
run;

/* no uni optional*/
PROC GLM data = simpleRM;
model time1 time2 time3 = / nouni;
repeated time 3 / printe;
run;
