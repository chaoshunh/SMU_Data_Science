data email;
*note stratum 1 is Fridays and stratum 2 is nonFridays);
* creating sample of size 200--not very imaginative or diverse;
do i = 1 to 25;
stratumid = 2 ;	psuid=1;	ssuid=i;	cat='a';	wt1=8;	wt2=8;	output; 
stratumid = 2 ;	psuid=1;	ssuid=25+i;	cat='a';	wt1=8;	wt2=8;	output;
stratumid = 2 ;	psuid=2;	ssuid=i;	cat='a';	wt1=8;	wt2=10;	output;
stratumid = 2 ;	psuid=2;	ssuid=25+i;	cat='d';	wt1=8;	wt2=10; output;
stratumid = 1 ;	psuid=1;	ssuid=i;	cat='a';	wt1=2;	wt2=4;	output;
stratumid = 1 ;	psuid=1;	ssuid=25+i;	cat='b';	wt1=2;	wt2=4;	output;
stratumid = 1 ;	psuid=2;	ssuid=i;	cat='a';	wt1=2;	wt2=5;	output;
stratumid = 1 ;	psuid=2;	ssuid=25+i;	cat='c';	wt1=2;	wt2=5;	output;
end;
drop i;
run;
*calculating base weights;
data email;
set email;
basewt = wt1*wt2;
basewt = wt1*wt2;
;
/*
proc print data = email ;
run;*/

*analysis without accounting for fpc;
proc surveymeans data = email ;
title 'analysis of stratified cluster design without fpc';
class cat;
strata stratumid;
cluster psuid;
weight basewt;
var cat;
run;

*analysis after accounting for fpc. Note there are 4 fridays and 16 non-Fridays in month;
data strsizes;
stratumid = 1;  _total_=4;   output;
stratumid = 2; _total_ = 16; output;
;
proc surveymeans data = email total = strsizes;
title 'analysis of stratified cluster design with fpc';
class cat;
strata stratumid;
cluster psuid;
weight basewt;
var cat;
run;

/*Look what happens to standard errors if there was no clustering,
i.e. if 100 emails chosen at random from Friday emails;
Note we must first change what the stratum sizes are--they are no longer days in month, 
but emails;*/

data strsizes;
stratumid = 1;  _total_=900;   output;
stratumid = 2; _total_ = 7200; output;
;
proc surveymeans data = email total = strsizes;
title 'analysis as if it was NOT a two-stage design'; 
strata stratumid;
weight basewt;
var cat;
run;
