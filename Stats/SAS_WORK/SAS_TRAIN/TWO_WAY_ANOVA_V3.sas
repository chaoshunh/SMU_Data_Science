DATA pygmalion;
INFILE '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Classes\Stats\Data Sets\sleuth3csv\case1302.csv'
DLM = ','
FIRSTOBS = 2;
INPUT Company $ Treat $ Score;
RUN;

DATA pygmalion2;
SET pygmalion;
IF company = 'C2' then cmp = 2;
ELSE IF company = 'C3' then cmp = 3;
ELSE IF company = 'C4' then cmp = 4;
ELSE IF company = 'C5' then cmp = 5;
ELSE IF company = 'C6' then cmp = 6;
ELSE IF company = 'C7' then cmp = 7;
ELSE IF company = 'C8' then cmp = 8;
ELSE IF company = 'C9' then cmp = 9;
ELSE IF company = 'C10' then cmp = 10;
ELSE cmp = 1;
IF treat = 'Pygmalio' then trt = 1; ELSE trt = 0;
cmppyg = cmp*trt;
RUN;

PROC PRINT data = pygmalion2;
RUN;

PROC reg data = pygmalion2;
MODEL score = cmp trt cmppyg;
RUN;

PROC REG data = pygmalion2;
MODEL score = cmp trt;
RUN;

PROC GLM data = pygmalion;
CLASS Company Treat;
MODEL Score = Company | Treat;
RUN;

PROC REG data = pygmalion;
MODEL score = company treat;
RUN;
QUIT;

PROC GLMSELECT data = pygmalion;
CLASS company treat;
MODEL score = company treat / SELECTION = LASSO;
RUN;

DATA pygmalion2;
SET pygmalion; 
IF company = 'C1' then comp1 = 1; ELSE comp1 = 0;
IF company = 'C2' then comp2 = 1; ELSE comp2 = 0; 
IF company = 'C3' then comp3 = 1; ELSE comp3 = 0;
IF company = 'C4' then comp4 = 1; ELSE comp4 = 0;
IF company = 'C5' then comp5 = 1; ELSE comp5 = 0;
IF company = 'C6' then comp6 = 1; ELSE comp6 = 0;
IF company = 'C7' then comp7 = 1; ELSE comp7 = 0;
IF company = 'C8' then comp8 = 1; ELSE comp8 = 0;
IF company = 'C9' then comp9 = 1; ELSE comp9 = 0;
IF company = 'C10' then comp10 = 1; ELSE comp10 = 0;
IF treat = 'Pygmalio' then pyg = 1;
ELSE pyg = 0;
RUN;


PROC REG data = pygmalion2;
MODEL score = comp2 comp3 comp4 comp5 comp6 comp7 comp8 comp9 comp10 pyg;
RUN;
QUIT;

data oct1way;
INPUT gas $ octane;
datalines;
A 91.7
A 91.2
A 90.9
A 90.6
B 91.7
B 91.9
B 90.9
B 90.9
C 92.4
C 91.2
C 91.6
C 91.0
D 91.8
D 92.2
D 92.0
D 91.4
E 93.1
E 92.9
E 92.4
E 92.4
;
RUN;

/* restructure for RCB */

data oct2way;
INPUT gas $ car $ octane;
datalines;
A B1 91.7
A B2 91.2
A B3 90.9
A B4 90.6
B B1 91.7
B B2 91.9
B B3 90.9
B B4 90.9
C B1 92.4
C B2 91.2
C B3 91.6
C B4 91.0
D B1 91.8
D B2 92.2
D B3 92.0
D B4 91.4
E B1 93.1
E B2 92.9
E B3 92.4
E B4 92.4
E B4 93.0
E 52 94.0
;
RUN;

PROC GLM data = oct1way;
CLASS gas;
MODEL octane = gas;
RUN;

PROC GLM data = oct2way;
CLASS gas car;
MODEL octane = gas car;
RUN;

/* measure effectiveness of blocking, is it relatively efficient?
RE(RCB,CR) = MSEcr / MSE rcb

or in practice

(r-1)MSB+r(c-1)MSE/(rc-1)MSE if = 1, then equally efficient to CRD
if > 1 then MSE for RCD is smaller than CRD and RCD should be used 
interpret number of times better than RCD is vs CRD RCB can obtain same power with half observations
if Relative Efficiency Metric = 2 

CRD best for small number of factors, controls for one extra source
of variation 

each treatment must be same from block to block*/
