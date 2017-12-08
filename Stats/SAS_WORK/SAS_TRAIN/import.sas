PROC IMPORT OUT= WORK.TEST2 
            DATAFILE= "\\Client\C$\Users\patrickcorynichols\Desktop\ex12
17.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
