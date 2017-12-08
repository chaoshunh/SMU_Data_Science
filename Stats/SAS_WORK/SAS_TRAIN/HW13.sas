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
matrix mortality educ so2 nonwhite precip sound / diagonal = (histogram);
RUN;

PROC sgscatter data = pollution2;
matrix mortality educ logso2 nonwhite / diagonal = (histogram);
RUN;

PROC REG data = pollution2;
MODEL mortality = so2 nonwhite educ precip sound poor / VIF CLB;
RUN;

PROC REG data = pollution2;
MODEL mortality = logso2 nonwhite educ / VIF CLB CLM CLI;
RUN;

PROC REG data = pollution2;
MODEL mortality = logso2 nonwhite  / VIF CLB;
RUN;

PROC REG data = pollution2;
MODEL mortality = logso2 lognonwhite educ / VIF CLB;
RUN;

%let database = NBA;
%let server = 127.0.0.1;
proc sql;
connect to mysql as source
(DATABASE = &database
SERVER = &server
PORT = 3306
USER = cnichols
PASSWORD = clx97xyA!
);
RUN;

/* THIS IS THE IMPORT */
PROC IMPORT OUT = NBA
DATAFILE = "\\Client\C$\Users\patrickcorynichols\Desktop\NBA.csv" 
DBMS = CSV REPLACE;
GETNAMES = YES;
DATAROW = 2;
RUN;
QUIT;

PROC IMPORT OUT = NBA3
DATAFILE = "\\Client\C$\Users\patrickcorynichols\Desktop\NBA2.csv" 
DBMS = CSV REPLACE;
GETNAMES = YES;
DATAROW = 2;
RUN;
QUIT;

data nba4 (REPLACE=YES);
SET NBA3;
RUN;

PROC REG data = NBA4;
MODEL W = TPM DREB STL TOV FTM BLK AST / VIF;
RUN;

PROC SGSCATTER DATA = NBA4;
MATRIX W TPM DREB STL TOV FTM BLK AST;
RUN;


PROC CORR data = NBA3;
VAR W _3PM DREB STL TOV FTM BLK AST ;
RUN;

data  NBA2;
SET NBA;
rebthree = three_points_made * off_rebounds;
RUN;



/* field goals att not significant, free_throws att, paint_pts, three_points_att highly correlated w threepointsmade */
PROC CORR data = NBA;
VAR wins three_points_made assists def_rebounds rebounds off_rebounds blocks points fast_break_pts free_throws_made personal_fouls
	second_chance_pts points_off_turnovers turnovers steals two_points_made
	paint_pts flagrant_fouls;
RUN;

PROC sgscatter data= NBA;
MATRIX wins assists blocks fast_break_pts off_rebounds personal_fouls 
points_off_turnovers turnovers rebounds steals three_points_made;
RUN;

PROC REG data = NBA3;
MODEL wins = steals three_points_made def_rebounds turnovers / VIF CLB CLI CLM; 
RUN;


