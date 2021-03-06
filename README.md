# MICS4-6
This is the R code for research in MICS4 MICS6
# Data
## Map data
*DRC_coord.csv* provided map data we needed to draw map, you can open it in stata using *DRC_coordinates.dta*.  
*DRC_map_id.csv* provided the correspondence relationship for regions and ID in *DRC_coord.csv*.  
## MICS data
*Congo DR 2010 MICS_Datasets.zip* is the MICS4 data.  
*MICS6_data.zip* is the MICS6 data.  
# Preprocess data 
## Preprocess MICS4 data
We used preprocess **mics4.R** to read the household and women individual data in mics4, and save them into *hhmics4.csv* and *wmmics4.csv* respectively.  
Then we used **merge mics4.R** to merge *hhmics4.csv* and *wmmics4.csv* into *merg_mics4.csv*.  
## Preprocess MICS6 data
We used **merge mics6.R** to merge household and women individual data in mics6, and save the merged data in *merge_mics6.csv*.  
## Merge MICS4 and MICS6 data
We used **merge4_6.R** to merge *merge_mics4.csv* and *merge_mics6.csv* into the final merge data *merge4_6.csv*. 
# Make the Demographic table
We used **table 1.R** to make the demographic table. 
# Prepare data for SAS
We used **prepare for SAS macro_general.R** to make SAS files and to run SAS. 
# Draw maps
1. We used **anc_province_year.txt** to compute adjusted prevalence of antenatal care in each province in SAS, and we got *ANCp_province_year.csv*.  
2. We used **dvp_province_year.txt** to compute adjusted prevalence of antenatal care in each province in SAS, and we got *ANCp_province_year.csv*.  
3. Using *ANCp_province_year.csv* and *ANCp_province_year.csv* we could run **ANCp_province_year.R** and **dvp_map_byprovince.R** to get two maps.   
**The change of adjusted coverage of Antenatal care in the DRC from 2010 to 2018**
![](Figures/map_anc.png)
**The change of adjusted coverage skilled birth attendance in the DRC from 2010 to 2018**
![](Figures/map_dvp.png)
# Draw changes in different wealth groups in three regions
## For Kasai region
1. we used **anc_kasai_wealth.txt** to compute adjusted prevalence of antenatal care in each wealth groups in Kasai in SAS and we got *anc_kasai_wealth.csv*.  
2. we used **dvp_kasai_wealth.txt** to compute adjusted prevalence of antenatal care in each wealth groups in Kasai in SAS and we got *dvp_kasai_wealth.csv*.   
## For Kivu region
1. we used **anc_kivu_wealth.txt** to compute adjusted prevalence of antenatal care in each wealth groups in Kivu in SAS and we got *anc_kivu_wealth.csv*.   
2. we used **dvp_kivu_wealth.txt** to compute adjusted prevalence of antenatal care in each wealth groups in Kivu in SAS and we got *dvp_kivu_wealth.csv*.   
## For Other provinces
1. we used **anc_other_wealth.txt** to compute adjusted prevalence of antenatal care in each wealth groups in other provinces in SAS and we got *anc_other_wealth.csv*.  
2. we used **dvp_other_wealth.txt** to compute adjusted prevalence of antenatal care in each wealth groups in other provinces in SAS and we got *dvp_other_wealth.csv*.  
## Draw the figure
1. We used all the csv files in this section to run  **figure_change_wealth_group.R** to draw the figure.  
**The trends of adjusted coverage of Antenatal care and skilled birth attendance for women with different wealth status from 2010 to 2018**
![](Figures/wealth_change.png)

# Subgroups analysis on urban and rural
1. We used **anc_urban_province_year.txt** to compute the adjusted prevalence of antenatal care in each provinces and in rural/urban, and we got *anc_urban_province_year.csv*.  
2. We used **dvp_urban_province_year.txt** to compute the adjusted prevalence of antenatal care in each provinces and in rural/urban, and we got *dvo_urban_province_year.csv*.  
3. These two csv files were supplementray section2. 
