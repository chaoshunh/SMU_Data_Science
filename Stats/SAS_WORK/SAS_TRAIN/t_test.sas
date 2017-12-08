PROC IMPORT OUT = CREATIVITY (rename=(VAR1=GROUP VAR2=SCORE))
			DATAFILE = '\\Client\C$\Users\patrickcorynichols\Desktop\Data Science\Stats\Data Sets\Creativity.txt'
			DBMS = TAB REPLACE;
			GETNAMES = NO;
RUN;

PROC TTEST DATA = CREATIVITY sides = u ALPHA = 0.01;
	CLASS GROUP; 
	VAR SCORE;
	Title 'Two Sample T Test';
RUN;

proc boxplot data=CREATIVITY;
plot Score*Group;
TITLE 'BOX PLOT OF CREATIVITY SCORES IN EACH GROUP';
run;


proc univariate data=Creativity;
	class group;
	histogram;
	TITLE 'Comparative Histograms of Creativity Scores';
   run;
