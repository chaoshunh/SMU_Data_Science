/* linear discriminant analysis for insect data */
/* obtain a classification rule for identifying the group */
data insect;
input species $ j1 j2 a;
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
run;

data testset;
	input j1 j2 a;
	datalines;
	194 124 49
	;
run;

/* prior probabilities - in this case we do not identify any, as we are not aware of a more populous species */
/* p1 = p2 = 1/2 */
/* pool = test tests for homogeneity of variance covariance matrices */
proc discrim data = insect pool=test crossvalidate testdata=testset testout=testdataset;
class species;
var j1 j2 a;
run;

proc print;
run;

/* result is test data set gets classified into species b */
/* linear discriminant function has log .5 added to it to get linear score function */
/* if uneven priors, log of the ratio needs to be added to the appropriate group, could change result! */
/* we are 95% sure that the observation belongs in species B using posterior probabilities */

proc discrim data = insect pool=test crossvalidate testdata=testset testout=testdataset;
class species;
var j1 j2 a;
priors "a"=0.99 "b"=0.01;
run;

proc print;
run;
