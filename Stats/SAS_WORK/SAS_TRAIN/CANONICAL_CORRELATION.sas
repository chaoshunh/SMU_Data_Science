/* canonical correlation with sales data */
data sales;
input growth profit new create mech abs math;
datalines;
  93.0  96.0  97.8  9  12  9  20
  88.8  91.8  96.8  7  10  10  15
  95.0  100.3  99.0  8  12  9  26
  101.3  103.8  106.8  13  14  12  29
  102.0  107.8  103.0  10  15  12  32
  95.8  97.5  99.3  10  14  11  21
  95.5  99.5  99.0  9  12  9  25
  110.8  122.0  115.3  18  20  15  51
  102.8  108.3  103.8  10  17  13  31
  106.8  120.5  102.0  14  18  11  39
  103.3  109.8  104.0  12  17  12  32
  99.5  111.8  100.3  10  18  8  31
  103.5  112.5  107.0  16  17  11  34
  99.5  105.5  102.3  8  10  11  34
  100.0  107.0  102.8  13  10  8  34
  81.5  93.5  95.0  7  9  5  16
  101.3  105.3  102.8  11  12  11  32
  103.3  110.8  103.5  11  14  11  35
  95.3  104.3  103.0  5  14  13  30
  99.5  105.3  106.3  17  17  11  27
  88.5  95.3  95.8  10  12  7  15
  99.3  115.0  104.3  5  11  11  42
  87.5  92.5  95.8  9  9  7  16
  105.3  114.0  105.3  12  15  12  37
  107.0  121.0  109.0  16  19  12  39
  93.3  102.0  97.8  10  15  7  23
  106.8  118.0  107.3  14  16  12  39
  106.8  120.0  104.8  10  16  11  49
  92.3  90.8  99.8  8  10  13  17
  106.3  121.0  104.5  9  17  11  44
  106.0  119.5  110.5  18  15  10  43
  88.3  92.8  96.8  13  11  8  10
  96.0  103.3  100.5  7  15  11  27
  94.3  94.5  99.0  10  12  11  19
  106.5  121.5  110.5  18  17  10  42
  106.5  115.5  107.0  8  13  14  47
  92.0  99.5  103.5  18  16  8  18
  102.0  99.8  103.3  13  12  14  28
  108.3  122.3  108.5  15  19  12  41
  106.8  119.0  106.8  14  20  12  37
  102.5  109.3  103.8  9  17  13  32
  92.5  102.5  99.3  13  15  6  23
  102.8  113.8  106.8  17  20  10  32
  83.3  87.3  96.3  1  5  9  15
  94.8  101.8  99.8  7  16  11  24
  103.5  112.0  110.8  18  13  12  37
  89.5  96.0  97.3  7  15  11  14
  84.3  89.8  94.3  8  8  8  9
  104.3  109.5  106.5  14  12  12  36
  106.0  118.5  105.0  12  16  11  39
  ;
  run;
proc cancorr data = sales out = canout vprefix=sales vname="Sales Variables"
						  wprefix=scores wname="Test Scores";
var growth profit new;
with create mech abs math;
run;
/* plot the first canonical variate pair! */
/* v=J f=special specifices closed circles to plot data points*/
/* specifies a regression line be included in the plot */

proc gplot;
axis1 length=3 in;
axis2 length=4.5in;
plot sales1*scores1 /vaxis=axis1 haxis=axis2;
symbol v=J f=special h=2 i=r color=black;
run;
TITLE 'CANONICAL CORRELATION PLOT OF VARIATE PAIRS 2';
proc gplot;
axis1 length=3 in;
axis2 length=4.5in;
plot sales2*scores2 /vaxis=axis1 haxis=axis2;
symbol v=J f=special h=2 i=r color=black;
run;
/* CANONICAL CORRELATION PLOT OF VARIATE PAIRS 3 */
TITLE 'CANONICAL CORRELATION PLOT OF VARIATE PAIRS 3';
proc gplot;
axis1 length=3 in;
axis2 length=4.5in;
plot sales3*scores3 /vaxis=axis1 haxis=axis2;
symbol v=J f=special h=2 i=r color=black;
run;




OPTIONS NOCENTER;
proc format; /*  Give reasonable labels to the various species  */
   value specname
      1='SETOSA    '
      2='VERSICOLOR'
      3='VIRGINICA ';
   value specchar
      1='S'
      2='O'
      3='V';
RUN;

DATA iris;  
title 'MANOVA of Fisher (1936) Iris Data';
input sepallen sepalwid petallen petalwid species @@;
format species specname.;
   label sepallen='Sepal Length in mm.'
         sepalwid='Sepal Width  in mm.'
         petallen='Petal Length in mm.'
         petalwid='Petal Width  in mm.';
datalines;
50 33 14 02 1 64 28 56 22 3 65 28 46 15 2 67 31 56 24 3
63 28 51 15 3 46 34 14 03 1 69 31 51 23 3 62 22 45 15 2
59 32 48 18 2 46 36 10 02 1 61 30 46 14 2 60 27 51 16 2
65 30 52 20 3 56 25 39 11 2 65 30 55 18 3 58 27 51 19 3
68 32 59 23 3 51 33 17 05 1 57 28 45 13 2 62 34 54 23 3
77 38 67 22 3 63 33 47 16 2 67 33 57 25 3 76 30 66 21 3
49 25 45 17 3 55 35 13 02 1 67 30 52 23 3 70 32 47 14 2
64 32 45 15 2 61 28 40 13 2 48 31 16 02 1 59 30 51 18 3
55 24 38 11 2 63 25 50 19 3 64 32 53 23 3 52 34 14 02 1
49 36 14 01 1 54 30 45 15 2 79 38 64 20 3 44 32 13 02 1
67 33 57 21 3 50 35 16 06 1 58 26 40 12 2 44 30 13 02 1
77 28 67 20 3 63 27 49 18 3 47 32 16 02 1 55 26 44 12 2
50 23 33 10 2 72 32 60 18 3 48 30 14 03 1 51 38 16 02 1
61 30 49 18 3 48 34 19 02 1 50 30 16 02 1 50 32 12 02 1
61 26 56 14 3 64 28 56 21 3 43 30 11 01 1 58 40 12 02 1
51 38 19 04 1 67 31 44 14 2 62 28 48 18 3 49 30 14 02 1
51 35 14 02 1 56 30 45 15 2 58 27 41 10 2 50 34 16 04 1
46 32 14 02 1 60 29 45 15 2 57 26 35 10 2 57 44 15 04 1
50 36 14 02 1 77 30 61 23 3 63 34 56 24 3 58 27 51 19 3
57 29 42 13 2 72 30 58 16 3 54 34 15 04 1 52 41 15 01 1
71 30 59 21 3 64 31 55 18 3 60 30 48 18 3 63 29 56 18 3
49 24 33 10 2 56 27 42 13 2 57 30 42 12 2 55 42 14 02 1
49 31 15 02 1 77 26 69 23 3 60 22 50 15 3 54 39 17 04 1
66 29 46 13 2 52 27 39 14 2 60 34 45 16 2 50 34 15 02 1
44 29 14 02 1 50 20 35 10 2 55 24 37 10 2 58 27 39 12 2
47 32 13 02 1 46 31 15 02 1 69 32 57 23 3 62 29 43 13 2
74 28 61 19 3 59 30 42 15 2 51 34 15 02 1 50 35 13 03 1
56 28 49 20 3 60 22 40 10 2 73 29 63 18 3 67 25 58 18 3
49 31 15 01 1 67 31 47 15 2 63 23 44 13 2 54 37 15 02 1
56 30 41 13 2 63 25 49 15 2 61 28 47 12 2 64 29 43 13 2
51 25 30 11 2 57 28 41 13 2 65 30 58 22 3 69 31 54 21 3
54 39 13 04 1 51 35 14 03 1 72 36 61 25 3 65 32 51 20 3
61 29 47 14 2 56 29 36 13 2 69 31 49 15 2 64 27 53 19 3
68 30 55 21 3 55 25 40 13 2 48 34 16 02 1 48 30 14 01 1
45 23 13 03 1 57 25 50 20 3 57 38 17 03 1 51 38 15 03 1
55 23 40 13 2 66 30 44 14 2 68 28 48 14 2 54 34 17 02 1
51 37 15 04 1 52 35 15 02 1 58 28 51 24 3 67 30 50 17 2
63 33 60 25 3 53 37 15 02 1
;

/* iris data using MANOVA with canonical correlation to support */
PROC GLM data = iris;
class species;
model sepallen sepalwid petallen petalwid = species;
manova h = species/canonical;
run;
quit;

