/* this is an example of an odds analysis */ 

   proc format;
      value ExpFmt 1='Light Drinker'
                   0= 'Heavy Drinker';
      value RspFmt 1= 'Cases'
                   0= 'Controls';
   run;
/* 0 0 386 = Heavy Drinker Control 386 observations */

   data cancer;
      input Exposure Response Count;
      label Response='Breast Cancer';
      datalines;
   0 0 386
   0 1 204
   1 0 658
   1 1 330
   ;

   proc sort data=cancer;
      by descending Exposure descending Response;
   run;
/* set up odds ratio calculations */
     proc freq data=cancer order=data;
      format Exposure ExpFmt. Response RspFmt.;
      tables Exposure*Response / chisq relrisk;
      exact pchi or;
      weight Count;
      title 'Case-Control Study of Alcohol and Breast Cancer';
   run;
