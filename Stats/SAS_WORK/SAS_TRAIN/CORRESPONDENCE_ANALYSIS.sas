/* Correspondance Analysis */

title 'United States Population, 1920-1970';
data USPop;
   * Regions:
   * New England     - ME, NH, VT, MA, RI, CT.
   * Great Lakes     - OH, IN, IL, MI, WI.
   * South Atlantic  - DE, MD, DC, VA, WV, NC, SC, GA, FL.
   * Mountain        - MT, ID, WY, CO, NM, AZ, UT, NV.
   * Pacific         - WA, OR, CA.
   *
   * Note: Multiply data values by 1000 to get populations.;

   input Region $14. y1920 y1930 y1940 y1950 y1960 y1970;
   label y1920 = '1920'    y1930 = '1930'    y1940 = '1940'
         y1950 = '1950'    y1960 = '1960'    y1970 = '1970';
   if region = 'Hawaii' or region = 'Alaska'
      then w = -1000;       /* Flag Supplementary Observations */
      else w =  1000;
   datalines;
New England        7401  8166  8437  9314 10509 11842
NY, NJ, PA        22261 26261 27539 30146 34168 37199
Great Lakes       21476 25297 26626 30399 36225 40252
Midwest           12544 13297 13517 14061 15394 16319
South Atlantic    13990 15794 17823 21182 25972 30671
KY, TN, AL, MS     8893  9887 10778 11447 12050 12803
AR, LA, OK, TX    10242 12177 13065 14538 16951 19321
Mountain           3336  3702  4150  5075  6855  8282
Pacific            5567  8195  9733 14486 20339 25454
Alaska               55    59    73   129   226   300
Hawaii              256   368   423   500   633   769
;

ods graphics on;
* Perform Simple Correspondence Analysis;
proc corresp data=uspop print=percent observed cellchi2 rp cp
     short outc=Coor plot(flip);
   var y1920 -- y1970;
   id Region;
   weight w;
run;
ods graphics off;

/* Data for unaided eye tests on 7477 women, aged 30-39. The right eye and corresponding left eye were graded on the basis of “best”, “Second”, “third” and “worst”. Table entries are the frequencies of women in each left-right eye grade combination. For example, there are 117 women with “Best” scores on their left eyes and “third” scores on their right eyes. */

title 'Eye Grades';
data vision ; 
input Right $ High Second Third Worst;
datalines;
High 1520 266 124 66
Second 234 1512 432 78
Third 117 362 1772 205
Worst 36 82 179 492
;
/* proc print data=vision; run; */
* Perform Simple Correspondence Analysis;
ODS graphics on;
proc corresp data=vision print=percent observed cellchi2 rp cp
     short outc=Coor plot;
   var High Second Third Worst;
   id Right;
run;
ODS graphics off;

data PhD;
   input Science $ 1-19 y1973-y1978;
   label y1973 = '1973'
         y1974 = '1974'
         y1975 = '1975'
         y1976 = '1976'
         y1977 = '1977'
         y1978 = '1978';
   datalines;
Life Sciences       4489 4303 4402 4350 4266 4361
Physical Sciences   4101 3800 3749 3572 3410 3234
Social Sciences     3354 3286 3344 3278 3137 3008
Behavioral Sciences 2444 2587 2749 2878 2960 3049
Engineering         3338 3144 2959 2791 2641 2432
Mathematics         1222 1196 1149 1003  959  959
;
ods graphics on;
* Perform Simple Correspondence Analysis;
proc corresp data=PhD print=percent observed cellchi2 rp cp
     short outc=Coor plot(flip);
   var y1973--y1978;
   id Science;
run;

ods graphics off;
