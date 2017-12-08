DATA dino;
INFILE '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Classes\Stats\Data Sets\sleuth3csv\ex1317.csv'
DLM = ','
FIRSTOBS = 2;
INPUT Iridium Strata $ Depthcat $;
RUN;
/* TWO WAY ANOVA ON DINO WITH FULL MODEL*/
PROC GLM data = dino;
CLASS depthcat strata;
MODEL iridium = depthcat | strata;
RUN;
/* TRANSFORM AND RE TEST ASSUMPTIONS */
DATA dinojr;
SET dino;
logirid = log(iridium);
RUN;

PROC PRINT data = dinojr;
RUN;
/* test for interactive effect and if log transform works to meet assumptions */
PROC GLM data = dinojr;
CLASS depthcat strata;
MODEL logirid = depthcat | strata;
OUTPUT OUT = dinoresids p = yhat rstudent = rstudent;
RUN;
QUIT;
/* RESULT: NO INTERACTION EFFECT */

PROC GLM data = dinojr;
CLASS depthcat strata;
MODEL logirid = depthcat strata;
RUN;
QUIT; 

PROC GPLOT data = dinoresids;
PLOT rstudent*yhat;
RUN;

/* set up dinosaurs data for regression analysis to use MLR to check for interaction effects*/
DATA dinoreg;
set dinojr;
IF strata = 'Limeston' then strat = 1; ELSE strat = 0;
IF depthcat = 1 THEN depth1 = 1; ELSE depth1 = 0;
IF depthcat = 2 THEN depth2 = 1; ELSE depth2 = 0;
IF depthcat = 3 THEN depth3 = 1; ELSE depth3 = 0;
IF depthcat = 4 THEN depth4 = 1; ELSE depth4 = 0;
IF depthcat = 5 THEN depth5 = 1; ELSE depth5 = 0;
IF depthcat = 6 THEN depth6 = 1; ELSE depth6 = 0;
stratdepth = strat*depth;
RUN;

PROC REG data = dinoreg;
MODEL logirid = strat depth2 depth3 depth4 depth5 depth6;
RUN;
QUIT;

DATA dinoreg2;
set dinojr;
IF strata = 'Limeston' then strat = 1; ELSE strat = 0;
IF depthcat = 1 THEN depth = 1;
ELSE IF depthcat = 2 THEN depth = 2;
ELSE IF depthcat = 3 THEN depth = 3;
ELSE IF depthcat = 4 THEN depth = 4;
ELSE IF depthcat = 5 THEN depth = 5;
ELSE IF depthcat = 6 THEN depth = 6;
stratdepth = strat*depth;
RUN;

PROC REG data = dinoreg2;
MODEL logirid = strat depth stratdepth;
RUN;

PROC CORR DATA = dinoreg2;
RUN;
