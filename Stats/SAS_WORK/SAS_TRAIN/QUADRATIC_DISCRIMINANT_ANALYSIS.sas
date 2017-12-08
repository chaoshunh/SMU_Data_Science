options ls=78;
title "Discriminant - Swiss Bank Notes";
data real;
  infile "D:\Statistics\STAT 505\data\swiss1.txt";
  input length left right bottom top diag;
  type="real";
  run;
data fake;
  infile "D:\Statistics\STAT 505\data\swiss2.txt";
  input length left right bottom top diag;
  type="fake";
  run;
/* combine the two data sets */
data combine;
  set real fake;
  run;
/* set up observation to classify */
data test;
  input length left right bottom top diag;
  cards;
214.9 130.1 129.9 9 10.6 140.5
;
  run;

/* can use pool = yes to force LDA or pool = no to force QDA */
/* pool=test allows SAS to choose LDA or QDA, QDA does NOT print function */
/* crossvalidate performs leave one out crossvalidation to classify data set */
/* testdata identifies the test data set to classify, testout=a creates a data
set with the result of the classification */
/* class identifies the classification groups, var the quant variables*/
/* priors identifies bayesian prior probabilities to help classify appropriately*/
proc discrim data=combine pool=test crossvalidate testdata=test testout=a;
  class type;
  var length left right bottom top diag;
  priors "real"=0.99 "fake"=0.01;
  run;
proc print;
  run;
