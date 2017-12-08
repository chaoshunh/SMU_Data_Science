/* PROJECT 3 - CARS CLUSTERING - HIERARCHICAL APPROACH - WILL DO PARTITIONING LATER */
data cars;
input model $ mpg cyl disp hp drat wt qsec vs am gear carb;
datalines;
MazdaRX4	21	6	160	110	3.9	2.62	16.46	0	1	4	4
MazdaRX4Wag	21	6	160	110	3.9	2.875	17.02	0	1	4	4
Datsun710	22.8	4	108	93	3.85	2.32	18.61	1	1	4	1
Hornet4Drive	21.4	6	258	110	3.08	3.215	19.44	1	0	3	1
HornetSportabout	18.7	8	360	175	3.15	3.44	17.02	0	0	3	2
Valiant	18.1	6	225	105	2.76	3.46	20.22	1	0	3	1
Duster360	14.3	8	360	245	3.21	3.57	15.84	0	0	3	4
Merc240D	24.4	4	146.7	62	3.69	3.19	20	1	0	4	2
Merc230	22.8	4	140.8	95	3.92	3.15	22.9	1	0	4	2
Merc280	19.2	6	167.6	123	3.92	3.44	18.3	1	0	4	4
Merc280C	17.8	6	167.6	123	3.92	3.44	18.9	1	0	4	4
Merc450SE	16.4	8	275.8	180	3.07	4.07	17.4	0	0	3	3
Merc450SL	17.3	8	275.8	180	3.07	3.73	17.6	0	0	3	3
Merc450SLC	15.2	8	275.8	180	3.07	3.78	18	0	0	3	3
CadillacFleetwood	10.4	8	472	205	2.93	5.25	17.98	0	0	3	4
LincolnContinental	10.4	8	460	215	3	5.424	17.82	0	0	3	4
ChryslerImperial	14.7	8	440	230	3.23	5.345	17.42	0	0	3	4
Fiat128	32.4	4	78.7	66	4.08	2.2	19.47	1	1	4	1
HondaCivic	30.4	4	75.7	52	4.93	1.615	18.52	1	1	4	2
ToyotaCorolla	33.9	4	71.1	65	4.22	1.835	19.9	1	1	4	1
ToyotaCorona	21.5	4	120.1	97	3.7	2.465	20.01	1	0	3	1
DodgeChallenger	15.5	8	318	150	2.76	3.52	16.87	0	0	3	2
AMCJavelin	15.2	8	304	150	3.15	3.435	17.3	0	0	3	2
CamaroZ28	13.3	8	350	245	3.73	3.84	15.41	0	0	3	4
PontiacFirebird	19.2	8	400	175	3.08	3.845	17.05	0	0	3	2
FiatX1-9	27.3	4	79	66	4.08	1.935	18.9	1	1	4	1
Porsche914-2	26	4	120.3	91	4.43	2.14	16.7	0	1	5	2
LotusEuropa	30.4	4	95.1	113	3.77	1.513	16.9	1	1	5	2
FordPanteraL	15.8	8	351	264	4.22	3.17	14.5	0	1	5	4
FerrariDino	19.7	6	145	175	3.62	2.77	15.5	0	1	5	6
MaseratiBora	15	8	301	335	3.54	3.57	14.6	0	1	5	8
Volvo142E	21.4	4	121	109	4.11	2.78	18.6	1	1	4	2
;
run;
data cars2;
set cars;
id= TRIM('R'||_n_);
run;

/* normalize variables with mean = 0 and std =1 */
PROC STANDARD data = cars2 out=stddata
MEAN = 0
STD = 1;
VAR mpg cyl disp hp drat wt qsec vs am gear carb;
RUN;

/* latent clustering as part of two stage clustering - NOT covered in class */
proc varclus data=stddata maxclusters=3;
      var mpg cyl disp hp drat wt qsec vs am gear carb;
   run;
/* COMPLETE */
title 'Hierarchical Clustering On Standardized Vars With Complete Method';
proc cluster method=complete outtree=clust1 data=stddata std rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;
/* WARD'S */
title 'Hierarchical Clustering On Standardized Vars With WARD Method';
proc cluster method=ward outtree=clust1 data=stddata std rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;
/* CENTROID */
title 'Hierarchical Clustering On Standardized Vars With CENTROID Method';
proc cluster method=centroid outtree=clust1 data=stddata std rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;
/* SINGLE */
title 'Hierarchical Clustering On Standardized Vars With SINGLE Method';
proc cluster method=single outtree=clust1 data=stddata std rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;
/* AVERAGE */
title 'Hierarchical Clustering On Standardized Vars With AVERAGE Method';
proc cluster method=average outtree=clust1 data=stddata std rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;
/* optimal clusters according to hierarchical methods is about 3 */
title 'Dendrogram for Optimal Clusters';
proc tree horizontal nclusters=3 data = clust1 out=clust2;
  id id;
  run;

proc sort data = stddata;
by id;
run;

proc sort data = clust2;
by id;
run;
/* combine data for variable hypothesis testing */
data combine;
  merge stddata clust2;
  by id;
  run;
/* test it out */
proc glm data=combine;
  class cluster;
  model mpg cyl disp hp drat wt qsec vs am gear carb = cluster;
  means cluster;
  run;
  quit;

proc sort data = combine;
by cluster;
run; 

/* optimal clustering looks like 3 according to pseudo F, eigenvalues for each eigenvector and t squared */
/* mpg, hp, weight, disp, drat, vs, am, gear, cylinder are significant across clusters at alpha of .05/11 = 0.004 */
/* cluster 1 is described as mpg cars, low horsepower, low cylinder cars made up of honda civics, fiats, toyota corollas */
/* cluster 2 is our middle of the road category with purely automaic transmissions, 
	defined by high cylinder, middle of the road horsepower (150), mercedes 450s, dodge chargers and hornets make up this category */
/* cluster 3 is the high performance category with extreme horsepower, high cylinder, low MPG cars, defined by the maserati */
/* interestingly, the ferrari is grouped into group 1, likely because of its lower weight */

/* NOW TO PARTITIONING: K-MEANS */
title 'Four Clusters';
proc fastclus maxclusters=4 replace=random maxiter=100 list distance data = stddata;
  var mpg cyl disp hp drat wt qsec vs am gear carb;
  id id;
  run;
title 'Three Clusters';
proc fastclus maxclusters=3 replace=random maxiter=100 list distance data = stddata out=clusters summary;
  var mpg cyl disp hp drat wt qsec vs am gear carb;
  id id;
  run;
/* set up for plots */
proc candisc out=can data=clusters;
var mpg cyl disp hp drat wt qsec vs am gear carb;
class cluster;

title 'THREE CLUSTER SCATTERPLOT BY CLUSTER ID';
proc sgplot data=can;
scatter y=can2 x=can1/group=cluster;
run;

PROC MEANS data=cars2 mean min max range stddev;
VAR disp;
run;

/* based on runs with 3, 4, 5 clusters, three clusters indicates most usefulness */
/* Pseudo F is highest with 3 clusters, however R squared is slightly smaller than with four clusters */
/* However, we are interested in striking a balance between too many and too few for cluster description */
/* R squared influenced by # of clusters as well, not only measure we should rely on */
/* Therefore, we will choose 3 clusters */
/* distance between cluster centroids is between 111 and 215, using 150 as a conservative point to group */
/* instead of randomly assigning clusters, we will use the leader algorithm to identify true center points to
  tighten data analysis */

proc fastclus maxclusters=3 radius=150 maxiter=100 list distance data = cars2;
  var mpg cyl disp hp drat wt qsec vs am gear carb;
  id id;
  run;

  /* kmeans method relatively similar to results from hierarchical under average and complete methodologies */
  /* high mileage, cluster1, middle of the road cluster 2, high performance cluster 3 */
  /* can use r2 values to calculate F statistics for each variable */
/* F = (r2/(K-1))/((1-r2)/(n-K))   d.f. = K-1,n-K */
/* Bonferroni corrects for tests' experiment wise error rate at alpha/p variables  */
/* e.g. if 13 variables @ 5% alpha then .05/13 = 0.004 */
/* calculate individual F's to determine what are significant under k-means */
