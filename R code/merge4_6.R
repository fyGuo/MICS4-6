library(dplyr)
mics4<-read.csv("merge_mics4.csv")
# check the NA in mics4
sapply(mics4,function(x) {is.na(x) %>% sum()})
# you can see there are 8042 NAs in MN1 it is very likely due to
# year
mics4<-mics4[!is.na(mics4$MN1),]
sapply(mics4,function(x) {is.na(x) %>% sum()})
# there are still 575 people MN3 is how many antenatal care times
       
str(mics4)
mics6<-read.csv("merge_mics6.csv")
# check the missing value in mics6
sapply(mics6,function(x) {is.na(x) %>% sum()})
mics6<-mics6[!is.na(mics6$MN2),]
sapply(mics6,function(x) {is.na(x) %>% sum()})

dim(mics4)
dim(mics6)
# the sample size is reasonable


str(mics4)
str(mics6)
# drop HH2 for mics6
mics6<-select(mics6,-HH2)
str(mics4)
# rename the windex
table(mics4$windex5)
table(mics6$windex5)
mics4$windex5<-factor(mics4$windex5,levels =c("poorest","poor","middle","wealth","wealthest"),
                      labels = c("poorest","poor","middle","wealth","wealthest"))
mics6$windex5<-factor(mics6$windex5,levels = c(1,2,3,4,5),
                      labels = c("poorest","poor","middle","wealth","wealthest"))
colnames(mics4)
colnames(mics6)
mics4<-select(mics4,hID,cluster,livebirths,deadchild,marital,
              welevel,MN1,MN2A,MN2B,MN2D,MN17A,MN17B,MN17D,MN18,MN3,
              wmage,windex5,province,urban,helevel,hhsex,year,wmweight)
colnames(mics4)
colnames(mics6)
mics6<-select(mics6,-X)
colnames(mics4)
colnames(mics6)
# birth place MN18 in mics4 but there is no information in mics2
mics4<-select(mics4,-MN18)
colnames(mics4)
colnames(mics6)
# ANC MN1 in mics4 Mn2 in mics6
table(mics4$MN1)
mics4$MN1[mics4$MN1=="Non"]<-0
mics4$MN1[mics4$MN1=="Oui"]<-1
mics4$MN1<-factor(mics4$MN1,levels = 0:1,
                  labels=c("No","Yes"))
colnames(mics4)[names(mics4)=="MN1"]<-"ANC"
table(mics6$MN2)
mics6$MN2[mics6$MN2==2]<-0
mics6$MN2<-factor(mics6$MN2,levels = 0:1,
                  labels=c("No","Yes"))
colnames(mics6)[names(mics6)=="MN2"]<-"ANC"
colnames(mics4)
colnames(mics6)


# professional anc
table(mics4$MN2A)
table(mics4$MN2B)
table(mics4$MN2D)
mics4$ANCp<-0
mics4$ANCp[mics4$MN2A=="Médecin"|mics4$MN2B=="Infirmière"|mics4$MN2D=="Accoucheuse"]<-1
table(mics4$ANCp,mics4$ANC)
mics4$ANCp<-factor(mics4$ANCp,levels = 0:1,
                   labels = c("No","Yes"))
colnames(mics4)[names(mics4)=='MN2A']<-"ANC_doc"
colnames(mics4)[names(mics4)=='MN2B']<-"ANC_nm"
colnames(mics4)[names(mics4)=='MN2D']<-"ANC_am"
table(mics4$ANC_doc)
mics4$ANC_doc[mics4$ANC_doc==""]<-0
mics4$ANC_doc[mics4$ANC_doc=="Médecin"]<-1
table(mics4$ANC_doc)
mics4$ANC_doc<-factor(mics4$ANC_doc,levels = 0:1,
                      labels = c("No","Yes"))
table(mics4$ANC_doc)
table(mics4$ANC_nm)
mics4$ANC_nm[mics4$ANC_nm==""]<-0
mics4$ANC_nm[mics4$ANC_nm=="Infirmière"]<-1
table(mics4$ANC_nm)
mics4$ANC_nm<-factor(mics4$ANC_nm,levels = 0:1,
                     labels = c("No","Yes"))
table(mics4$ANC_nm)

table(mics4$ANC_am)
mics4$ANC_am[mics4$ANC_am==""]<-0
mics4$ANC_am[mics4$ANC_am=="Accoucheuse"]<-1
table(mics4$ANC_am)
mics4$ANC_am<-factor(mics4$ANC_am,levels = 0:1,
                     labels = c("No","Yes"))
table(mics4$ANC_am)
table(mics4$ANCp) %>% prop.table()
# professional delivery care mics4

table(mics4$MN17A)
mics4<-mics4[mics4$MN17A!="Manquant",]
table(mics4$MN17B)
table(mics4$MN17D)
mics4$dvp<-0
mics4$dvp[mics4$MN17A=="Médecin"|mics4$MN17B=="Infirmier/Infirmière"|mics4$MN17D=="Accoucheuse"]<-1
table(mics4$dvp) %>% prop.table()
mics4$dvp<-factor(mics4$dvp,levels = 0:1,
                  labels = c("No","Yes"))
colnames(mics4)[names(mics4)=='MN17A']<-"dv_doc"
colnames(mics4)[names(mics4)=='MN17B']<-"dv_nm"
colnames(mics4)[names(mics4)=='MN17D']<-"dv_am"
table(mics4$dv_doc)
mics4$dv_doc[mics4$dv_doc==""]<-0
mics4$dv_doc[mics4$dv_doc=="Médecin"]<-1
table(mics4$dv_doc)
mics4$dv_doc<-factor(mics4$dv_doc,levels = 0:1,
                     labels = c("No","Yes"))
table(mics4$dv_doc)
table(mics4$dv_nm)
mics4$dv_nm[mics4$dv_nm==""]<-0
mics4$dv_nm[mics4$dv_nm=="Infirmier/Infirmière"]<-1
table(mics4$dv_nm)
mics4$dv_nm<-factor(mics4$dv_nm,levels = 0:1,
                    labels = c("No","Yes"))
table(mics4$dv_nm)

table(mics4$dv_am)
mics4$dv_am[mics4$dv_am==""]<-0
mics4$dv_am[mics4$dv_am=="Accoucheuse"]<-1
table(mics4$dv_am)
mics4$dv_am<-factor(mics4$dv_am,levels = 0:1,
                    labels = c("No","Yes"))
table(mics4$dv_am)


# mics 6
table(mics6$MN3A)
mics6$ANCp<-0
mics6$ANCp[mics6$MN3A=="A"|mics6$MN3C=="C"|mics6$MN3D=="D"]<-1
table(mics6$ANCp)
table(mics6$ANC,mics6$ANCp)
mics6$ANCp<-factor(mics6$ANCp,levels=0:1,
                   labels=c("No","Yes"))

colnames(mics6)[names(mics6)=='MN3A']<-"ANC_doc"
colnames(mics6)[names(mics6)=='MN3C']<-"ANC_nm"
colnames(mics6)[names(mics6)=='MN3D']<-"ANC_am"
table(mics6$ANC_doc)
mics6$ANC_doc[mics6$ANC_doc==""]<-0
mics6$ANC_doc[mics6$ANC_doc=="A"]<-1
table(mics6$ANC_doc)
mics6$ANC_doc<-factor(mics6$ANC_doc,levels = 0:1,
                      labels = c("No","Yes"))
table(mics6$ANC_doc)
table(mics6$ANC_nm)
mics6$ANC_nm[mics6$ANC_nm==""]<-0
mics6$ANC_nm[mics6$ANC_nm=="C"]<-1
table(mics6$ANC_nm)
mics6$ANC_nm<-factor(mics6$ANC_nm,levels = 0:1,
                     labels = c("No","Yes"))
table(mics6$ANC_nm)

table(mics6$ANC_am)
mics6$ANC_am[mics6$ANC_am==""]<-0
mics6$ANC_am[mics6$ANC_am=="D"]<-1
table(mics6$ANC_am)
mics6$ANC_am<-factor(mics6$ANC_am,levels = 0:1,
                     labels = c("No","Yes"))
table(mics6$ANC_am)
#### ANC times
table(mics4$MN3)
class(mics4$MN3)
table(mics6$MN5)
mics4$MN3<-as.numeric(mics4$MN3)
mics4$MN3

table(mics4$MN3)
table(mics6$MN5)
class(mics6$MN5)
mics6$MN5<-as.numeric(mics6$MN5)


######dvp
table(mics6$MN19A)
table(mics6$MN19C)
mics6$dvp<-0
mics6$dvp[mics6$MN19A=="A"|mics6$MN19C=="C"|mics6$MN19D=="D"]<-1
table(mics6$dvp)

mics6$dvp<-factor(mics6$dvp,levels=0:1,
                  labels=c("No","Yes"))
table(mics6$dvp)
colnames(mics6)[names(mics6)=='MN19A']<-"dv_doc"
colnames(mics6)[names(mics6)=='MN19C']<-"dv_nm"
colnames(mics6)[names(mics6)=='MN19D']<-"dv_am"
table(mics6$dv_doc)
mics6$dv_doc[mics6$dv_doc==""]<-0
mics6$dv_doc[mics6$dv_doc=="A"]<-1
table(mics6$dv_doc)
mics6$dv_doc<-factor(mics6$dv_doc,levels = 0:1,
                     labels = c("No","Yes"))
table(mics6$dv_doc)
table(mics6$dv_nm)
mics6$dv_nm[mics6$dv_nm==""]<-0
mics6$dv_nm[mics6$dv_nm=="C"]<-1
table(mics6$dv_nm)
mics6$dv_nm<-factor(mics6$dv_nm,levels = 0:1,
                    labels = c("No","Yes"))
table(mics6$dv_nm)

table(mics6$dv_am)
mics6$dv_am[mics6$dv_am==""]<-0
mics6$dv_am[mics6$dv_am=="D"]<-1
table(mics6$dv_am)
mics6$dv_am<-factor(mics6$dv_am,levels = 0:1,
                    labels = c("No","Yes"))
table(mics6$dv_am)
mics6<-select(mics6,-c(PN13U,PN13N,PN22U,PN22N,wscore))
str(mics4)
str(mics6)
mics4<-select(mics4,colnames(mics6))
colnames(mics4)==colnames(mics6)
str(mics6)
new<-rbind(mics4,mics6)
table(new$windex5,new$year)
str(new)
str(new)
dim(new)
dim(mics4)
dim(mics6)
new$cluster<-paste(new$year,new$cluster,sep="_")
length(unique(new$cluster))
length(unique(mics4$cluster))
length(unique(mics6$cluster))
table(new$ANC,new$year) %>% prop.table()
table(new$wmage,new$year) %>% prop.table()
table(new$welevel[new$year==2010]) %>% prop.table()
table(new$welevel[new$year==2018]) %>% prop.table()
############



################
#
str(mics4)
str(mics6)
table(mics4$ANC_am)
table(mics4$ANC_doc)
table(mics4$ANC_nm)
table(mics4$ANCp)
sum(is.na(mics4))

sum(is.na(mics4$ANC))
mics4<-mics4[!is.na(mics4$ANC),]
sum(is.na(mics4$ANCp))
table(mics4$ANCp)
colnames(mics4)
colnames(mics6)

mics4<-select(mics4,colnames(mics6))
colnames(mics4)
new<-rbind(mics4,mics6)

table(new$ANCp)
table(new$dvp)
table(new$dvp,new$year)
is.na(new) %>% sum()
sapply(new, function(x){is.na(x)%>% sum()})
###
table(new$marital)
new$marital[new$marital=="married"|new$marital==
                    "living with a partner"]<-1
new$marital[new$marital=="single"]<-0
table(new$marital)
new$marital<-factor(new$marital,levels = 0:1,
                    labels =  c("Single_now","living_married"))
new$province[new$province=="Tanganyika"|
                     new$province=="Haut Lomami"|
                     new$province=="Lualaba"|
                     new$province=="Haut Katanga"]<-"Katanga"
new$province[new$province=="Lomami"|
                     new$province=="Sankuru"|
                     new$province=="Kasai Oriental"]<-"Kasai Oriental"
new$province[new$province=="Kasai"|
                     new$province=="Kasai Central"]<-"Kasai Occidental"
new$province[new$province=="Kongo Central"|
                     new$province=="Bas congo"]<-"Bas Congo"
new$province[new$province=="Kwango"|
                     new$province=="Kwilu"|
                     new$province=="Maindombe"]<-"Bandundu"
new$province[new$province=="Equateur"|
                     new$province=="Tshuapa"|
                     new$province=="Mongala"|
                     new$province=="Nord Ubangi"|
                     new$province=="Sud Ubangi"]<-"Equateur"
new$province[new$province=="Bas Uele"|new$province=="Haut Uele"|
                     new$province=="Ituri"|
                     new$province=="Tshopo"|
                     new$province=="Province Orientale"]<-"Orientale"





write.csv(new,"merge4_6.csv")

# You can see before the weight, the proportion in 2018 is far from
# the report
table(mics4$ANCp) %>% prop.table()
table(mics6$ANCp) %>% prop.table()

table(mics4$dvp) %>% prop.table()
table(mics6$dvp) %>% prop.table()

sapply(mics6, function(x){is.na(x) %>% sum})
library(survey)
# after weight we can approximately the same proportion as report
df2010<-svydesign(~1,weights = ~wmweight,data=mics4)
svyciprop(~dvp,design = df2010)
svyciprop(~ANCp,design = df2010)

df2018<-svydesign(~1,weights = ~wmweight,data=mics6)
svyciprop(~dvp,design = df2018)
svyciprop(~ANCp,design = df2018)
