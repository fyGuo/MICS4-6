library(data.table)
hh<-read.csv("hhmics4.csv")
wm<-read.csv("wmmics4.csv")
str(hh)
hh<-hh[,-1]
str(wm)
wm<-wm[,-1]
hh$hID<-paste(hh$HH1,hh$HH2,sep="_")
wm$hID<-paste(wm$WM1,wm$WM2,sep="_")
new<-merge(hh,wm,by="hID")
dim(new)
dim(hh)
dim(wm)
sum(new$HH1!=new$WM1)
sum(new$HH2!=new$WM2)
summary(new$hID)
new<-as.data.table(new)
g<-new[,.(.N),by=.(hID)]
g[order(N),]
# this tells us what the maximum number of households. In other words, how many women living in one 
#household at most
str(new)
table(new$HH7B)
# so we can say we don't need HH7B here
new<-select(new,-HH7B)
str(new)
# we need to rename the HH1
colnames(new)[names(new)=='HH1']<-"cluster"
str(new)
# we will drop the hh2, because we have hID here
new<-select(new,-HH2)
str(new)
dim(new)
# rename the hh6 as the urban
colnames(new)[names(new)=='HH6']<-"urban"
class(new$urban)
table(new$urban)
new$urban[new$urban=="Rural"]<-0
new$urban[new$urban=="Urbain"]<-1
table(new$urban)
new$urban<-factor(new$urban,levels = c(0,1),labels = c("rural","urban"))
table(new$urban)
str(new)
# rename the HH7 as the province
summary(new$HH7)
table(new$HH7)
colnames(new)[names(new)=='HH7']<-"province"
table(new$province)
new$province[new$province=="Bandundu"]<-1
new$province[new$province=="Bas congo"]<-2
new$province[new$province=="Equateur"]<-3
new$province[new$province=="Kasai Occidental"]<-4
new$province[new$province=="Kasai Oriental"]<-5
new$province[new$province=="Katanga"]<-6
new$province[new$province=="Kinshasa"]<-7
new$province[new$province=="Maniema"]<-8
new$province[new$province=="Nord Kivu"]<-9
new$province[new$province=="Province Orientale"]<-10
new$province[new$province=="Sud Kivu"]<-11
table(new$province)
new$province<-factor(new$province,levels = 1:11,
                     labels = c("Bandundu","Bas congo","Equateur",
                                "Kasai Occidental","Kasai Oriental",
                                "Katanga","Kinshasa","Maniema","Nord Kivu",
                                "Province Orientale","Sud Kivu"))
table(new$province)
str(new)
# we will drop HH9
summary(new$HH9)
table(new$HH9)
new<-select(new,-HH9)
str(new)
# we will drop HH13: Number of men 
#age 15-49 years:
        
new<-select(new,-HH13)
str(new)
# HC1A religion belief. drop it because we don't have it in mics2
table(new$HC1A)
new<-select(new,-HC1A)
str(new)
# HC1C Ethnics . drop because we don't have it in mics2
new<-select(new,-HC1C)
str(new)
# factor the helevel
table(new$helevel)
new$helevel[new$helevel=="Missing/DK"]<-NA
table(new$helevel)
new$helevel[new$helevel=="None"]<-1
new$helevel[new$helevel=="Primary"]<-2
new$helevel[new$helevel=="Secondary +"]<-3
table(new$helevel)
new$helevel<-factor(new$helevel,levels = 1:3,
                    labels =c("below primary","primary","secondary+" ))
table(new$helevel)                    
str(new)
# windex 5
table(new$windex5)
new$windex5[new$windex5=="Poorest"]<-1
new$windex5[new$windex5=="Second"]<-2
new$windex5[new$windex5=="Middle"]<-3
new$windex5[new$windex5=="Fourth"]<-4
new$windex5[new$windex5=="Richest"]<-5
table(new$windex5)
new$windex5<-factor(new$windex5,levels = 1:5,
                    labels = c("poorest","poor","middle","wealth",
                               "wealthest"))
table(new$windex5)
str(new)
# household head sex
colnames(new)[names(new)=='HHSEX']<-"hhsex"
str(new)
table(new$hhsex)
new$hhsex[new$hhsex=="Female"]<-0
new$hhsex[new$hhsex=="Male"]<-1
table(new$hhsex)
new$hhsex<-factor(new$hhsex,levels = 0:1,labels = c("female","male"))
str(new)
# Wm1 and WM2 are cluster number and the household number we drop them
new<-select(new,-WM1,-WM2)
str(new)
# WM6M :the interview month  Wm6Y the interview year==2010
new$WM6Y<-rep(2010,times=dim(new)[1])
summary(new$WM6Y)
colnames(new)[names(new)=="WM6Y"]<-"year"
str(new)
# Wm7 is the resuls of the women's interview
table(new$WM7)
#only keep those completed the interivew
new<-new[new$WM7=="Rempli"]
table(new$WM7)
new<-select(new,-WM7)
str(new)
# WB1Y is the birth year
new$WB1Y<-as.numeric(new$WB1Y)
summary(new$WB1Y)
# so you can see NA here now let us not treat this here
# marriage
table(new$MA1)
colnames(new)[names(new)=='MA1']<-"marital"
new$marital[new$marital=="Oui, actuellement mariée"]<-1
new$marital[new$marital=="Oui, vit avec un homme"]<-2
new$marital[new$marital=="Non, pas en union"]<-3
table(new$marital)
new$marital<-factor(new$marital,levels = 1:3,
                labels=c("married","living with a partner","single"))
table(new$marital)
###
str(new)
table(new$WAGE)
colnames(new)[names(new)=='WAGE']<-"wmage"
table(new$wmage)
new$wmage[new$wmage=="15-19"]<-1
new$wmage[new$wmage=="20-24"]<-2
new$wmage[new$wmage=="25-29"]<-3
new$wmage[new$wmage=="30-34"]<-4
new$wmage[new$wmage=="35-39"]<-5
new$wmage[new$wmage=="40-44"]<-6
new$wmage[new$wmage=="45-49"]<-7
table(new$wmage)
new$wmage<-factor(new$wmage,levels = 1:7,
                  labels = c("15-19","20-24",
                             "25-29","30-34",
                             "35-39","40-44",
                             "45-49"))

table(new$wmage)
summary(new$wmage)
length(new$wmage)
summary(new$WB1Y)
length(new$WB1Y)
# so it is a little confusing here wmage with no missin value, but wb1y has
str(new)
# WAGEM is of no use just drop it
new<-select(new,-WAGEM)
str(new)
#welevel  and WB4 education level of women
table(new$welevel,new$WB4)
table(new$welevel)
table(new$WB4)
sum(is.na(new$WB4))
# so we use welevel and not wb4
new<-new[new$welevel!="Missing/DK"]
dim(new)
new$welevel[new$welevel=="None"]<-1
new$welevel[new$welevel=="Primary"]<-2
new$welevel[new$welevel=="Secondary +"]<-3
table(new$welevel)
new$welevel<-factor(new$welevel,levels = 1:3, 
                    labels = c("below primary","primary","secondary+"))
str(new)
new<-select(new,-WB4)
# CM10 totlal live births
colnames(new)[names(new)=='CM10']<-"livebirths"
str(new)
# CM8 HAVE YOU EVER GIVEN BIRTH TO A BOY OR GIRL WHO WAS BORN ALIVE BUT LATER DIED?
table(new$CM8)
colnames(new)[names(new)=='CM8']<-"deadchild"
new$deadchild[new$deadchild=="Non"]<-0
new$deadchild[new$deadchild=="Oui"]<-1
table(new$deadchild)
new$deadchild<-factor(new$deadchild,levels = 0:1,
                      labels = c("No","Yes"))
str(new)
# CM 12 last birth year
summary(new$MN1)
sum(!is.na(new$MN1))
sum(!is.na(new$MN3))
table(new$MN3)
table(new$CM12Y)
# we only use thos who gave birth in the last year before 2010
#table(new$MN1,new$CM12Y)
#new<-new[new$CM12Y==2009|CM12Y==2010]
#dim(new)
#str(new)
#new$CM12M<-as.numeric(new$CM12M)
#table(new$CM12M)
#length(new$CM12M)
#sum(is.na(new$CM12M))
#table(new$CM12M[new$CM12Y==2009],new$WM6M[new$CM12Y==2009])
#length(which(new$CM12Y==2009&(new$WM6M>new$CM12M)))
#ind<-which(new$CM12Y==2009&(new$WM6M>new$CM12M))
#new<-new[-ind,]
#dim(new)
#str(new)
# MN1 ever been ANC
# MN2A ANC by doctor, MN2B ANC by nurse ,MN2D ANC by midwife
# MN18 delivery place
table(new$MN18)
# MN3 ANC times
write.csv(new,"merge_mics4.csv")
