options ls=78;
title ' Example: Nutrient Intake Data Descriptive Statistics';

data nutrient;
	infile '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Classes\Stats\Data Sets\nutrient.txt';
	input id calcium iron protein a c;
	run;

proc means data = nutrient;
 var calcium iron protein a c;
 run;

 proc corr pearson cov;
 	var calcium iron protein a c;
	run;

/* calculate generalized variance */

proc iml;
  start genvar;
    one=j(nrow(x),1,1);
    ident=i(nrow(x));
    s=x`*(ident-one*one`/nrow(x))*x/(nrow(x)-1.0);
    genvar=det(s);
    print s genvar;
  finish;
  use nutrient;
  read all var{calcium iron protein a c} into x;
  run genvar;

  PROC UNIVARIATE data = nutrient;
  var calcium;
  histogram;
  run;

  PROC SGSCATTER data = nutrient;
  plot calcium*iron;
  run;
/* square root, quarter root, log, inverse transforms */
  data nutrienttrans;
  set nutrient;
  logcalc = log(calcium);
  logiron = log(iron);
  logprotein = log(protein);
  loga = log(a);
  logc = log(c);
  run;

  proc sgscatter data = nutrienttrans;
  plot logcalc*logiron;
  run;

  proc sgscatter data = nutrienttrans;
	matrix logcalc logiron logprotein loga logc;
	run;

options ls=78;
title "Bivariate Normal Density";
%let r=0.5;
data a;
  pi=3.1416;
  do x1=-4 to 4 by 0.1;
    do x2=-4 to 4 by 0.1;
      phi=exp(-(x1*x1-2*&r*x1*x2+x2*x2)/2/(1-&r*&r))/2/pi/sqrt(1-&r*&r);
      output;
    end;
  end;
  run;
proc g3d;
  plot x1*x2=phi / rotate=-60;
  run;
