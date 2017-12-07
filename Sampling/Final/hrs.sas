PROC EXPORT DATA= TMP1.hrs_analysis 
            OUTFILE= "C:\MSDS 6370 FALL2016\Final exam\hrs.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;
