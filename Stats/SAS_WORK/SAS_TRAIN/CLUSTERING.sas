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
id= _n_;
run;

title 'Hierarchical Clustering With Complete Method';
proc cluster method=complete outtree=clust1 data=cars2 rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;

proc cluster method=ward outtree=clust1 data=cars2 rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;

proc cluster method=centroid outtree=clust1 data=cars2 rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;

proc cluster method=single outtree=clust1 data=cars2 rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;

proc cluster method=average outtree=clust1 data=cars2 rmsstd pseudo ccc;
  var  mpg cyl disp hp drat wt qsec vs am gear carb;
	id id;
  run;

title 'Dendrogram for Optimal Clusters';
proc tree horizontal nclusters=3 data = clust1 out=clust2;
  id id;
  run;

proc sort data = cars2;
by id;
run;

proc sort data = clust2;
by id;
run;

data combine;
  merge cars2 clust2;
  by id;
  run;

proc glm data=combine;
  class cluster;
  model mpg cyl disp hp drat wt qsec vs am gear carb = cluster;
/* get cluster means */
	means cluster;
  run;
  quit;

proc sort data = combine;
by cluster;
run; 

proc print data = combine;
run;
/* optimal clustering looks like 3 according to pseudo F and t squared */
/* mpg, hp, weight, disp, drat, vs, am, gear, cylinder are significant across clusters at alpha of .05/11 = 0.004 */
/* cluster 1 is described as mpg cars, low horsepower, low cylinder cars made up of honda civics, fiats, toyota corollas */
/* cluster 2 is our middle of the road category with purely automaic transmissions, 
	defined by high cylinder, middle of the road horsepower (150), mercedes 450s, dodge chargers and hornets make up this category */
/* cluster 3 is the high performance category with extreme horsepower, high cylinder, low MPG cars, defined by the maserati */
/* interestingly, the ferrari is grouped into group 1, likely because of its lower weight */



/* clustering in SAS using complete method */
data wood;
input x y acerub carcar carcor cargla cercan corflo faggra frapen
        ileopa liqsty lirtul maggra magvir morrub nyssyl osmame ostvir 
        oxyarb pingla pintae pruser quealb quehem quenig quemic queshu quevir 
        symtin ulmala araspi cyrrac;
ident= _n_;
/* need to identify each observation in clustering procs, no unique key so created one based on
observation number _n_ */
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
drop acerub carcor cargla cercan frapen lirtul magvir morrub osmame pintae
       pruser quealb quehem queshu quevir ulmala araspi cyrrac;
run;
/* always sort by key before running proc cluster or proc fastclust */
proc sort;
  by ident;
run;
/* proc cluster uses euclidean distance and by default does agglomerative (each obs a cluster)
clustering 
method identifies the algorithm method for separating clusters using distances - single, complete
average, centroid, ward */
title 'Agglomerative Clustering with Complete Method';
proc cluster method=complete outtree=clust1 data=wood rmsstd pseudo ccc;
/* can also use method = density */
/* use dendrogram to determine # of clusters across different methods to determine
optimal number of clusters*/
  var carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
      pingla quenig quemic symtin;
/*must specify id, also created an out data set called clust1 */
	id ident;
  run;
/* create tree and save out data into clust2 */
proc tree horizontal nclusters=6 data = clust1 out=clust2;
  id ident;
  run;
proc sort;
  by ident;
  run;
data combine;
  merge wood clust2;
  by ident;
  run;

/* control for experiment wise error rate using bonferroni adjusted p where 0.05/p */
proc glm;
  class cluster;
  model carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
        pingla quenig quemic symtin = cluster;
/* get cluster means */
	means cluster;
  run;
  quit;

  /* using ward's method */
proc cluster method=ward data = wood outtree=clust3;
  var carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
      pingla quenig quemic symtin;
  id ident;
  run;
proc tree horizontal nclusters=6 data = clust3 out=clust4;
  id ident;
  run;
proc print;
  run;
data combine;
  merge wood clust2;
  by ident;
  run;
proc glm;
  class cluster;
  model carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
        pingla quenig quemic symtin = cluster;
  means cluster;
  run;

data dist(type=distance);
input object1-object5 name $;
cards;
0 . . . . object1
9	0 . . . object2
3	7	0 . . object3
6	5	9	0 . object4
11	10	2	8	0 object5
;
run;

title 'Single Link';
proc cluster data=dist method=single nonorm rmsstd rsquare simple;
id name;
run;

/* create a dendrogram */
proc tree horizontal spaces=2;
id name;
run;

title 'Complete Link';
proc cluster data=dist method=complete nonorm;
id name;
run;
proc tree horizontal spaces=2;
id name;
run;

title 'Average Link';
proc cluster data=dist method=average nonorm;
id name;
run;
proc tree horizontal spaces=2;
id name;
run;

title 'Centroid Link';
proc cluster data=dist method=centroid nonorm;
id name;
run;
proc tree horizontal spaces=2;
id name;
run;

title 'Ward’s Method';
proc cluster data=dist method=ward nonorm;
id name;
run;
proc tree horizontal spaces=2;
id name;
run;

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

proc cluster simple method = centroid rsquare rmsstd nonorm;
id cid;
var income educ;
run;

/* in class example */

title '1991 City Data Using Wards Method';
data cities;
input city $ work price salary @@;
cards;
Amsterdam	1714	65.6	49.0 Athens	1792	53.8	30.4
Bogota	2152	37.9	11.5 Bombay	2052	30.3	5.3
Brussels	1708	73.8	50.5 Buenos_Aires	1971	56.1	12.5
Caracas	2041	61.0	10.9 Chicago	1924	73.9	61.9
Copenhagen	1717	91.3	62.9 Dublin	1759	76.0	41.4
Dusseldorf	1693	78.5	60.2 Frankfurt	1650	74.5	60.4
Geneva	1880	95.9	90.3 Helsinki	1667	113.6	66.6
Hong_Kong	2375	63.8	27.8 Houston	1978	71.9	46.3
Johannesburg	1945	51.1	24.0 Kuala_Lumpur	2167	43.5	9.9
Lagos	1786	45.2	2.7 Lisbon	1742	56.2	18.8
London	1737	84.2	46.2 Los_Angeles	2068	79.8	65.2
Luxembourg	1768	71.1	71.1 Madrid	1710	93.8	50.0
Manila	2268	40.0	4.0 Mexico_City	1944	49.8	5.7 
Milan	1773	82.0	53.3 Montreal	1827	72.7	56.3
Nairobi	1958	45.0	5.8 New_York	1942	83.3	65.8
Nicosia	1825	47.9	28.3 Oslo	1583	115.5	63.7
Panama	2078	49.2	13.8 Paris	1744	81.6	45.9
Rio_de_Janeiro	1749	46.3	10.5 Sao_Paulo	1856	48.9	11.1
Seoul	1842	58.3	32.7 Singpore	2042	64.4	16.1
Stockholm	1805	111.3	39.2 Sydney	1668	70.8	52.1
Taipei	2145	84.3	34.5 Tel_Aviv	2015	67.3	27.0
Tokyo	1880	115.0	68.0 Toronto	1888	70.2	58.2
Vienna	1780	78.0	51.3 Zurich	1868	100.0	100.0
;
run;
/* proc print data=cities; run; */

PROC DISTANCE DATA=cities OUT=distcity;
  VAR INTERVAL (work price salary);
   id  city;
RUN;
proc cluster data=distcity method=ward rmsstd pseudo ccc;
id city;
run;

proc cluster data=cities method=ward rmsstd pseudo ccc;
var work price salary;
id city;
run;

proc tree horizontal spaces=2;
id city;
run;

*SAS Example #3 - K-means with Cities;
proc fastclus data=cities maxc=3 maxiter=1000 out=clus list;
var work price salary; 
run;

proc sort data=clus;
by cluster;
run;

proc print data=clus;
var city cluster;
run;

