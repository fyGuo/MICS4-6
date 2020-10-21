---
title: "Maternal health behavior in the DRC"
author: "Fuyu Guo"
date: "October 20, 2020"
output:
  slidy_presentation:
          theme: flatly
          keep_md: yes
subtitle: UNCIEF MICS data
---

<style type="text/css">

.center {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 50%;
}




tr:nth-child(even){background-color: #f2f2f2}

th {
  font-family:Arial;
  width:200px;
  background-color: white;
  color: grey;
  font-size: 30pt
}

td{font-size: 14pt}

body{
  width:200px;
  font-size: 24pt;
  color: Darkblue;
}
p{
  font-size: 18pt;
  color: grey;
}
ul {list-style-type: disc;}
li{
  font-size: 18pt;
  color: grey;
}

h2.title {
  font-size: 24px;
  color: Gray;
}
h1 { /* Header 1 */
  font-size: 28px;
  color: Dark;
}
h2 { /* Header 2 */
    font-size: 30px;
  color: Darkblue;
}
h3 { /* Header 3 */
  font-size: 20px;
  font-family: "Times New Roman", Times, serif;
  color: DarkBlue;
}
code.r{ /* Code block */
    font-size: 20px;
}
pre { /* Code block - determines code spacing between lines */
    font-size: 20px;
}
</style>


## MICS: Multiple Indicator Cluster Surveys
 - Aim: Collect and analyzing data in order to fill data gaps for monitoring the situation of children and women
 - Rounds: We used MICS6 in 2017-2018 in the DRC, but there are 6 rounds avaliable on MICS website <http://mics.unicef.org/>. 
 
 <img src="p1.JPG" width="100%" />

## Dataset Structure
MICS is a household survey, it documented two levels information: household and individual.  
It contains several separate datasets in its orginal design  
We used household and individual women datasets. 

 <img src="p2.JPG" width="70%",height = "70%" />
 
  
## Household dataset

- Cluster number and household number
- Survey year and month
- Regions: 26 provinces in the DRC after 2015, but 11 provinces before
- Urban/Rural
- Household head demographic characteristics.  

## Inidividual women dataset

- Cluster number and household number
- Survey year and month
- Demographic characteristics
- Maternal health seeking behavior
- HIV and modern contrceptual

## Inidividual women dataset


```r
library(dplyr)
hh <- read.csv("hhmics4.csv")
head(hh[, c("HH1", "HH2")])
```

```
  HH1 HH2
1   1   1
2   1  11
3   1  21
4   1  30
5   1  40
6   1  50
```

```r
dim(hh)
```

```
[1] 11490    13
```

##


```r
wm <- read.csv("wmmics4.csv")
head(wm[, c("WM1", "WM2")])
```

```
  WM1 WM2
1   1   1
2   1  11
3   1  11
4   1  21
5   1  30
6   1  30
```

```r
dim(wm)
```

```
[1] 13235    27
```

##

```r
hh <- mutate(hh, hID = paste(hh$HH1, hh$HH2, sep="_"))
wm <- mutate(wm, hID = paste(wm$WM1, wm$WM2, sep="_"))
df <- merge(hh, wm, by = "hID")
head(df[, c("hID","HH1","HH2","WM1", "WM2")])
```

```
    hID HH1 HH2 WM1 WM2
1   1_1   1   1   1   1
2  1_11   1  11   1  11
3  1_11   1  11   1  11
4 1_118   1 118   1 118
5 1_127   1 127   1 127
6 1_127   1 127   1 127
```

```r
dim(df)
```

```
[1] 13235    41
```

## Special variable
Below variables are not mentioned in the survey, but are cacluated and provided in the dataset

- welevel: women's highest education level 
- helevel: houshold head's highest education level
- windex5: wealth index5
- wmweight: sampling weight of individual women 

## Project 1 Maternal seeking behavior in MICS6
 We aimed to study maternal seeking behavio (MHSB) in the DRC.  
 MHSB includes:  
 
 - Antenatal care  
 - Delivery care  
 - Postnatal care  
 
 Questions about these tree questions were asked for women who gave live birth in the last two years
 
 <div style="background-color:yellow;"> ***PNC***  definition and questions are questionable</div>


## Project 1 Maternal seeking behavior in MICS6
By conducting a k-modes cluster analysis, we categorized women into three groups:

- Highly-use Group
- Insufficiently-used Group
- Seldom-used Group

<table class=" lightable-classic lightable-striped table" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important;  font-size: 20px; font-family: Arial; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;font-size: 20px;">   </th>
   <th style="text-align:center;font-size: 20px;"> Highly-used Group </th>
   <th style="text-align:center;font-size: 20px;"> Insufficiently-used  Group </th>
   <th style="text-align:center;font-size: 20px;"> Seldom-used 
 group </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;width: 3.5in; "> ANC1 (%) </td>
   <td style="text-align:center;width: 2in; "> 95.4 </td>
   <td style="text-align:center;width: 2in; "> 100.0 </td>
   <td style="text-align:center;width: 2in; "> 37.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 3.5in; "> ANC4 (%) </td>
   <td style="text-align:center;width: 2in; "> 63.0 </td>
   <td style="text-align:center;width: 2in; "> 43.0 </td>
   <td style="text-align:center;width: 2in; "> 11.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 3.5in; "> Institutional delivery (%) </td>
   <td style="text-align:center;width: 2in; "> 92.8 </td>
   <td style="text-align:center;width: 2in; "> 100.0 </td>
   <td style="text-align:center;width: 2in; "> 14.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 3.5in; "> Examine the cord (%) </td>
   <td style="text-align:center;width: 2in; "> 90.5 </td>
   <td style="text-align:center;width: 2in; "> 7.0 </td>
   <td style="text-align:center;width: 2in; "> 7.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 3.5in; "> Examine the temperature (%) </td>
   <td style="text-align:center;width: 2in; "> 59.8 </td>
   <td style="text-align:center;width: 2in; "> 0.7 </td>
   <td style="text-align:center;width: 2in; "> 0.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 3.5in; "> Counsel on breastfeeding (%) </td>
   <td style="text-align:center;width: 2in; "> 69.9 </td>
   <td style="text-align:center;width: 2in; "> 2.6 </td>
   <td style="text-align:center;width: 2in; "> 4.6 </td>
  </tr>
</tbody>
</table>

## Project 1 Maternal seeking behavior in MICS6

<img src="p3.JPG" width="100%" >


## Project 1 Maternal seeking behavior in MICS6

<img src="p4.JPG" width="65%" height = "65%" class = "center" >

## Project 1 Maternal seeking behavior in MICS6

<table class=" lightable-classic lightable-striped table" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important;  font-size: 20px; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;font-weight: bold;font-size: 20px;font-weight: bold;"> Covariates </th>
   <th style="text-align:center;font-weight: bold;font-size: 20px;font-weight: bold;"> Seldom-Used Group versus (Highly-Used Group &amp; Insufficiently-Used Group) </th>
   <th style="text-align:center;font-weight: bold;font-size: 20px;font-weight: bold;"> (Insufficiently-Used Group &amp; Seldom-Used Group) versus Highly-Used Group  </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;font-weight: bold;font-style: italic;color: Darkblue !important;font-weight: bold;width: 0.7in; "> Education level </td>
   <td style="text-align:center;font-weight: bold;font-style: italic;color: Darkblue !important;font-weight: bold;width: 6in; ">  </td>
   <td style="text-align:center;font-weight: bold;font-style: italic;color: Darkblue !important;font-weight: bold;width: 6in; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;width: 0.7in; "> Below Primary </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> Ref </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> Ref </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;width: 0.7in; "> Primary </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 1.36 (1.17-1.57) </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 1.36 (1.17-1.57) </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;width: 0.7in; "> Secondary or higher </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 2.20 (1.84-2.63) </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 1.57 (1.31-1.88) </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;font-style: italic;color: Darkblue !important;font-weight: bold;width: 0.7in; "> Wealth Group </td>
   <td style="text-align:center;font-weight: bold;font-style: italic;color: Darkblue !important;font-weight: bold;width: 6in; ">  </td>
   <td style="text-align:center;font-weight: bold;font-style: italic;color: Darkblue !important;font-weight: bold;width: 6in; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;width: 0.7in; "> Pooresr </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> Ref </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> Ref </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;width: 0.7in; "> Poor </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 1.40 (1.25-1.57) </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 1.40 (1.25-1.57) </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;width: 0.7in; "> Median </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 1.46 (1.26-1.69) </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 1.46 (1.26-1.69) </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;width: 0.7in; "> Wealthy </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 2.10 (1.60-2.75) </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 1.43 (1.54-3.40) </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;width: 0.7in; "> Wealthiest </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 2.28 (1.54-3.40) </td>
   <td style="text-align:center;font-weight: bold;width: 6in; "> 2.28 (1.54-3.40) </td>
  </tr>
</tbody>
<tfoot>
<tr><td style="padding: 0; border: 0;" colspan="100%"><span style="font-style: italic;">Note: </span></td></tr>
<tr><td style="padding: 0; border: 0;" colspan="100%">
<sup></sup> All other demographic variabls are controled </td></tr>
</tfoot>
</table>

## Project 2 Trend for MHSB in the DRC

In the second project, we studied the trend of maternal health service coverage trend from 2010 to 2018 by using MICS4 and MICS6.  
MICS4 and MICS6 had similar sampling and survey structure.  


```r
mics4 <- read.csv("Merged Data\\merge_mics4.csv")
mics6 <- read.csv("Merged Data\\merge_mics6.csv")
table (mics4$province)
```

```

          Bandundu          Bas congo           Equateur   Kasai Occidental 
              1213                994               1106               1147 
    Kasai Oriental            Katanga           Kinshasa            Maniema 
              1114               1244               1482               1101 
         Nord Kivu Province Orientale           Sud Kivu 
              1247               1082               1121 
```

```r
table (mics6$province)
```

```

      Bas Uele       Equateur   Haut Katanga    Haut Lomami      Haut Uele 
           270            288            400            445            256 
         Ituri          Kasai  Kasai Central Kasai Oriental       Kinshasa 
           291            390            370            350            255 
 Kongo Central         Kwango          Kwilu         Lomami        Lualaba 
           263            340            240            396            317 
     Maindombe        Maniema        Mongala      Nord Kivu    Nord Ubangi 
           260            324            306            339            358 
       Sankuru       Sud Kivu     Sud Ubangi     Tanganyika         Tshopo 
           383            389            381            260            352 
       Tshuapa 
           334 
```
## Project 2 Trend for MHSB in the DRC

Most questions could be found in both of two datasets, but the variable name may differ. For an example, has the women received skilled attendance at delivery by a doctor

```r
table(mics4$MN17A)
```

```
## 
##          Manquant  Médecin 
##    12445        2      404
```

```r
table(mics6$MN19A)
```

```
## 
##         A 
## 8086  471
```
## Project 2 Trend for MHSB in the DRC
<img src="https://github.com/fyGuo/MICS4-6/blob/main/Figures/map_anc.png"  />
