PROC IMPORT OUT = bloodbrain
DATAFILE = '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Classes\Stats\Data Sets\sleuth3csv\case1102.csv'
DBMS = CSV REPLACE;
GETNAMES = YES;
RUN;

DATA bloodbrain2;
SET bloodbrain;
logratio = log(brain/liver);
IF sex = 'Male' THEN gen = 1; ELSE gen = 0;
RUN;

PROC CORR data = bloodbrain2;
RUN;

PROC SGSCATTER data = bloodbrain2;
MATRIX logratio time days weight loss tumor / diagonal = (histogram);
RUN;

PROC UNIVARIATE data = bloodbrain2;
VAR time;
HISTOGRAM;
RUN;

PROC PRINT DATA = bloodbrain2;
RUN;

PROC REG data = bloodbrain2 corr plots(label) = (rstudentleverage cooksd);
MODEL logratio = days weight loss tumor gen / VIF;
RUN;
QUIT;

data bloodbrain3;
set bloodbrain2;
if _n_ = 30 then delete;
run;


PROC GLMSELECT data = bloodbrain2;
model logratio = days weight loss tumor gen / SELECTION = LASSO;
RUN;
QUIT;

PROC REG data = bloodbrain2;
MODEL logratio = days weight gen / partial;
run; 
/* results indicate weight can come out */

PROC REG data = bloodbrain2;
MODEL logratio = days gen / partial;
run; 

PROC PRINT data = bloodbrain2;
run;

/* Leave one out CV */

proc GLMSELECT data = bloodbrain2;
class sex;
model logratio = days weight loss tumor sex / selection = forward(STOP=PRESS);
RUN;

/* cross validation folds - number of observations left out at a time fold increase = variance increase
use either a 5 fold or 10 fold, leave one out has much more variance*/

/* ten fold - split into ten parts as equal as possible */

proc GLMSelect data = bloodbrain2;
MODEL logratio = days weight loss tumor gen / selection = forward(Choose = CV) CVMethod = Random(5);
RUN;

proc GLMSELECT data = bloodbrain2;
model logratio = days weight loss tumor gen / selection = lasso(STOP=CV);
RUN;
/* GLMselect will take care of your categorical variables for you in selection model */
proc glmselect; 
class temp(split) sex; 
model depVar = sex sex*temp; run;

/* use GLM select to discover model, investigate further with REG */
