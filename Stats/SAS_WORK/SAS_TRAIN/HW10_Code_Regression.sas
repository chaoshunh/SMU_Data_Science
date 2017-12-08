data birds;
infile '\\Client\C$\Users\PatrickCoryNichols\Desktop\ex0727.csv' FIRSTOBS = 2 DLM = ',';
INPUT mass tcell;
logtcell = log(tcell);
logmass = log(mass);
RUN;

data steer(replace = yes);
infile '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Stats\Data Sets\sleuth3csv\case0702.csv' FIRSTOBS = 2 DLM = ',';
INPUT time ph;
logtime = log(time);
RUN;

data island(replace = yes);
infile '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Stats\Data Sets\sleuth3csv\case0801.csv' FIRSTOBS = 2 DLM = ',';
INPUT area species;
logarea = log(area);
logspecies = log(species);
RUN;
QUIT;

data volt(replace = yes);
infile '\\Client\C$\Users\PatrickCoryNichols\Desktop\Data Science\Stats\Data Sets\sleuth3csv\case0802.csv' FIRSTOBS = 2 DLM = ',';
INPUT time voltage group $;
logtime = log(time);
logvoltage = log(voltage);
RUN;
QUIT;
/* back transform entire result because y is transformed*/
PROC REG data = volt;
model logtime = voltage / clb clm;
RUN;
QUIT;
/* input data into model in ln form because x is transformed */
PROC REG data = steer;
model ph = logtime / clb clm;
RUN;
QUIT;
/* in this case we have logged both values, combine two previous methods, take exp() of y result and input x as 
natural log */
PROC REG data = island;
MODEL logspecies = logarea /clb clm;
RUN;

PROC PRINT data = birds;
RUN;

PROC GPLOT data = birds;
PLOT tcell*mass;
SYMBOL1 V = Dot C = BLACK I= RL L =1;
RUN;
QUIT;

PROC REG data = birds;
MODEL tcell = mass /clb clm cli;
RUN;
QUIT;

PROC means data = birds;
RUN;


PROC PRINT data = steer;
run;

PROC MEANS data = island;
run;
