
# install the package to read the sav file into the R

library(foreign) 
library(dplyr)# we need to load the package everytime before we use the 
#function

## The main aim of this file is help you know the data and know the question
# we will use. Therefore, just play with the data here.

## household information
df<-read.spss("D:\\Tang_new pooled model\\data\\Congo, Democratic Republic of 2001 MICS_Datasets\\Congo, Democratic Republic of 2001 MICS_Datasets\\HHdc.sav",to.data.frame = T
)

# dim shows you the basic information for how many rows and how many cols
dim(df)              

# str shows you the colnames
str(df)

# WLTHIND5 is the only wealth index 5 quantiles
df$WLTHIND5
# HI2 is the household number
summary(df$HI2)
# HI!3# is the address information
summary(df$HI1A)
summary(df$HI1B)
summary(df$HI1C)
summary(df$HI1D)
summary(df$HI1E)
# HI3Y is the surveyed year
summary(df$HI3Y)

#
summary(df$HI6)
summary(df$HI7)
summary(df$HI11)
# EDUC is the education level of household head
summary(df$EDUC)
# HL33 is the sex of houeshold head
summary(df$HL33)
# AGEREC is the age of the household head
summary(df$AGEREC)
# Using select, we just select cols we are interested in
hh<-select(df,HI1A,HI1B,HI1C,HI1D,HI1E,HI3Y,HI6,HI7,HI2,HI11,EDUC,HL33,AGEREC,
           WLTHSCOR,WLTHIND5)

# here you can see the new hh, just try str or dim or head(hh)
# we write the new file in a new name for next load
write.csv(hh,"hhmics2.csv")
##############################################
## household member information
df<-read.spss("D:\\Tang_new pooled model\\data\\Congo, Democratic Republic of 2001 MICS_Datasets\\Congo, Democratic Republic of 2001 MICS_Datasets\\Hldc.sav",to.data.frame = T
)

dim(df)
str(df)
summary(df$HI)
############################
# women information
# similar process as before
df<-read.spss("D:\\Tang_new pooled model\\data\\Congo, Democratic Republic of 2001 MICS_Datasets\\Congo, Democratic Republic of 2001 MICS_Datasets\\WMdc.sav",to.data.frame = T
)
str(df)
table(df$CM7)
sum(df$WMWEIGHT)
summary(df$WMWEIGHT)
str(df)
length(df$WMWEIGHT)
sum(!is.na(df$MN2A))
sum(!is.na(df$MN2B))
#surveyed year
df$WI3AY
# year of first child
df$CM2AY
df$CM7
# same as above
summary(df$HI2)
summary(df$MN2A)
summary(df$MN2B)
summary(df$MN2C)
summary(df$MN2)
# maternal education level
summary(df$MELEVEL)
# number of deadkids
summary(df$DEADKIDS)
# number of live kids
summary(df$CEB)
# women's age
summary(df$WAGE)
# houeshold head sex
summary(df$HL33)
summary(df$WLTHIND5)
table(df$MSTATUS)
wm<-select(df,HI2,HI1A,HI1B,HI1C,HI1D,HI1E,WI3AY,CM2AY,CM7,MN2A,MN2B,MN2C,MELEVEL,
           DEADKIDS,CEB,WAGE,MSTATUS,CM11Y,WMWEIGHT,MN3A,MN3B,MN3C,CM7)
write.csv(wm,"wmmics2.csv")
