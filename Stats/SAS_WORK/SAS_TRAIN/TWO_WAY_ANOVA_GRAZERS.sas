

/* start grazers data, % cover is response */
DATA graze;
INFILE '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Classes\Stats\Data Sets\sleuth3csv\case1301.csv'
DLM = ','
FIRSTOBS = 2;
INPUT Cover Block $ Treat $;
RUN;

/* Preliminary Analysis */

proc univariate data = graze;
class block;
var cover;
HISTOGRAM;
run;

PROC SORT data = graze;
BY block;
RUN;

PROC BOXPLOT data = graze;
PLOT cover*block;
run;

PROC means data = graze N mean stddev median q1 q3;
class block;
var cover;
output out = meansout mean = mean std = std;

proc print data = meansout;
run;

data meansout2;
set meansout;
if _type_ = 0 then delete;
/* delete 0 variable for means plot */

proc sort data = meansout2;
by mean;
run;

data reshape (keep = yvar block mean);
set meansout2;
yvar = mean;
output;

yvar = mean - std;
output;

yvar = mean + std;
output;
run;

title 'Plot Means with Standard Error Bars from calculated Data';
axis1 offset=(5,5) minor=none;
axis2 label=(angle=90);
symbol1 interpol = hiloctj color = blue line =2;
symbol2 interpol =none color =blue value = dot height = 1.5;

proc gplot data = reshape;
plot yvar*block mean*block / overlay haxis = axis1 vaxis=axis2;
run;
quit;

/* larger means have larger variances, need to log transform response */

/* take logit transform of cover to reduce non constant variance */

data graze2;
set graze;
coverpct = cover/100;
logitcov = log(coverpct/(1-coverpct));
run;

proc print data = graze2;


/* RCB */
proc glm data = graze plots= residuals;
class block treat;
model cover = block treat;
output out = resids rstudent = rstudent p =yhat;
run;

proc gplot data = resids;
plot rstudent*yhat;
run;

symbol1 interpol = none color = blue value = dot height = 1.5;
proc glm data = graze2;
class block treat;
model logitcov = block treat;
output out = resids2 rstudent = rstudent p = yhat;
/* p is the predicted value, rstudent are studentized residuals to account for variability
type III is regression sums of squares, type I is sequential */
run;
proc gplot data = resids2;
plot rstudent*yhat;
run;
quit;

/* model with contrasts */
/* Contrast Order C L Lf LfF f fF */
proc glm data = graze2;
class block treat;
model logitcov = block treat;
contrast 'Large Fish' treat 0 0 -0.5 0.5 -0.5 0.5 /e;
contrast 'Limpets' treat -0.33 0.33 0.33 0.33 -0.33 -0.33 /e;
contrast 'Limpets Small' treat 1 -1 0.5 0.5 -0.5 -0.5 /e; 
RUN;	
quit;

proc glm data = graze2;
class block treat;
model logitcov = block treat;
run;
quit;

/* antilog of estimate of exp(y) = median regeneration ratios exp(-1.25) median regeneration ration only 27% */
/* can also use MLR */

data mlrgraze;
set graze2;
IF block = 'B2' then blk2 = 1; ELSE blk2 =0;
IF block = 'B3' then blk3 = 1; ELSE blk3 =0;
IF block = 'B4' then blk4 = 1; ELSE blk4 =0;
IF block = 'B5' then blk5 = 1; ELSE blk5 =0;
IF block = 'B6' then blk6 = 1; ELSE blk6 =0;
IF block = 'B7' then blk7 = 1; ELSE blk7 =0;
IF block = 'B8' then blk8 = 1; ELSE blk8 =0;
IF treat = 'L' OR treat = 'LfF' or treat = 'Lf' then lmp = 1; ELSE lmp = 0;
IF treat = 'F' OR treat = 'LfF' or treat = 'fF' then big =1; ELSE big = 0;
IF treat = 'f' OR treat = 'LfF' or treat = 'fF' or treat = 'Lf' then sml =1; ELSE sml = 0;
lmpbig = lmp*big;
lmpsml = lmp*sml;
smlbig = sml*big;
RUN;
/* or a different way assuming equal increases in blocks */
data mlrgraze2;
set graze2;
IF block = 'B2' then blk2 = 2; 
ELSE IF block = 'B3' then blk2 = 3; 
ELSE IF block = 'B4' then blk2 =4;
ELSE IF block = 'B5' then blk2 =5;
ELSE IF block = 'B6' then blk2 =6;
ELSE IF block = 'B7' then blk2 =7;
ELSE IF block = 'B8' then blk2 =8;
ELSE blk2 = 1;
IF treat = 'L' OR treat = 'LfF' or treat = 'Lf' then lmp = 1; ELSE lmp = 0;
IF treat = 'F' OR treat = 'LfF' or treat = 'fF' then big =1; ELSE big = 0;
IF treat = 'f' OR treat = 'LfF' or treat = 'fF' or treat = 'Lf' then sml =1; ELSE sml = 0;
lmpbig = lmp*big;
lmpsml = lmp*sml;
RUN;

/* FIND SIGNIFICANCE OF INTERACTIONS AND MAIN EFFECTS WITH MLR AND GROUPED BLOCK */
PROC REG data = mlrgraze2;
MODEL logitcov = blk2 lmp big sml lmpsml lmpbig;
RUN;
QUIT;

PROC REG data = mlrgraze2;
MODEL logitcov = blk2 lmp sml big lmpsml;
RUN;
QUIT;

PROC REG data = mlrgraze2;
MODEL logitcov = blk2 lmp sml big;
RUN;
QUIT;

/* FIND SIGNIFICANCE OF INTERACTIONS AND MAIN EFFECTS WITH SPEARATE BLOCK VARIABLES */
/* check for significance of lmpbig interaction */
PROC REG DATA = mlrgraze;
MODEL logitcov = blk2 blk3 blk4 blk5 blk6 blk7 blk8 lmp big sml lmpsml lmpbig;
OUTPUT OUT = mlrresids rstudent = rstudent p = yhat;
RUN;

PROC REG DATA = mlrgraze;
MODEL logitcov = blk2 blk3 blk4 blk5 blk6 blk7 blk8 lmp big sml lmpsml;
OUTPUT OUT = mlrresids rstudent = rstudent p = yhat;
RUN;

PROC REG DATA = mlrgraze;
MODEL logitcov = blk2 blk3 blk4 blk5 blk6 blk7 blk8 lmp big sml;
OUTPUT OUT = mlrresids rstudent = rstudent p = yhat;
RUN;

PROC PRINT data = mlrresids;
run;

/* check residuals manually */
PROC GPLOT data = mlrresids;
PLOT rstudent*yhat;
RUN;

DATA mlrgrazeplot;
SET mlrresids;
rate = exp(yhat);
RUN;

PROC GLM data = mlrgrazeplot;
CLASS block treat;
MODEL rate = block treat;
RUN;

/* check for significance of lmpsmall interaction */

PROC REG data = mlrgraze;
MODEL logitcov = blk2 blk3 blk4 blk5 blk6 blk7 blk8 lmp big sml lmpsml;
RUN;
QUIT;


/* check for significance of main effects */

PROC REG data = mlrgraze;
MODEL logitcov = blk2 blk3 blk4 blk5 blk6 blk7 blk8 lmp big sml;
RUN;
QUIT;
