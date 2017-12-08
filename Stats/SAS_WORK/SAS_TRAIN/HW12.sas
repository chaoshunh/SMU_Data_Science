PROC IMPORT OUT = Pollution
DATAFILE = "\\Client\C$\Users\patrickcorynichols\Desktop\ex1217.csv" 
DBMS = CSV REPLACE;
GETNAMES = YES;
DATAROW = 2;
RUN;

data pollution2;
SET pollution;
logso2 = log(so2);
lognonwhite = log(nonwhite);
RUN;

PROC CORR data = pollution;
RUN;

PROC sgscatter data = pollution2;
matrix mortality poor educ logso2 lognonwhite / ellipse = (type=mean) diagonal = (histogram kernel);
RUN;

PROC REG data = pollution2;
MODEL mortality = so2 nonwhite educ / VIF CLB;
RUN;

PROC REG data = pollution2;
MODEL mortality = logso2 nonwhite educ / VIF CLB;
RUN;

PROC REG data = pollution2;
MODEL mortality = logso2 nonwhite  / VIF CLB;
RUN;

PROC REG data = pollution2;
MODEL mortality = logso2 lognonwhite educ / VIF CLB;
RUN;
