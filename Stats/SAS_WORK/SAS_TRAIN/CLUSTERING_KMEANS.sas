/* clustering in SAS using complete method */
data wood;
input x y acerub carcar carcor cargla cercan corflo faggra frapen
        ileopa liqsty lirtul maggra magvir morrub nyssyl osmame ostvir 
        oxyarb pingla pintae pruser quealb quehem quenig quemic queshu quevir 
        symtin ulmala araspi cyrrac;
ident= _n_;
datalines;
 1 1  1  1  1  3  0  1  7  0  9  1  0  8  0  0  0  0 19  3  1  0  0  0  3  4  3  0  0  0  1  0  0
 1 2  0  0  0  0  0  2  3  0 18 13  0  6  0  0  0  0 19  2  2  0  1  0  0  0 10  0  0  0  0  0  0
 1 3  0  7  1  0  0  4  9  1 13 14  0  2  0  2  3  0  7  0  8  0  0  0  0  1 14  0  0  2  0  0  0
 1 4  4 21  1  2  0  7  7  1  2  6  0  1  0  0  3  0 10  1  0  0  0  0  1  0  8  0  0  1  0  2  0
 1 5  1  8  0  2  0  2  4  0  0  0  0  3  0  2  1  0  9  0  0  0  0  0  0  1  6  0  0  0  0  0  0
 1 6  0  3  3  1  0  4 14  2  1 24  0  4  0  0  1  0  4  0  5  0  0  0  1  0  7  0  0  0  0  2  0
 1 7  0  5  3  1  0  3  7  0  0 10  0  3  0  0  0  0 22  0  0  0  0  0  0  0  1  0  0  3  0  0  0
 1 8  3 17 11  1  0  0 13  0  3  5  0  5  0  0  0  0  0  0  0  0  0  0  0  0  3  0  0  0  0  0  0
 2 1  1  0  1  1  0  1  6  0 20 12  0  0  0  0  1  0 18  3  1  0  2  1  1  1  0  0  0  0  0  0  0
 2 2  0  0  0  0  0  3  2  0 28  8  0  0  0  0  2  0 11  1  0  0  0  0  0  0  4  0  0  1  0  0  0
 2 3  0  1  0  0  0  4  6  0 13  1  0  4  0  0  4  0  8  0  0  0  0  0  0  0  0  0  0  0  0  0  0
 2 4  4 14  3  5  0  2  6  0  6  3  0  1  0  0  0  0  0  0  0  0  0  0  0  5 15  0  0  0  0  0  0
 2 5  2 11  2  2  0  2  3  0  4  2  0  5  0  0  1  0  2  0  0  0  0  0  0  3  6  0  0 23  0  0  0
 2 6  0  7  1  1  0  0 15  0  3 15  0  4  0  0  0  0  3  0  2  0  0  0  0  1  6  0  0  1  0  0  0
 2 7  0  7  2  0  0  4 10  0  0  4  0  7  0  1  0  0  2  0  0  0  0  0  0  1  5  0  0  1  0  0  0
 2 8  0  1  0  1  5  9 16 11  5 11  8  4  0  0  2 13  5 15  1  0  2  3  9  8  3  0  0  0  0  0  0
 3 1  0  1  0  0  0  4  9  1 18  3  0  0  0  0  6  1 22  1  0  0  0  0  0  1  4  0  0  4  0  0  0
 3 2  0  0  0  1  0  0  3  0 17  9  0  0  0  0  4  0 20  2  0  0  0  0  0  2  1  0  0 22  0  0  0
 3 3  0  2  0  1  0  3  6  0  7 11  0  1  0  1  0  0  7  0  2  0  0  0  0  1  1  0  0  5  0  3  0
 3 4  0 22  0  2  0  3  4  0 12 13  0  3  0  0  0  0  6  0  1  0  0  0  0  4 17  0  0  3  0  2  0
 3 5  1  6  2  2  0  4  5  0  0 14  0  3  0  1  0  0  3  0  0  0  0  0  0  6  9  0  0  7  0  6  0
 3 6  0  9  0  2  0  0  6  0  3  2  0  5  0  0  0  0  0  0  1  0  0  0  0  3  9  0  0  5  0  0  0
 3 7  0  4  1  0  0  2 13  0  1  3  0  5  0  0  2  0  1  0  1  0  0  0  0  0  8  0  0  1  0  0  0
 3 8  0  2  0  0  0  4 15  0  1  3  0  6  0  0  0  0  3  1  1  0  0  0  0  0  0  1  0  0  0  0  0
 4 1  0  0  1  0  0  4  7  1 10  7  0  2  0  0  3  0 12  1  0  0  0  0  1  0  5  0  0  0  0  0  0
 4 2  0  0  0  0  0  2  4  0  3  2  0  3  0  0  3  0 17  0  1  0  0  0  0  4  5  1  0  4  0  0  0
 4 3  0  0  0  0  0  5  2  0  7 13  0  2  0  0  0  1  5  0 18  1  0  0  1  5  3  0  0 10  0  2  0
 4 4  0  6  0  2  0  1  6  0  9  0  0  6  0  1  1  0  0  0  4  0  0  0  0  0  6  0  0  0  0  0  0
 4 5  0  7  0  0  0  0 22  0  5  1  0  3  0  0  0  0  0  0  0  0  0  0  0  0  6  1  0  1  0  0  0
 4 6  0 16  3  2  0  0 13  0  3 11  0  5  0  1  0  0  0  0  7  0  0  0  0  1 12  0  0 16  0  0  0
 4 7  4 28  0  0  0  0  7  0  1 12  0  5  0  0  2  0  3  0 10  0  0  0  0  1  3  0  0  0  0  0  0
 4 8  1 11  0  0  0  0 14  0  1  4  1  7  0  1  3  0  2  0  2  0  0  0  0  0  4  1  0  0  1  0  0
 5 1  2  0  1  0  0  4 10  0 12  5  1  8  0  0  0  0  7  1  3  0  0  1  0  1  5  0  0  0  0  0  0
 5 2  2  2  4  2  0  4  7  0 12 12  0  6  0  0  0  1 17  2  0  0  1  0  0  1  8  0  0  1  0  0  0
 5 3  0  3  1  0  0  4 10  0 12  7  0  5  0  0  2  0  7  3  1  0  0  0  0  0  7  0  0  5  0  0  0
 5 4  0  9  0  0  0  2  6  0  4  6  0  1  0  0  1  0  6  0  3  0  0  0  0  0  2  0  0  0  0  0  0
 5 5  0  6  2  2  0  2 11  3  5  5  0  7  0  0  2  0  3  0  1  0  0  0  0  0  6  0  0 17  0  0  0
 5 6  2  2  0  1  0  1 13  0 10 13  0  5  0  0  2  0  3  0  6  0  0  0  0  2  8  1  0 19  0  0  0
 5 7  2 27  0  2  0  1  4  1  3 26  0  5  0  0  1  0  9  0  0  0  0  1  0  0  0  1  0  0  1  0  0
 5 8  2 21  1  1  0  0  6  0  1  4  0  5  0  0  1  0  2  0  1  0  0  0  0  5  1  0  0  0  1  0  0
 6 1  0  0  0  0  0  5  8  0  3  0  0  7  0  0  1  0 20  2  5  0  0  0  0  1  4  1  0  0  0  0  0
 6 2  0  0  0  0  0  0 13  0  5  7  0  8  0  0  0  0  8  2  2  0  0  0  0  0  4  1  0  0  0  0  0
 6 3  0  3  0  1  0  2 22  0  6  2  0 12  0  1  2  0 11  2  0  0  0  0  0  1  5  0  0  0  0  0  0
 6 4  0  4  0  0  0  5  9  1  4 10  0  7  0  1  0  0  4  0  2  0  0  0  0  1  2  0  0  0  0  0  0
 6 5  1  5  3  0  0  9 13  0  8 10  0  5  0  0  0  0  2  0  3  0  0  0  0  2  5  1  0  2  0  0  0
 6 6  1 14  3  2  0  5  5  0 11 27  0  1  0  0  0  0  6  0  1  0  0  0  0  0  3  0  0 27  0  0  0
 6 7  2 27  0  0  0  1  3  0  1 11  1  3  0  0  5  0  2  0  1  0  0  0  0  4 10  0  0  3  1  0  0
 6 8  2 28  5  5  0  0  4  0  2  3  0  3  0  0  5  0  2  0  0  0  0  0  0  3  8  0  1  1  3  0  0
 7 1  0  0  0  0  0  1  4  0 16  3  0  2  0  0  0  3 13  6  1  0  0  0  0  0  8  0  0  0  0  0  0
 7 2  3  2  0  1  0  3  8  0  8  6  0  5  0  0  1  2 11  4  5  0  0  0  0  0  1  0  0  1  0  0  0
 7 3  0  1  0  0  0  3 13  0 12  7  0 11  0  0  3  1  7  3  4  0  0  0  0  0  3  0  0  0  0  0  0
 7 4  1 13  0  0  0  3  9  0  3  5  0  6  0  0  2  0  4  1  0  0  0  0  0  0  5  0  0  0  0  0  0
 7 5  0  1  0  0  0  1 15  0  6  2  0  6  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
 7 6  1 14  0  1  0  3  5  0  7  8  0  2  0  0  0  0  2  0  0  0  0  0  0  4  5  0  0  3  0  0  0
 7 7  0 17  0  7  0  2  0  0  9  3  4  0  0  1  1  0  0  0  0  0  0  0  0  7 20  0  0  0  4  0  4
 7 8  2 13  2  3  1  2  2  3 12  2  1  0  0  2  0  0 10  0  3  0  0  0  0  9 11  0  0  0  5  0  0
 8 1  1  0  0  0  0  1 10  0  5  2  0  3  1  0  0  3  4  2  0  0  0  2  0  0  3  0  0  0  0  0  0
 8 2  0  1  0  0  0  0 13  0  8  4  0  6  0  0  2  3  5  4  5  0  0  1  0  0  1  0  0  2  0  0  0
 8 3  3  5  0  1  0  0 11  0 19  8  0  5  0  0  2  0  7  4  3  0  0  0  0  1 11  1  0  0  0  0  0
 8 4  2 23  0  1  0  0  8  0 10 16  0  1  0  0  8  0  0  3  1  0  0  0  0  1 14  0  0  0  0  0  0
 8 5  1 21  0  0  0  0  4  0  1 16  0  5  0  0  2  0  1  0  1  0  0  0  0  5  9  0  1  0  0  0  0
 8 6  0 26  0  1  0  0  5  0  3 18  0  1  0  1  2  0  0  0  2  0  0  0  0  4 10  0  0  0  0  0  0
 8 7  0 20  2  2  0  1  3  1  3  8  2  1  2  1  0  0  5  1 18  0  0  0  0  1 12  0  0  0  1  0  1
 8 8  0  6  4  2  1  5  3  2  9  2  1  1  0  3  1  0 10  1  2  0  0  1  0  0  3  0  0 15  0  0  0
 9 1  5  1  0  2  0  0  8  0 10 10  3  4  1  0  1  5  2  2  7  0  0  3  0  9  2  0  0  2  0  0  0
 9 2  2  2  0  0  0  0  7  0 10  4  1  6  1  0  4  9  4  2  5  0  0  0  0  0  8  0  0  0  0  0  0
 9 3  2  1  0  0  0  0 11  0 14 19  1  3  4  0  4  0  7  7  9  0  0  0  0  6  7  0  0  0  0  0  0
 9 4  0 18  0  0  0  0  7  0  9  7  0  4  0  0 11  1  0  0  0  0  0  0  1  8  6  0  0  0  0  0  0
 9 5  0 17  0  0  0  1  4  0  1  5  0  2  0  0  8  0  1  0  0  0  0  0  0  7 11  0  0  0  0  0  0
 9 6  1 20  2  0  0  1 12  0  6 15  0  3  0  0  0  0  1  0  9  1  0  0  0  0  4  0  0  0  1  0  0
 9 7  0  4  2  0  0  1  5  0  4  6  1  1  0  1  0  0  7  0 20  0  0  0  0  1  6  0  0  0  0  0  0
 9 8  1  4 17  0  0  2  0  1  4 18  0  1  0  0  1  0 16  0  6  0  1  0  1  1  3  0  0 11  0  0  0
;
/* drop these variables, not interested in them */
drop acerub carcor cargla cercan frapen lirtul magvir morrub osmame pintae
       pruser quealb quehem queshu quevir ulmala araspi cyrrac;
run;

/* using partitioning k means, use random approach to find suitable value for radius
  and then use leader algorithm */
  proc sort data = wood;
  by ident;
  run;
title 'K-Means Clustering With Random Selection Of Clusters';
/* replace random indicates we want clusters selected randomly over 100 iterations*/
/* try 3,4,5 clusters */
/* 4 is better than 3 from a max distance from centroid of each cluster and final criterion
5 leaves one cluster with one observation only, does not make sense */
/* pseudo F statistic describes ratio of between cluster variance to w/in cluster var
large F indicates close clusters and good separation */

proc fastclus maxclusters=4 replace=random maxiter=100 list distance ;
  var carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
      pingla quenig quemic symtin;
  id ident;
  run;
/* radius indicated is = 20 based on random cluster centroids */
/* re-do analysis with leader algorithm to identify clusters from previous analysis */
options ls=78;
title "Cluster Analysis - Woodyard Hammock - K-Means";
proc fastclus maxclusters=4 radius=20 maxiter=100 list distance out=clust;
  var carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
      pingla quenig quemic symtin;
  id ident;
  run;

/* can use r2 values to calculate F statistics for each variable */
/* F = (r2/(K-1))/((1-r2)/(n-K))   d.f. = K-1,n-K */
/* Bonferroni correct tests at alpha/p variables  */
/* e.g. if 13 variables @ 5% alpha then .05/13 = 0.004 */
/* if F > 4.90, then the variable is significant */


/* K-Means on small data set */
data t;
input cid $ income educ;
datalines;
c1 5 5
c2 6 6
c3 15 14
c4 16 15
c5 25 20
c6 30 19
;
run;

/* partition clustering example */
/* non hierarchical */
/* must specify # of clusters*/

proc fastclus radius = 0 replace = full maxclusters = 3 maxiter = 20 list distance data=t;
id cid;
var income educ;
run;
