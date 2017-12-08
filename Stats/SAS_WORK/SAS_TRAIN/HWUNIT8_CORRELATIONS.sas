data baseball ;
INPUT Team $ Payroll Wins;
DATALINES;
NYY 206 95
BOS 162 89
CHC 146 75
PHI 142 97
NYM 134 79
DET 123 81
CHW 106 88
LAA 105 80
SF 99 92
MIN 98 94
LAD 95 80
HOU 92 76
SEA 86 61
STL 86 86
ATL 84 91
COL 84 83
BAL 82 66
MIL 81 77
TB 72 96
CIN 71 91
KC 71 67
TOR 62 85
ARZ 61 65
CLE 61 69
WAS 61 69
FA 57 80
TEX 55 90
OAK 52 81
SD 38 90
PIT 35 57
;
RUN;

PROC REG data = baseball;
MODEL wins=payroll / clb clm ;
RUN;


proc print data = baseball;
RUN;

GOPTIONS RESET = ALL;
Title "Baseball Scatter";

PROC GPLOT data = baseball;
PLOT wins*payroll;
SYMBOL1 V = Dot C = BLACK I = RL L =1;
RUN;
QUIT;

PROC SORT data = baseball;
by team;
RUN;

PROC CORR data = baseball;
VAR Payroll Wins;
Title' Correlations between Payroll and Wins';
RUN;


data baseball2;
INPUT Team $ Payroll Wins;
DATALINES;
NYY 206 95
BOS 162 89
CHC 146 75
PHI 142 97
NYM 134 79
DET 123 81
CHW 106 88
LAA 105 80
SF 99 92
MIN 98 94
LAD 95 80
HOU 92 76
SEA 86 61
STL 86 86
ATL 84 91
COL 84 83
BAL 82 66
MIL 81 77
TB 72 96
CIN 71 91
KC 71 67
TOR 62 85
ARZ 61 65
CLE 61 69
WAS 61 69
FA 57 80
TEX 55 90
OAK 52 81
PIT 35 57
;
RUN;

PROC CORR data = baseball2;
VAR Payroll Wins;
Title' Correlations between Payroll and Wins';
RUN;

data steers;
input Time pH;
logtime = log(Time);
DATALINES;
1 7.02
1 6.93
2 6.42
2 6.51
4 6.07
4 5.99
6 5.59
6 5.8
8 5.51
8 5.36
;
RUN;

PROC REG data = steers;
MODEL pH=logtime / clb clm ;
RUN;


