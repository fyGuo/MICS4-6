# through this code we will transfer the dataset in sav form into csv form
# in mics4, we will use household information and women individual level information
# first load the package, foregin package could help us read the sav data
###################################################################
library(foreign)
library(dplyr)
df<-read.spss("D:\\Tang_new pooled model\\data\\Congo DR 2010 MICS_Datasets\\Democratic Republic of Congo_MICS4_Datasets\\Democratic Republic of Congo MICS 2010 SPSS Datasets\\hh.sav",
              to.data.frame = TRUE)

summary(df$PSU)
length(unique(df$PSU))
length(unique(df$HH1))
# here the psu is the same as HH1
dim(df)
df$HH5Y
str(df)
# we will look at some variables we are interested in, please refer to the codebook here
summary(df$HH1)
summary(df$HH2)
table(df$HH1[1:100],df$HH2[1:100])
summary(df$HH6)
summary(df$HH7)
summary(df$HH7B)
summary(df$HH9)
summary(df$HH13)
summary(df$HC1A)
summary(df$HC1C)
summary(df$HHSEX)
dim(df)
# we will not use wealth score here, we will use wealth index quantile
# use the wealth socre here
#df$wscore
hh<-select(df,HH1,HH2,HH6,HH7,HH7B,HH9,HH13,HC1A,HC1C,helevel,HHSEX,windex5)
write.csv(hh,"hhmics4.csv")
#################################################################
# read the wm level information
wm<-read.spss("D:\\Tang_new pooled model\\data\\Congo DR 2010 MICS_Datasets\\Democratic Republic of Congo_MICS4_Datasets\\Democratic Republic of Congo MICS 2010 SPSS Datasets\\wm.sav",
              to.data.frame = TRUE)

dim(wm)
str(wm)
summary(wm$WM1)
summary(wm$WM2)
#interview day

summary(wm$WM6M)
wm$WM6Y
wm$MA1
summary(wm$WM7)
summary(wm$WB1Y)
summary(wm$WAGE)
summary(wm$WAGEM)
summary(wm$welevel)
summary(wm$WB4)
summary(wm$CM8)
summary(wm$CM12Y)
summary(wm$CM12M)
summary(wm$CM13)
length(wm$CM12M)-3810
summary(wm$MN1)
length(wm$MN1)-8426
summary(wm$MN2A)
summary(wm$MN2B)
summary(wm$MN2D)
summary(wm$MN18)
summary(wm$MN3)
summary(wm$CM10)
# save the selected variables
wm<-select(wm,WM1,WM2,WM6M,WM6Y,WM7,WB1Y,WAGE,WAGEM,welevel,WB4,
           CM10,CM8,CM12Y,CM12M,CM13,MN1,MN2A,MN2B,MN2D,MN17A,MN17B,MN17D,MN18,MN3,MA1,wmweight)
write.csv(wm,"wmmics4.csv")
