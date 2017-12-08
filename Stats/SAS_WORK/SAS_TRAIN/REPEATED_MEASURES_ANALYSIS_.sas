data onebonew;
input group day1 day2 day3 day4 day5;
datalines;
1       26      20      18      11      10
1       34      35      29      22      23
1       41      37      25      18      15
1       29      28      22      15      13
1       35      34      27      21      17
1       28      22      17      14      10
1       38      34      28      25      22
1       43      37      30      27      25
2       42      38      26      20      15
2       31      27      21      18      13
2       45      40      33      25      18
2       29      25      17      13       8
2       29      32      28      22      18
2       33      30      24      18       7
2       34      30      25      24      23
2       37      31      25      22      20
run;proc print data=onebonew; run;

PROC GLM data = onebonew;
MODEL day1 day2 day3 day4 day5 = /nouni ;
REPEATED day 5 PROFILE / SUMMARY PRINTE;
RUN;
QUIT;

data immune;
infile '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Classes\Stats\Data Sets\sleuth3csv\ex1614.csv'
DLM = ","
FIRSTOBS = 2;
INPUT subject phase1 phase2 phase3;
RUN;

PROC GLM DATA = immune PLOTS = residuals;
MODEL phase1 phase2 phase3 = /nouni;
REPEATED phase 3 PROFILE / SUMMARY PRINTE;
RUN;
QUIT;


/* start of fiber crossover data */

data fiber;
input baseline hi lo order $;
datalines;
205	187	193	HL
161	145	138	HL
166	168	169	HL
195	167	176	HL
206	174	203	HL
135	102	130	HL
172	175	156	HL
172	157	161	HL
234	202	198	HL
175	155	169	HL
200	185	193	LH
151	160	127	LH
188	168	163	LH
204	182	163	LH
128	132	149	LH
202	218	197	LH
165	163	171	LH
190	180	182	LH
225	220	216	LH
246	203	206	LH
RUN;

data fiber2;
set fiber;
hilo = hi-lo;
hibase = hi-baseline;
run;

PROC means data = fiber2;
VAR hilo hibase;
run;

PROC GLM data = fiber2;
MODEL baseline hi lo = ;
REPEATED stage 3 PROFILE / SUMMARY PRINTE;
RUN;
QUIT;


/* repeated measures dog analysis */


data dogs;
  input treat dog p1 p2 p3 p4;
  datalines;
1  1 4.0 4.1 3.6 3.1
1  2 4.2 3.7 4.8 5.2
1  3 4.3 4.3 4.5 5.4
1  4 4.2 4.6 5.3 4.9
1  5 4.6 5.3 5.9 5.3
1  6 3.1 4.9 5.3 4.1
1  7 3.7 3.9 5.2 4.2
1  8 4.3 4.4 5.6 4.7
1  9 4.6 4.4 5.4 5.6
2 10 3.2 3.8 4.4 3.7
2 11 3.3 3.4 3.7 3.7
2 12 3.1 3.2 3.2 3.1
2 13 3.6 3.5 4.9 4.4
2 14 4.5 5.4 4.9 4.0
2 15 3.7 4.4 4.6 5.4
2 16 3.5 5.8 4.9 5.6
2 17 3.9 4.1 5.4 3.9
3 18 3.1 3.5 3.0 3.2
3 19 3.3 3.6 3.7 4.4
3 20 3.5 4.7 3.9 3.5
3 21 3.4 3.5 3.4 3.4
3 22 3.7 4.2 3.6 3.7
3 23 4.0 4.8 5.4 4.8
3 24 4.2 4.5 3.9 3.7
3 25 4.1 3.7 4.1 4.7
3 26 3.5 3.6 4.8 5.0
4 27 3.4 3.5 3.1 3.3
4 28 3.0 3.0 3.1 3.1
4 29 3.0 3.2 3.3 3.0
4 30 3.1 3.2 3.3 3.1
4 31 3.8 4.0 3.5 3.4
4 32 3.0 3.2 3.0 3.0
4 33 3.3 3.3 3.6 3.1
4 34 4.2 4.2 4.2 4.0
4 35 4.1 4.3 4.2 4.2
4 36 4.5 4.3 5.3 4.4
  run;
proc print;
  run;
proc glm;
  class treat;
  model p1 p2 p3 p4=treat;
  manova h=treat / printe;
  manova h=treat m=p1+p2+p3+p4;
  manova h=treat m=p2-p1,p3-p2,p4-p3;
  run;


