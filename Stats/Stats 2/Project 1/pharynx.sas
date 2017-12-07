proc import out = pharynx
datafile='\\Client\C$\Users\patrickcorynichols\desktop\pharynx.xls'
DBMS =xls REPLACE;
sheet = 'PHARYNX';
getnames=yes;
RUN;

/* remove censored or missing data records (9's and 0's) as these are not complete records and should not be modeled*/
/* obs 141 & 136 & 156 & 157 */

data pharynx2;
set pharynx;
IF _n_ = 136 THEN delete;
IF _n_ = 141 THEN delete;
IF _n_ = 159 THEN delete;
RUN;

/* set up dummy variables for categorical factors */
data pharynx3;
set pharynx2;
/* logtransform time to fix non-normality */
logtime=log(time);
sqrtime=sqrt(time+0.5);

IF inst=2 THEN inst2=1; ELSE inst2=0; 
IF inst=3 THEN inst3=1; ELSE inst3=0; 
IF inst=4 THEN inst4=1; ELSE inst4=0; 
IF inst=5 THEN inst5=1; ELSE inst5=0; 
IF inst=6 THEN inst6=1; ELSE inst6=0; 

IF sex=2 THEN sex2=1; ELSE sex2=0;

IF tx=2 THEN tx2=1; ELSE tx2=0;

IF grade=2 THEN grade2=1; ELSE grade2=0; 
IF grade=3 THEN grade3=1; ELSE grade3=0;  

IF cond=2 THEN cond2=1; ELSE cond2=0; 
IF cond=3 THEN cond3=1; ELSE cond3=0; 
IF cond=4 THEN cond4=1; ELSE cond4=0;
 

IF site=2 THEN site2=1; ELSE site2=0;
IF site=4 THEN site4=1; ELSE site4=0;

IF t_stage=2 THEN tstage2=1; ELSE tstage2=0; 
IF t_stage=3 THEN tstage3=1; ELSE tstage3=0; 
IF t_stage=4 THEN tstage4=1; ELSE tstage4=0;
 
IF n_stage=1 THEN nstage1=1; ELSE nstage1=0; 
IF n_stage=2 THEN nstage2=1; ELSE nstage2=0;
IF n_stage=3 THEN nstage3=1; ELSE nstage3=0;

run;
proc print data = pharynx3;run;

/* basic means investigation */
PROC MEANS data = pharynx3;
VAR time age;
RUN;

/* treatment and condition investigation */
proc means data = pharynx3 n range std var min max median mean;
CLASS tx cond;
VAR time age;
RUN;

proc means data = pharynx3;
VAR age;
RUN;

proc sgscatter data = pharynx3;
MATRIX time age;
RUN;

proc univariate data = pharynx3 NOPRINT;
proc univariate data = pharynx3 NOPRINT;
histogram age /normal(percents=20 40 60 80 midpercents);
inset n normal(ksdpval)/ pos =ne format = 6.3;
qqplot age;
run;

proc means data = pharynx3 mean median std range min max;
var time;
run;

proc univariate data = pharynx3 NOPRINT;
histogram time;
qqplot time;
run;

/* log transform eda */
proc univariate data = pharynx3 NOPRINT;
histogram logtime /normal(percents=20 40 60 80 midpercents);
inset n normal(ksdpval)/ pos =ne format = 6.3;
run;
/* sqrt transform eda */
proc univariate data = pharynx3 NOPRINT;
histogram sqrtime /normal(percents=20 40 60 80 midpercents);
inset n normal(ksdpval)/ pos =ne format = 6.3;
qqplot sqrtime;
run;

PROC SGPPANEL data = pharynx3;
by site; 
scatter y = logtime x= age;
loess x= age y =logtime nomarkers;run;

/* scatter matrix for linearity checks*/

PROC SGSCATTER data =pharynx3;
MATRIX logtime age SITE N_STAGE T_STAGE COND GRADE TX SEX INST /diagonal =(histogram);
RUN;

RUN;


/* begin ad hoc analysis */
/* institution 3 shows deviance from average in the positive (more time) direction
interested to see if it's significant in analysis */
proc means data = pharynx3 n range std var min max median mean;
CLASS inst;
VAR time;
RUN;

/* set up initial model to check for assumptions */
PROC REG data = pharynx3;
MODEL logtime = age
				inst2 inst3 inst4 inst5 inst6 
				sex2 
				tx2 
				grade2 grade3 
				cond2 cond3 cond4 
				site2 site4 
				tstage2 tstage3 tstage4
				nstage1 nstage2 nstage3 / r VIF influence;
RUN;
QUIT;
/* test out removing leverage points to check non-constant variance change */
DATA pharynxlev;
SET pharynx3;
if _n_= 46 then delete;
if _n_= 65 then delete;
if _n_= 89 then delete;
if _n_= 99 then delete;
if _n_= 115 then delete;
if _n_= 185 then delete;
RUN;
/*re run proc reg without leverage points */
PROC REG data = pharynxlev;
MODEL logtime = age
				inst2 inst3 inst4 inst5 inst6 
				sex2 
				tx2 
				grade2 grade3 
				cond2 cond3 cond4 
				site2 site4 
				tstage2 tstage3 tstage4
				nstage1 nstage2 nstage3 / r VIF influence;
RUN;
QUIT;

/* check initial model, variable significance using PROC GLM */
PROC GLM data=pharynx3;
CLASS inst sex tx grade cond site t_stage n_stage;
MODEL logtime = age inst sex tx grade cond site t_stage n_stage /solution e;
RUN;
/* patient condition, tumor size and metastases status showing most significance with time */
PROC CORR data = pharynx3;
VAR logtime age inst sex tx grade cond site t_stage n_stage;
RUN;

/* apply selection methods to the factorial and quantitative predictors */
PROC GLMSELECT data = pharynx3;
CLASS  inst sex tx grade cond site t_stage n_stage;
MODEL logtime = age inst sex tx 
	   			grade cond site t_stage n_stage 
				/SELECTION = LASSO (choose=SBC);
RUN;

PROC GLMSELECT data = pharynx3;
CLASS  inst sex tx grade cond site t_stage n_stage;
MODEL logtime = age inst sex tx 
				grade cond site t_stage n_stage 
				/SELECTION  = LARS (choose=SBC);
RUN;

PROC PRINT data = pharynx3;
run;

/*auto selection via lasso based on CV PRESS - cross validate the model */
PROC GLMSELECT data = pharynx3;
CLASS  inst sex tx grade cond site t_stage n_stage;
MODEL logtime = age inst sex tx grade cond site t_stage n_stage 
				/SELECTION = LASSO (choose=CV) CVMethod=Random(10);
RUN;

/* LARS and LASSO agree, we use entire factors in our analysis, including insignificant levels */
PROC REG data = pharynx3;
MODEL logtime = inst2 inst3 inst4 inst5 inst6
				cond2 cond3 cond4 
				tstage2 tstage3 tstage4 
				nstage1 nstage2 nstage3 / influence CLM CLI PARTIAL;
RUN;

