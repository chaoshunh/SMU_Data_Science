/* calculate total of worm parts */
data worms;
/* nested loop to build data set */
do case = 1 to 12;
do can = 1 to 3;
input worms @@;
wt = (580/12)*(24/3);
output;
end;
end;
cards;
1 5 7
4 2 4
0 1 2
3 6 6
4 9 8
0 7 3
5 5 1
3 0 2
7 3 5
3 1 4
4 7 9
0 0 0
;

proc surveymeans data = worms total = 580 sum clsum;
weight wt;
cluster case;
var worms;
run;
