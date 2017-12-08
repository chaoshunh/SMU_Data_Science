/* start up analysis of repeated measures */ 

/* ONE WAY CRD */

data simpleCRD;
input time score @@;
datalines;
1 30 1 14 1 24 1 38 1 26
2 28 2 18 2 20 2 34 2 28
3 34 3 22 3 39 3 44 3 30
;
RUN;

proc print data = simpleCRD; run;

/* assumes time is not a repeated measure, assume factor with 3 results */
/* this is a simple ONE WAY ANOVA */
PROC GLM data = simpleCRD;
CLASS time;
model score = time;
RUN;
QUIT;

/* repeated measures design is kind of like a blocked design */
/* partition to sum of squares in block */
/* sum of squares for a block, sum of squares for residual */
/* ANOVA table is between samples, with error = blocks + residuals */
/* Assumptions: univariate repeated measures analysis, treat each subject as a block w/three measures*/
/* Must have independence, multivariate normality, sphericity */
/* Sphericity = symmetry / uniformity, equality of population variances for all treatments */
/* Equality of population covariances as well */
/* co variance measure of variability between one time and next */
/* all must be equivalent */
/* spehericity only requires that VARIANCES are equal, relaxes assumption */
/* use mauchly's test by testing error covariance matrix of the orthonormalized transformed
dependent variables is proportional to an identity matrix - variances are equivalent*/
/* if test is significant, can adjust via epsilon based on d.f. */
/* epsilon estimate extene to which covariance matrix deviates from sphericitiyy */
/* if epsilon = 1, conidition is met, if epsilon = k -1, indicates worst possible violation */
/* epsilon adjusts d.f. to a F test d.f. k-1 and (n-1)(k-1) = e(k-1) and e(k-1)(n-1) */
/* Other epsilon adjustments - greenhouse geiser, huynh feldt epsilon */

/* SAS CODE FOR REPEATED MEASURES */

DATA simpleRM;
input subject time1 time2 time3;
datalines;
1 30 28 34
2 14 18 22
3 24 20 30
4 38 34 44
5 26 28 30
;
run;

PROC GLM data = simpleRM;
model time1 time2 time3 = /nouni; 
/* nouni = no univariate tests. SAS runs three otherwise */
/* univariate ANOVA, one for each level of time */
repeated time 3 / printe;
/* repeated tells SAS that the variables on the LHS of model statement */
/* are repeated measures and not separate variables! */
/* also prints out MANOVA */
RUN;
QUIT;

/* assuming sphericity the univariate test more powerful */
/* multivariate test more powerful when effects small and highly variable */
/* if repeated measures need to analyze as repeated measures*/
/* Multivariate = u1 - u2 = 0 u2 - u3 = 0 u3 - u4 = 0 */
/* create three difference variables on adjacent repeated measures if 4 times (k-1) */
/* observations sequential in time cant compare time 3 to time 3 */
/* test ho if all differences are zero */
/* covariance measures how much two random variables vary together*/
/* covariance matrix has variances on diag and covariance on off diag xi - x yi - y / n*/
/* MANOVA, turn into difference variables and do MANOVA */
/* MANOVA doesnt require sphericity, can estimate co variance matrix */
/* Univariate needs to assume sphericity or adjust d.f. */
/* Univariate treat repeated measures factor as a factor who observations are correlated*/



title1 'Randomized Complete Block With Two Factors'; 
data PainRelief;    
input PainLevel Codeine Acupuncture Relief @@;    
datalines; 
1 1 1 0.0  1 2 1 0.5  1 1 2 0.6  1 2 2 1.2
2 1 1 0.3  2 2 1 0.6  2 1 2 0.7  2 2 2 1.3
3 1 1 0.4  3 2 1 0.8  3 1 2 0.8  3 2 2 1.6
4 1 1 0.4  4 2 1 0.7  4 1 2 0.9  4 2 2 1.5
5 1 1 0.6  5 2 1 1.0  5 1 2 1.5  5 2 2 1.9
6 1 1 0.9  6 2 1 1.4  6 1 2 1.6  6 2 2 2.3
7 1 1 1.0  7 2 1 1.8  7 1 2 1.7  7 2 2 2.1
8 1 1 1.2  8 2 1 1.7  8 1 2 1.6  8 2 2 2.4
;

PROC GLM data = PainRelief;
model time1 time2 time3 = /nouni; 
/* nouni = no univariate tests. SAS runs three otherwise */
/* univariate ANOVA, one for each level of time */
repeated time 3 / printe;
/* repeated tells SAS that the variables on the LHS of model statement */
/* are repeated measures and not separate variables! */
/* also prints out MANOVA */
RUN;
QUIT;

PROC ANOVA data = painrelief;
CLASS painlevel codeine acupuncture;
MODEL Relief = Painlevel  Codeine | Acupuncture;
RUN;

PROC GLM data = painrelief;
CLASS painlevel codeine acupuncture;
MODEL Relief = Painlevel Codeine | Acupuncture;
RUN; 
QUIT;

