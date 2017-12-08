/* TWO WAY ANOVA BLOOD BRAIN */

DATA bb;
INFILE '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Classes\Stats\Data Sets\sleuth3csv\case1102.csv'
DLM = ','
FIRSTOBS = 2;
INPUT Brain Liver Time Treatment $ Days Sex $ Weight Loss Tumor;
brnliv = log(brain/liver);
RUN;
/* test for interactive effect */
PROC GLM data = bb plots = residuals;
CLASS time treatment;
MODEL brnliv = time | treatment;
OUTPUT out = bbresids p = yhat rstudent = rstudent;
RUN;
QUIT;
/* test for main effects */
PROC GLM data = bb plots = residuals;
CLASS time treatment;
MODEL brnliv = time treatment;
OUTPUT out = bbresids p = yhat rstudent = rstudent;
RUN;
QUIT;


/* set up reg for contrasts */

DATA bbreg;
SET bb;
IF treatment = 'NS' THEN treat = 1; ELSE treat = 0;
IF time = 0.5 THEN time4 = 1;ELSE time4 = 0;
IF time = 3 THEN time1 = 1; ELSE time1 = 0;
IF time = 24 THEN time2 = 1; ELSE time2 = 0;
IF time = 72 THEN time3 = 1; ELSE time3 = 0;
RUN;

/* run regression for contrasts */
PROC REG data = bbreg;
MODEL brnliv = time1 time2 time3 treat;
RUN;

PROC GLM data = bb;
CLASS time treatment;
MODEL brnliv = time treatment;
CONTRAST 'Time @ 0.5 vs All Else' TIME -1 1 1 1 /e;
RUN;

PROC GPLOT data = bbresids;
PLOT rstudent*yhat;
RUN;
