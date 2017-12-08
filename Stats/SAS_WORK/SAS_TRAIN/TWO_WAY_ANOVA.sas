/* TWO WAY ANOVA WITH GRAZERS DATA */

/*proc import to load data */
PROC IMPORT out = grazers
DATAFILE = '\\Client\C$\Users\patrickcorynichols\Desktop\case1301.csv'
DBMS = CSV REPLACE;
GETNAMES = YES;
RUN;

/*infile to load data */
DATA grazers2 (replace = yes);
INFILE '\\Client\C$\Users\patrickcorynichols\Desktop\case1301.csv' FIRSTOBS = 1 DLM =',';
INPUT COVER BLOCK $ TREAT $;
RUN;



PROC SORT data = grazers;
BY block;
RUN;

symbol1 interpol = none color = blue value = dot height = 1.5;
PROC GLM data = grazers plots = residuals;
CLASS BLOCK TREAT;
MODEL COVER = BLOCK TREAT BLOCK*TREAT;
OUTPUT out=resids rstudent=rstudent p=yhat;
RUN;
QUIT;

PROC GLM data = grazers plots = residuals;
CLASS BLOCK TREAT;
MODEL COVER = BLOCK TREAT;
OUTPUT out=resids rstudent=rstudent p=yhat;
RUN;
QUIT;

proc gplot data = resids;
plot rstudent*yhat;
run;
quit;

data grazersfinal;
set grazers;
covpct = cover/100;
lgtcov = log(covpct/(1-covpct));
IF block = 'B2' THEN blk2 = 1; ELSE blk2 =0;
IF block = 'B3' THEN blk3 = 1; ELSE blk3 =0;
IF block = 'B4' THEN blk4 = 1; ELSE blk4 =0;
IF block = 'B5' THEN blk5 = 1; ELSE blk5 =0;
IF block = 'B6' THEN blk6 = 1; ELSE blk6 =0;
IF block = 'B7' THEN blk7 = 1; ELSE blk7 =0;
IF block = 'B8' THEN blk8 = 1; ELSE blk8 =0;
IF block = 'B8' THEN blk9 = 1; ELSE blk9 =0;
IF block = 'B10' THEN blk10 = 1; ELSE blk10 =0;
IF treat IN('L','Lf','LfF') THEN lmp = 1; ELSE lmp = 0;
IF treat IN ('LfF','fF','Lf','f') THEN sml = 1; ELSE sml = 0;
IF treat IN ('LfF','fF') THEN lrg = 1; ELSE lrg = 0;
lmpsml = (lmp*sml);
lmpbig = (lmp*lrg);
RUN;

PROC SORT data = grazersfinal;
BY block;
RUN;

PROC GLM data = grazersfinal;
CLASS block treat;
MODEL lgtcov = block treat block*treat;
CONTRAST 'Limpets' TREAT -1 1 1 1 -1 -1;
CONTRAST 'Big Fish' TREAT 0 0 -1 1 -1 1;
CONTRAST 'Small Fish' TREAT -1 -1 1 0 1 0;
RUN;
QUIT; 



/* first run to test lmpbig */
PROC REG data = grazersfinal;
MODEL lgtcov = blk2 blk3 blk4 blk5 blk6 blk7 blk8 blk9 blk10 lmp sml lrg lmpsml lmpbig;
RUN;
/*second run to test lmpsml*/
PROC REG data = grazersfinal;
MODEL lgtcov = blk2 blk3 blk4 blk5 blk6 blk7 blk8 blk9 blk10 lmp sml lrg lmpsml;
RUN;
/*third run to test main effects */
PROC REG data = grazersfinal;
MODEL lgtcov = blk2 blk3 blk4 blk5 blk6 blk7 blk8 blk9 blk10 lmp sml lrg;
RUN;


PROC GLMSELECT data = grazersfinal;
CLASS BLOCK;
MODEL lgtcov = BLOCK lmp sml lrg lmpsml lmpbig;
RUN;

PROC GLM data = grazersfinal plots = residuals;
CLASS BLOCK TREAT;
MODEL lgtcov = BLOCK TREAT BLOCK*TREAT;
OUTPUT out = resids rstudent=rstudent p=yhat;
RUN;
QUIT;

proc gplot data = resids;
plot rstudent*yhat;
RUN;
quit;

/* MODEL WITH CONTRASTS */
PROC GLM data = grazersfinal;
CLASS BLOCK TREAT;
MODEL lgtcov = BLOCK TREAT;
/* CONTRAST ORDER C L Lf LfF f fF Alphabetizes based on upper first */
contrast 'Large Fish' TREAT 0 0 -0.5 0.5 -0.5 0.5 /e;
contrast 'Limpets' TREAT -0.33 0.33 0.33 0.33 -0.33 -0.33 /e;
contrast 'Limpets,SF' TREAT 1 -1 0.5 0.5 -0.5 -0.5 /e;
contrast 'Limpets,LF' TREAT 0 0 -0.5 0.5 0.5 -0.5 /e;  
/*e prints out table, makes sure right coefficients used */
RUN; 
QUIT;


proc print data = grazers; 
run;

PROC BOXPLOT data = grazers;
PLOT cover * block;
RUN;

PROC SORT data = grazers;
BY treat;
RUN;

PROC BOXPLOT data = grazers;
PLOT cover * treat;
RUN;
