options ls=80 ps=60;

data vote;
   input year  dpctvt dpctseat   rpctvt  rpctseat;
label Dpctvt = 'Dem Pct of all votes'
      Dpctseat='Democratic Pct of Seats in House'
      Rpctvt = 'Republican Pct of all votes'
      Rpctseat='Republican Pct of Seats in House';

ldpctvt = log(dpctvt);
label ldpctvt = 'Ln of Dem Pct of all votes';

cards;
1896 43.3           37.6                46.7          57.9
1898 46.7           45.7                45.7          51.8
1900 44.7           43.0                51.2          55.6
1902 46.7           46.2                49.3          53.8
1904 41.7           35.2                53.8          64.5
1906 44.2           42.5                50.7          57.5
1908 46.1           44.0                49.7          56.0
1912 45.3           66.7                34.0          41.4
1914 43.1           53.5                42.6          44.7
1916 46.3           48.3                48.4          49.7
1918 43.1           43.9                52.5          54.5
1920 35.8           30.5                58.6          69.3
1922 44.7           47.6                51.7          51.7
1924 40.4           42.1                55.5          56.6
1926 40.5           44.8                57.0          54.5
1928 42.4           37.8                56.5          61.9
1930 44.6           49.7                52.6          50.1
1932 54.5           72.0                41.4          26.9
1934 53.9           74.0                42.0          23.7
1936 55.8           76.6                39.6          20.5
1938 48.6           60.2                47.0          38.9
1940 51.3           61.4                45.6          37.2
1942 46.1           51.0                50.6          48.0
1944 50.6           55.9                47.2          43.7
1946 44.2           43.2                53.5          56.6
1948 51.9           60.5                45.5          39.3
1950 49.0           53.8                49.0          45.7
1952 49.7           49.0                49.3          50.8
1954 52.5           53.3                47.0          46.7
1956 51.1           53.8                48.7          46.2
1958 56.3           64.8                42.1          32.2
1960 54.2           60.2                45.4          39.8
1962 52.3           59.3                47.4          40.5
1964 57.4           67.8                42.1          32.2
1966 50.9           57.0                48.2          43.0
1968 50.2           55.9                48.5          44.1
1970 53.4           58.6                45.1          41.4
1972 51.7           55.9                46.4          44.1
1974 97.6           66.9                40.6          33.1
1976 56.2           67.1                42.1          32.9
1978 53.4           63.7                44.7          36.3
1980 50.4           55.9                48.0          44.1
1982 55.6           61.8                42.9          38.2
1984 52.1           58.2                47.0          41.8
1986 54.5           59.3                44.6          40.7
1988 53.3           59.8                45.5          40.2
1990 52.9           61.4                45.0          38.4
1992 50.8           59.3                45.6          40.5
;
proc print; run;
proc timeplot;
 plot dpctseat;
 id year;
run;

proc arima; identify var=dpctseat nlag=20;
  estimate p=1 plot printall;
title8 'AR1 model';
run;
proc arima; identify var=dpctseat nlag=20;
  estimate q = 2 plot printall;
title8 'MA(2) model';
run;


proc arima; identify var=dpctseat nlag=20;
  estimate p = 1 q = 2 plot printall;
title8 'MA(2) model';
run;
