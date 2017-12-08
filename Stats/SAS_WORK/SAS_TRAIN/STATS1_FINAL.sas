DATA Baseball;
INPUT TEAM $ Sal;
DATALINES;
SEA 1.4
SEA 2.25
SEA 13.4
SEA 2.3
SEA 18.0
SEA 2.05
SEA 2.0
SEA 7.66
NYY 20.6
NYY 6.0
NYY 33.0
NYY 21.6
NYY 6.55
NYY 13.0
NYY 13.0
NYY 13.1
;
RUN;

PROC NPAR1WAY data = baseball WILCOXON;
CLASS TEAM;
VAR SAL;
EXACT;
RUN;

data cheese;
input Case taste Acetic	H2S;	
datalines;
1	12.3	4.543	3.135	
2	20.9	5.159	5.043	
3	39	5.366	5.438	
4	47.9	5.759	7.496	
5	5.6	4.663	3.807	
6	25.9	5.697	7.601	
7	37.3	5.892	8.726	
8	21.9	6.078	7.966	
9	18.1	4.898	3.85	
10	21	5.242	4.174	
11	34.9	5.74	6.142	
12	57.2	6.446	7.908	
13	0.7	4.477	2.996	
14	25.9	5.236	4.942	
15	54.9	6.151	6.752	
16	40.9	6.365	9.588	
17	15.9	4.787	3.912	
18	6.4	5.412	4.7	
19	18	5.247	6.174	
20	38.9	5.438	9.064	
21	14	4.564	4.949	
22	15.2	5.298	5.22	
23	32	5.455	9.242	
24	56.7	5.855	10.199
25	16.8	5.366	3.664	
26	11.6	6.043	3.219	
27	26.5	6.458	6.962	
28	0.7	5.328	3.912	
29	13.4	5.802	6.685	
30	5.5	6.176	4.787	
;
run;

data cheese2;
set cheese;
IF H2S > 6 THEN cat = 1; ELSE cat = 0;
int1 = cat * acetic;
RUN;

PROC REG data = cheese2;
MODEL taste = acetic cat int1;
RUN;

PROC IMPORT out = cityrate
DATAFILE = '\\Client\C$\Users\PatrickCoryNichols\Desktop\CityRate.csv'
DBMS = CSV REPLACE;
GETNAMES = YES;
RUN;

DATA cityrate2;
SET cityrate;
WHERE city = 'NY' or city = 'Jackso' or city = 'Phoeni' or city = 'Seattl' or city ='San Di' or city = 'LA' or city = 'Dallas'
or city = 'Chicag' or city = 'Boston';
IF city = 'NY' OR city = 'Jackso' THEN region = 'E';
IF city = 'San Di' OR city = 'LA' OR city = 'Phoeni' OR city = 'Seattl' THEN region = 'W';
IF city = 'Chicag' OR City = 'Boston' THEN region = 'N';
IF city = 'Dallas' THEN region = 'S';
IF region = 'S' OR region = 'W' THEN area = 'SW';
IF region = 'N' OR region = 'E' THEN area = 'NE';
RUN;

PROC UNIVARIATE data = cityrate2;
	CLASS region;
	VAR rate;
	QQPLOT;
	HISTOGRAM;
RUN;

PROC SORT data = cityrate2;
BY region;
RUN;

PROC BOXPLOT data = cityrate2;
	PLOT rate*region;
RUN;

PROC MEANS data = cityrate2;
RUN;

PROC PRINT data = cityrate2;
RUN;

PROC GLM data = cityrate2;
CLASS region;
MODEL rate = region;
MEANS region / tukey BON;
CONTRAST 'Contrasts of Regions'
Region -1 -1 1 1;
RUN;


PROC GLM data = cityrate2;
CLASS area;
MODEL rate = area;
MEANS area / tukey BON;
RUN;

PROC TTEST data = cityrate2;
CLASS area;
VAR rate;
RUN;

PROC CORR data = cityrate;
RUN;

PROC SGSCATTER data = cityrate;
MATRIX rate distance;
RUN;
