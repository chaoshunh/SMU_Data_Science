PROC IMPORT OUT = pygmalion
DATAFILE = '\\Client\C$\Users\PatrickCoryNichols\Desktop\Case1302.csv'
DBMS = CSV REPLACE;
GETNAMES = YES;
RUN;

DATA pygmalions;
INFILE '\\Client\C$\Users\PatrickCoryNichols\Desktop\Case1302.csv' FIRSTOBS = 2 DLM = ',';
INPUT Company $ Treat $ Score;
RUN;


PROC GLM data = pygmalions plots = residuals;
CLASS Company Treat;
MODEL Score = Company Treat;
RUN;
QUIT;

DATA pygmalion2;
SET pygmalions;
logscore = log(score);
RUN;

PROC GLM data = pygmalion2 plots = residuals;
CLASS Company Treat;
MODEL logscore = Company Treat Company * Treat;
RUN;

DATA pygreg;
SET pygmalions;
IF Treat = 'Pygmalio' then pyg = 1; ELSE pyg = 0;
IF company = 'C2' then cmp2 = 1; ELSE cmp2 = 0;
IF company = 'C3' then cmp3 = 1; ELSE cmp3 = 0;
IF company = 'C4' then cmp4 = 1; ELSE cmp4 = 0;
IF company = 'C5' then cmp5 = 1; ELSE cmp5 = 0;
IF company = 'C6' then cmp6 = 1; ELSE cmp6 = 0;
IF company = 'C7' then cmp7 = 1; ELSE cmp7 = 0;
IF company = 'C8' then cmp8 = 1; ELSE cmp8 = 0;
IF company = 'C9' then cmp9 = 1; ELSE cmp9 = 0;
IF company = 'C10' then cmp1 = 1; ELSE cmp10 = 0;
RUN;

/* Look @ extra sum of squares F to determine if interaction necessary */
PROC GLM data = pygmalions plots = residuals;
CLASS company treat;
MODEL score = company treat company*treat;
RUN;

PROC GLM data = pygmalions plots = residuals;
CLASS company treat;
MODEL score = company treat;
RUN;

/* ((778.5 - 467.04)/(18-9)) / 51.8933) = F = 0.667 p(9(variance in full model df),9(difference in betas)) = 0.72 - interaction not significant */ 

PROC GLM data = pygmalion2 plots = residuals;
CLASS company treat;
MODEL logscore = company treat;
RUN;

