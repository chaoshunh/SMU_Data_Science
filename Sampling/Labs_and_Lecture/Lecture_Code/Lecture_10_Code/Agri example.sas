/*Sampling: Design and Analysis, 2nd ed. by S. Lohr 
   Copyright 2008 by Sharon Lohr */

filename agsrs 'C:\Users\Mahesh\Desktop\agsrs.csv';


data agsrs;
   infile agsrs delimiter= ','  firstobs = 2;
   input county $ state $ acres92 acres87 ;
   sampwt = 3078/300; /* sampling weight is same for each observation */
   txy=964470625*acres92;* total estimate of y from ratio estimation;
   mxy=313343.283*acres92;* mean estimate of y from ratio estimation;
run;

   /* We want to do ratio estimation this time. Let's look
      at the correlation between acres92 and acres87 */
proc corr data = agsrs;
   var acres92 acres87;
   run;

proc gplot data = agsrs;
   plot acres92 * acres87;
run;

 /* proc surveymeans will estimate ratios with keyword 'ratio'  */

 /* Note that the estimated means and totals of acres87 and acres92
    do not use ratio estimation, however---these are calculated
    using SRS formulas */
 
proc surveymeans data=agsrs total=3078 mean stderr clm sum clsum ;
   var acres92 acres87;  /* need both in var statement */
   ratio 'acres92/acres87' acres92/acres87;
   weight sampwt;
   ods output Statistics=statsout Ratio=ratioout;
   run;
  
proc print data = ratioout;
run;
/* Can get ratio estimates of means by taking output from 
   proc surveymeans and multiplying by Xbar=313343.283 */
   data ratioout1;
   set ratioout;
   Xbar = 313343.283;
   ratiomean = ratio*xbar;
   semean = stderr*xbar;
   lowercls = lowercl*xbar;
   uppercls = uppercl*xbar;
   run;

proc print data = ratioout1;
run;
/* with mxy variable to get mean estimate of y from ratio estimation;*/
proc surveymeans data=agsrs total=3078 mean stderr clm sum clsum  ;
   var acres92 acres87;  /* need both in var statement */
   ratio  mxy/acres87;
   weight sampwt;
   ods output Statistics=statsout Ratio=ratioout3;
   run;
proc print data = ratioout3;
run;

data ratioout2;
   set ratioout;
   xtotal = 964470625;
   ratiosum = ratio*xtotal;
   sesum = stderr*xtotal;
   lowercls = lowercl*xtotal;
   uppercls = uppercl*xtotal;
   run;

proc print data = ratioout2;
run;
/* with txy variable to get total estimate of y from ratio estimation;*/
proc surveymeans data=agsrs total=3078 mean stderr clm sum clsum  ;
   var acres92 acres87;  /* need both in var statement */
   ratio  txy/acres87;
   weight sampwt;
   ods output Statistics=statsout Ratio=ratioout4;
   run;
proc print data = ratioout4;
run;
