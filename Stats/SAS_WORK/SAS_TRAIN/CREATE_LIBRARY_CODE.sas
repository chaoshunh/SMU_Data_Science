LIBNAME MYLIB2 '\\Client\C$\Users\patrickcorynichols\Desktop\Data Science\SAS\SASDATA_ED2'; run;
PROC MEANS DATA = MYLIB2.SOMEDATA;
run;

PROC IMPORT OUT = TEST2
			DATAFILE = "\\Client\C$\Users\patrickcorynichols\Desktop\Data Science\SAS\SASDATA_ED2\EXAMPLE.xls"
			DBMS = EXCEL REPLACE;
	SHEET = "Database";
	GETNAMES = YES;
RUN;


PROC IMPORT OUT = MYSASLIB.CARS
			DATAFILE = "\\Client\C$\Users\patrickcorynichols\Desktop\Data Science\SAS\SASDATA_ED2\CARSMPG.csv"
			DBMS = CSV;
		GETNAMES = YES;
RUN;

PROC PRINT DATA = MYSASLIB.CARS; 
RUN;

PROC DATASETS;
CONTENTS DATA = SASDATA.SOMEDATA;
RUN;

PROC DATASETS;
CONTENTS DATA = SASDATA._ALL_;
RUN;
