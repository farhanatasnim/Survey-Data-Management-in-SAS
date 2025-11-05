
******************************************************************
*****************EPI_600_FINAL_PROJECT****************************;

libname epiquiz "C:\Users\farha\OneDrive\Desktop\Epi_quiz_600";

**********UPLOADING ALL THE DATASETS*********************;
 
data recode;
set epiquiz.quiz_recode;
run;

proc contents data=recode; run;

*  DAtA SET NAME: RECODE                                Observations: 4529
     Member Type: DATA                                  Variables: 84;


proc import 
out = quiz_survey_p1
datafile = "C:\Users\farha\OneDrive\Desktop\Epi_quiz_600\quiz_survey_3_p1.csv"
dbms = csv replace; run;

proc contents data=quiz_survey_p1; run;

* DAtA SET NAME: QUIZ_SURVEY_P1                          Observations: 3654
  Member Type: DATA                                      Variables: 26;


proc import 
out = quiz_survey_p2
datafile = "C:\Users\farha\OneDrive\Desktop\Epi_quiz_600\quiz_survey_3_p2.xlsx"
dbms = xlsx replace; run;

proc contents data=quiz_survey_p2; run;

* DAtA SET NAME: QUIZ_SURVEY_P2                           Observations: 875
    Member Type: DATA                                     Variables: 16;


proc import 
out = quiz_survey_p3
datafile = "C:\Users\farha\OneDrive\Desktop\Epi_quiz_600\quiz_survey_3_p3.xlsx"
dbms = xlsx replace; run;

proc contents data=quiz_survey_p3; run;

* DAtA SET NAME: QUIZ_SURVEY_P1                            Observations: 875
    Member Type: DATA                                      Variables: 11;


***************************************************************
*********SORTING AND MERGING ALL 4 DATASETS TO CREATE FINAL_DATA
***************************************************************;

proc sort data= recode; by id; run;

proc sort data= quiz_survey_p1; by id; run;

proc sort data= quiz_survey_p2; by id; run;

proc sort data= quiz_survey_p3; by id; run;

data epiquiz.final_data;
merge recode quiz_survey_p1 quiz_survey_p2 quiz_survey_p3;
by id;
run;

******** DATASET NAME: FINAL DATA   OBSERVATION: 4529 ***************
                                     VARIABLES: 109
********************************************************************;

***********************************************************************
RECODING VARIABLES FOR QUIZ SURVEY #3 FOR MISSING DATA, AS APPROPRIATE. 
THIS INCLUDE RESPONSES SUCH AS 'don’t know' AND ‘not applicable’
************************************************************************;
proc print data=epiquiz.final_data(obs=15); run;

proc freq data=epiquiz.final_data;
table q15a q15b; run;

* RECODING q15a AS edu_male and q15b AS edu_female;

data final_recode;
set epiquiz.final_data;
if q15a = 1 then edu_male = 1;
if q15a = 2 then edu_male = 2;
if q15a = 3 then edu_male = 3;
if q15a = 4 then edu_male = 4;
if q15a = 5 then edu_male = 5;
if q15a = 6 then edu_male = 6;
if q15a = 7 then edu_male = 7;
if q15a = 8 then edu_male = .;
if q15a = . then edu_male = .;

if q15b = 1 then edu_female = 1;
if q15b = 2 then edu_female = 2;
if q15b = 3 then edu_female = 3;
if q15b = 4 then edu_female = 4;
if q15b = 5 then edu_female = 5;
if q15b = 6 then edu_female = 6;
if q15b = 7 then edu_female = 7;
if q15b = 8 then edu_female = .;
if q15b = . then edu_female = .;
run;

* CHECKING THE RECODED VARIABLES;

proc freq data=final_recode;
table q15a*edu_male q15b*edu_female/missing; run;

*CHECKING VARIABLE q19a--q19d;

proc freq data=final_recode;
table q19a--q19d/missing; run;

*********************************
RECODING VARIABLE q19a--q19d
q19a: AS smoke_tobac 
q19b: AS smokeles_tobac
q19c: AS alcohol
q19d: AS marijuana
*******************************;

data final_recode;
 set final_recode;
if q19a=1 then smoke_tobac=0;
if q19a=2 then smoke_tobac=1;
if q19a=3 then smoke_tobac=2;
if q19a=4 then smoke_tobac=3;
if q19a=5 then smoke_tobac=4;
if q19a=6 then smoke_tobac=5;
if q19a=7 then smoke_tobac=6;
if q19a=9 then smoke_tobac=.;
if q19a=. then smoke_tobac=.;

if q19b=1 then smokeles_tobac=0;
if q19b=2 then smokeles_tobac=1;
if q19b=3 then smokeles_tobac=2;
if q19b=4 then smokeles_tobac=3;
if q19b=5 then smokeles_tobac=4;
if q19b=6 then smokeles_tobac=5;
if q19b=7 then smokeles_tobac=6;
if q19b=. then smokeles_tobac=.;

if q19c=1 then alcohol=0;
if q19c=2 then alcohol=1;
if q19c=3 then alcohol=2;
if q19c=4 then alcohol=3;
if q19c=5 then alcohol=4;
if q19c=6 then alcohol=5;
if q19c=7 then alcohol=6;
if q19c=. then alcohol=.;

if q19d=1 then marijuana=0;
if q19d=2 then marijuana=1;
if q19d=3 then marijuana=2;
if q19d=4 then marijuana=3;
if q19d=5 then marijuana=4;
if q19d=6 then marijuana=5;
if q19d=7 then marijuana=6;
if q19d=. then marijuana=.;
run;

*CHECKING THE RECODED VARIABLES;

proc freq data=final_recode;
table q19a*smoke_tobac q19b*smokeles_tobac q19c*alcohol q19d*marijuana/missing; run;

proc freq data=final_recode;
table q21/missing; run;

*CHECKING VARIABLE q22a--q22j;

proc freq data=final_recode;
table q22a--q22j/missing; run;

* RECODING THE VARIABLE q22a--q22j;

data final_recode;
set final_recode;

no_tobac = 0;
if q22a=1 then no_tobac=1;
if (q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999) then no_tobac=.;
if (q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=. & q22j=.) then no_tobac=.;

cam_tobac = 0;
if q22b=1  then cam_tobac=1;
if q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999 then cam_tobac=.;
if q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=.& q22j=. then cam_tobac=.;

res_tobac = 0;
if q22c=1 then res_tobac=1;
if q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999 then res_tobac=.;
if q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=.& q22j=. then res_tobac=.;


fra_tobac = 0;
if q22d=1 then fra_tobac=1;
if q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999 then fra_tobac=.;
if q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=. & q22j=. then fra_tobac=.;


bar_tobac = 0;
if q22e=1 then bar_tobac=1;
if q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999 then bar_tobac=.;
if q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=. & q22j=. then bar_tobac=.;


car_tobac = 0;
if q22f=1 then car_tobac=1;
if q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999 then car_tobac=.;
if q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=. & q22j=. then car_tobac=.;


live_tobac = 0;
if q22g=1 then live_tobac=1;
if q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999 then live_tobac=.;
if q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=. & q22j=. then live_tobac=.;

party_tobac = 0;
if q22h=1 then party_tobac=1;
if q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999 then party_tobac=.;
if q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=. & q22j=. then party_tobac=.;


work_tobac = 0;
if q22i=1 then work_tobac=1;
if q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999 then work_tobac=.;
if q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=. & q22j=. then work_tobac=.;

other_tobac = 0;
if q22j=1 then other_tobac=1;
if q22a=9999 & q22b=9999 & q22c=9999 & q22d=9999 & q22e=9999 & q22f=9999 & q22g=9999 
& q22h=9999 & q22i=9999 & q22j=9999 then other_tobac=.;
if q22a=. & q22b=. & q22c=. & q22d=. & q22e=. & q22f=. & q22g=. 
& q22h=. & q22i=. & q22j=. then other_tobac=.;

run;

* CHECKING THE RECODED VARIABLE;

proc freq data=final_recode;
table no_tobac cam_tobac res_tobac fra_tobac bar_tobac car_tobac live_tobac party_tobac work_tobac other_tobac/missing; run;


*CHECKING VARIABLE Q23;

proc freq data=final_recode;
table q23/missing; run;

*RECODING VARIABLE Q23 AS INDICATOR VARIABLE sex_act;

data final_recode;
 set final_recode;
 if q23=1 then sex_act=0;
 if q23=2 then sex_act=1;
 if q23=. then sex_act=.;
 run;

*CHECKING THE RECODED VARIABLE;

proc freq data=final_recode;
table q23*sex_act/missing;
run;

* CHECKING VARIABLE Q24;

proc freq data=final_recode;
table q24/missing; run;

*RECODING VARIABLE Q24 AS INDICATOR VARIABLE sex_act_12;

data final_recode;
set final_recode;
if q24=1 then sex_act_12=0;
if q24=2 then sex_act_12=1;
if q24=. then sex_act_12=.;
run;

*CHECKING THE RECODED VARIABLE;

proc freq data=final_recode;
table q24*sex_act_12/missing; run;

* CHECKING VARIABLE Q25;

proc freq data=final_recode;
table q25/missing; run;

*RECODING VARIABLE Q25 AS INDICATOR VARIABLE preg_pass_12;

data final_recode;
set final_recode;
if q25=1 then preg_pass_12=.;
if q25=2 then preg_pass_12=1;
if q25=3 then preg_pass_12=0;
if q25=4 then preg_pass_12=.;
if q25=. then preg_pass_12=.;
run;

*CHECKING THE RECODED VARIABLE;

proc freq data=final_recode;
table q25*preg_pass_12/missing;
run;

* CHECKING VARIABLE Q26;

proc freq data=final_recode;
table q26/missing; run;

* RECODING VARIABLE Q26 AS preg_outome;

data final_recode;
set final_recode;
if q26 = 1 then preg_outcome=.;
if q26 = 2 then preg_outcome=2;
if q26 = 3 then preg_outcome=3;
if q26 = 4 then preg_outcome=4;
if q26 = 5 then preg_outcome=5;
if q26 = 6 then preg_outcome=6;
if q26 = 7 then preg_outcome=.;
if q26 = . then preg_outcome=.;
run;

*CHECKING THE RECODED VARIABLE;

proc freq data=final_recode;
table q26*preg_outcome/missing; run;

************************************************
par_college 2 = both parents completed college or more
1 = one parent completed college or more
0 = neither parent completed college
***************************************************;

data final_recode;
set final_recode;
par_college = 0;
if (edu_male=5 | edu_male=6 | edu_male=7 | edu_female=5 | edu_female=6 | edu_female=7) then par_college=1;
if (edu_male=5 | edu_male=6 |edu_male = 7)& (edu_female=5 | edu_female=6 |edu_female = 7) then par_college=2;
if (edu_male=. & edu_female=.) then par_college = .;
run;


proc freq data = final_recode;
table par_college/missing;
run;

*Result : 

                                                            Cumulative    Cumulative
                    par_college    Frequency     Percent     Frequency      Percent
                    -----------------------------------------------------------
                         .           17           0.38          17          0.38
                         0          2046          45.18        2063         45.55
                         1           1960         43.28        4023         88.83 
                         2            506          11.17        4529        100.00 

;

*************************************************************************************
preg_current: Identify participants who are currently pregnant (HINT: think about who
gets pregnant vs. who impregnates)
*************************************************************************************;

data final_recode;
set final_recode;
preg_current = 0;
if (preg_outcome = 6 & female=1)  then preg_current = 1;
if female=0  then preg_current = .;
if female=. then preg_current=.;
if preg_outcome=.  then preg_current = .;
run;

proc freq data=final_recode;
table preg_current/missing; run;


*Result:
 

                                                            Cumulative      Cumulative
                   preg_current    Frequency     Percent    Frequency        Percent
                    ----------------------------------------------------------------
                        .            4341          95.87       4342           95.87 
                        0             138           3.05       4480           98.92 
                        1              50           1.08       4529           100.00 

;


***************************
age_grp: 1 = 18-24 years old
2 = 25-34 years old
3 = 35+ years old
*******************************;
data final_recode;
set final_recode;
if 18<= q2 <25 then age_grp = 1;
if 25<= q2 < 35 then age_grp = 2;
if q2>=35 then age_grp = 3;
if q2 = . then age_grp=.;
run;

proc freq data=final_recode;
table age_grp/missing;
run;

*Result:
 

                                                       Cumulative    Cumulative
                   age_grp    Frequency     Percent     Frequency      Percent
                    -----------------------------------------------------------
                         1      2070         45.71         2070           45.71 
                         2      1756         38.77         3826           84.48 
                         3      703          15.52         4529           100.00 

;

*******************************************************************
gpa_pass: Dichotomize GPA based on a passing GPA of 3.00 and higher
********************************************************************;
proc freq data=final_recode;
table q18/missing; run;

data final_recode;
set final_recode;
gpa_pass=0;
if q18>= 3 then gpa_pass=1;
if q18 = . then gpa_pass=.;
run;

proc freq data=final_recode;
table gpa_pass/missing;
run;

*Result:
 

                                                       Cumulative    Cumulative
                   gpa_pass    Frequency     Percent     Frequency      Percent
                    -----------------------------------------------------------
                         .       4            0.09          4             0.09  
                         0      1062          23.45       1066            23.54
                         1      3463          76.46       4529            100.00 
;

*****************************************************************************
relationship: Collapse cells (i.e., combine response levels) such that no response level
has fewer than 100 observations combine response options that are
conceptually similar. Keep as many of the original response options as
possible, only collapse response options that are similar to each other.

***************************************************************************** ;

data final_recode;
set final_recode;
if q17= 1 then relationship=1;
if q17=2 then relationship=2;
if q17=3 then relationship=3; *Separated, widowed and divorced collapsing together;
if q17=4 then relationship=3; *Separated, widowed and divorced collapsing together;
if q17=5 then relationship=3; *Separated, widowed and divorced collapsing together;
if q17=6 then relationship=4;
if q17 =. then relationship=.;
run;

proc freq data = final_recode;
table relationship/missing;
run;

*Result:
 

                                                            Cumulative    Cumulative
                   relationship    Frequency     Percent     Frequency      Percent
                    -----------------------------------------------------------
                         .           23           0.51          23          0.51
                         1          1764          38.95        1787         39.46
                         2          942           20.80        2729         60.26 
                         3          137            3.02        2866         63.28 
                         4          1663          36.72        4529         100.00 

;

*****************************************************************************
heavy_drink: Identifies participants who reported alcohol consumption that meets
CDC definition of heavy drinking (8 or more drinks per week for women
and 15 or more drinks per week for men)
*************************************************************;

data final_recode;
set final_recode;
heavy_drink = 0;
if (q20>=15 & female=0) then heavy_drink = 1;
if (q20>=8 & female=1) then heavy_drink = 1;
if (q20 = . | female = .) then heavy_drink = .;
run;


proc freq data=final_recode; 
table heavy_drink/missing; 
run;

*Result:
 

                                                           Cumulative    Cumulative
                   heavy_drink    Frequency     Percent     Frequency      Percent
                    -----------------------------------------------------------
                         .          43            0.95          43          0.95
                         0         4355           96.16         4398        97.11
                         1          131            2.89         4529        100.00 

;

******************************************************************************
hr_drink:
2 = any high-risk drinking [heavy drinking, binge drinking (reported
consuming 5 or more drinks in a sitting)]
1 = no high-risk drinking (does not report heavy drinking and binge drinking)
0 = does not drink alcohol (reports ‘I do not drink alcohol’, ignore if they
provided a non-zero response to the number of drinks in a week)
******************************************************************************;

data final_recode;
set final_recode;

if heavy_drink=1 | q21>=3 then hr_drink=2;
if heavy_drink=0 & q21=2 then hr_drink=1;
if q21=1 then hr_drink=0;
if heavy_drink=. &  q21=.  then hr_drink=.;
run;

proc freq data=final_recode;
table hr_drink/missing;
run;


*Result:
 

                                                         Cumulative     Cumulative
                   hr_drink    Frequency     Percent     Frequency      Percent
                    -----------------------------------------------------------
                       .          14           0.31         14           0.31 
                       0         900          19.87         914         20.18 
                       1         2171         47.94         3085        68.12 
                       2         1444         31.88         4529        100.00 

;

***************************************************************
tob_locsum: The number of locations that a participants reported using tobacco
***************************************************************;

data final_recode;
set final_recode;
tob_locsum = sum(cam_tobac, res_tobac, fra_tobac, bar_tobac, 
 car_tobac, live_tobac, party_tobac, work_tobac, other_tobac); 
run;

proc freq data=final_recode;
 table tob_locsum/missing; run;


 *Result:
 

                                                          Cumulative    Cumulative
                   tob_locsum    Frequency     Percent     Frequency      Percent
                    -----------------------------------------------------------
                        .          1081         23.87       1081          23.87 
                        0          1789         39.50       2870          63.37 
                        1          1377         30.40       4247          93.77 
                        2           266          5.87       4513          99.65 
                        3            15          0.33       4528          99.98 
                        4             1          0.02       4529          100.00
;

********************************************************************************
dis_alcohol: Identify participants who reported that they ‘do not drink alcohol’, but
then reported consuming alcohol in the past 30 days or reported an
amount of alcohol consumption that is inconsistent
 *********************************************************************************;

data final_recode;
set final_recode;
dis_alcohol=0;
if q21=1 & (alcohol~=0 | q20 ~=0) then dis_alcohol=1;
if (q21=. | alcohol=. | q20=.) then dis_alcohol=.;
run;

proc freq data=final_recode;
table dis_alcohol/missing;
run;


*Result:
 

                                                            Cumulative     Cumulative
                   dis_alcohol    Frequency     Percent     Frequency      Percent
                    -----------------------------------------------------------
                        .             39          0.86         39           0.86 
                        0             3998       88.28        4037         89.14 
                        1              492       10.86        4529         100.00 

;

*************************************************************************************
dis_tobacco: Identify participants who reported that they ‘do not use tobacco’, but
reported tobacco use in the previous 30 days (do not include marijuana) or
reported a tobacco use location
*************************************************************************************;


 data final_recode;
 set final_recode;
 dis_tobacco=0;
 if (no_tobac=1 & smoke_tobac=>1) then dis_tobacco=1;
 if (no_tobac=1 & smokeles_tobac=>1) then dis_tobacco=1;
 if (no_tobac=1 & tob_locsum=>1) then dis_tobacco=1;
if (no_tobac=. | smoke_tobac=. | smokeles_tobac=. | tob_locsum=.) then dis_tobacco=.;
 run;

proc freq data=final_recode;
 table dis_tobacco/missing;
 run;


 *Result:
 

                                                           Cumulative     Cumulative
                   dis_tobacco    Frequency     Percent    Frequency      Percent
                    -----------------------------------------------------------
                        .          1096         24.20       1096           24.20 
                        0          2258         49.86       3354           74.06
                        1          1175         25.94       4529          100.00 

;

 **********************************************************************************
dis_sexual: Identify participants who reported not ever being sexually active, but
report being sexually active in the past 12 months or being pregnant or
impregnating someone
**************************************************************;

data final_recode;
set final_recode;
dis_sexual=0;
if sex_act=0 & sex_act_12=1 then dis_sexual=1;
if sex_act=0 & preg_pass_12=1 then dis_sexual=1;
if  (sex_act=. | sex_act_12=. | preg_pass_12=.) then dis_sexual=.;
run;

proc freq data=final_recode;
table dis_sexual/missing;
run;


*Result:
 

                                                           Cumulative     Cumulative
                   dis_sexual    Frequency     Percent    Frequency      Percent
                    -----------------------------------------------------------
                       .           975          21.53        975          21.53 
                       0           3528         77.90       4503          99.43
                       1            26           0.57       4529         100.00 
;





*************************************************************************************
dis_sum: The number of inconsistent responses based on the variables created
that identify participants who might have provided responses that are
not reasonable (HINT: don’t forget about the other flags for discordant
responses from previous quizzes and be sure to use the correct ones)
************************************************************************************;

data final_recode;
set final_recode;
dis_sum = sum(dis_sexual, dis_alcohol, dis_tobacco, dis_t2d, dis_hbp, dis_hchol);

run;

proc freq data=final_recode;
table dis_sum/missing;
run;


*Result:
 

                                                       Cumulative     Cumulative
                   dis_sum    Frequency     Percent    Frequency      Percent
                    -----------------------------------------------------------
                      0         2822         62.31       2822          62.31 
                      1         1482         32.72       4304          95.03 
                      2          215          4.75       4519          99.78 
                      3           10          0.22       4529         100.00 

;

data final_recode;
set final_recode;
run;
proc contents data=final_recode varnum; run;

data epiquiz.final_recode;
set final_recode; run;







