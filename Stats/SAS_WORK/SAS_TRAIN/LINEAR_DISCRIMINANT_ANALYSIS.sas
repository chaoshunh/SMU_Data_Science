/* AN EXAMPLE OF LINEAR DISCRIMINANT ANALYSIS */

title "Discriminant Analysis - Insect Data";
data insect;
input species $ joint1 joint2 aedeagus;
datalines;
a 191 131 53
a 185 134 50
a 200 137 52
a 173 127 50
a 171 128 49
a 160 118 47
a 188 134 54
a 186 129 51
a 174 131 52
a 163 115 47
b 186 107 49
b 211 122 49
b 201 144 47
b 242 131 54
b 184 108 43
b 211 118 51
b 217 122 49
b 223 127 51
b 208 125 50
b 199 124 46
;
run;
data test;
input joint1 joint2 aedeagus;
datalines;
194 124 49
205 105 72
;
run;

/* here we identify the priors according to our additional analysis or SME */
/* pooling allows us to test for homogeneity of variance-covariance matrices */
/* crossvalidating tests predictive power and fit */
/* testdata = test classifies the test data */
/* SAS assumes equal priors, hee we assign species a .9 and species b .1*/
proc discrim data=insect pool=test crossvalidate testdata=test testout=a;
class species;
var joint1 joint2 aedeagus;
priors "a"=0.9 "b"=0.1;
run;

proc print;
run;
/* discriminant function will be same if priors or not */
/* what changes is when we try and classify test data */
