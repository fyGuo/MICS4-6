#load package
#################################
#read the basic map information and check it
library(ggplot2)
library(dplyr)
library(maps)
library(raster)
library(plyr)
library(rgdal)
library(maptools)
###################
#read the data
dfpyanc<-read.csv("ANCp_province_year.csv")
dfpyanc
library(dplyr)
library(ggplot2)
library(ggthemes)
dfpyanc
dfpyanc<-mutate(dfpyanc,province=rep(c(
        "Bandundu",
        "Bas Congo",
        "Equateur",
        "Kasai Occidental",
        "Kasai Oriental",
        "Katanga",
        "Kinshasa",
        "Maniema",
        "Nord Kivu",
        "Orientale",
        "Sud Kivu"),times=2))
dfpyanc
dfpyanc<-mutate(dfpyanc,year=rep(c("2010","2018"),each=11))
dfpyanc
dfpyanc<-dplyr::select(dfpyanc,ADJMEAN,province,year)


library(ggplot2)
library(maps)
library(raster)
library(plyr)
library(rgdal)
library(maptools)
Congo1<-getData("GADM", country="CD", level=1)


Congo1_UTM<-spTransform(Congo1, CRS("+init=EPSG:32737"))  
Congo1_df <- fortify(Congo1_UTM)
Congo1_df <- Congo1_df[order(Congo1_df$id),]
#
#new$province[new$province=="Tanganyika"|
#                     new$province=="Haut Lomami"|
#                     new$province=="Lualaba"|
#                     new$province=="Haut Katanga"]<-"Katanga"
#new$province[new$province=="Lomami"|
#                     new$province=="Sankuru"|
#                     new$province=="Kasai Oriental"]<-"Kasai Oriental"
#new$province[new$province=="Kasai"|
#                     new$province=="Kasai Central"]<-"Kasai Occidental"
#new$province[new$province=="Kongo Central"|
#                     new$province=="Bas congo"]<-"Bas Congo"
#new$province[new$province=="Kwango"|
#                     new$province=="Kwilu"|
#                    new$province=="Maindombe"]<-"Bandundu"
#new$province[new$province=="Equateur"|
 #                    new$province=="Tshuapa"|
 #                    new$province=="Mongala"|
 #                    new$province=="Nord Ubangi"|
 #                    new$province=="Sud Ubangi"]<-"Equateur"
#new$province[new$province=="Bas Uele"|new$province=="Haut Uele"|
#                     new$province=="Ituri"|
 #                    new$province=="Tshopo"|
  #                   new$province=="Province Orientale"]<-"Orientale"

dfpyanc$province %>% table

dfpyanc$id[dfpyanc$province=="Orientale"]<-1

dfpyanc$id[dfpyanc$province=="Kinshasa"]<-2
dfpyanc$id[dfpyanc$province=="Bas Congo"]<-3
dfpyanc$id[dfpyanc$province=="Bandundu"]<-4
dfpyanc$id[dfpyanc$province=="Kasai Oriental"]<-5
dfpyanc$id[dfpyanc$province=="Katanga"]<-6
dfpyanc$id[dfpyanc$province=="Maniema"]<-7
dfpyanc$id[dfpyanc$province=="Equateur"]<-8
dfpyanc$id[dfpyanc$province=="Nord Kivu"]<-9
dfpyanc$id[dfpyanc$province=="Kasai Occidental"]<-10
dfpyanc$id[dfpyanc$province=="Sud Kivu"]<-11
table(dfpyanc$id,dfpyanc$province)
dfpyanc[dfpyanc$year=="2010",]
dfpyanc10<-dfpyanc[dfpyanc$year=="2010",]
dfpyanc10
dfpyanc18<-dfpyanc[dfpyanc$year=="2018",]
dfpyanc10
dfd<-data.frame(province=dfpyanc10$province,id=dfpyanc10$id,
                diff=dfpyanc18$ADJMEAN-dfpyanc10$ADJMEAN)
dfd
dfpyanc10[dfpyanc10$province=="Katanga",]
dfpyanc18[dfpyanc18$province=="Katanga",]

#Congo1_df$people_per<-Congo1_df$people_per*100
# "Bas_Uele" = 1
Congo1_df$id[Congo1_df$id==1]<-1
# "kinshasa'=2
Congo1_df$id[Congo1_df$id==2]<-2
# kongo Central=3
Congo1_df$id[Congo1_df$id==3]<-3
# "kwango'=4
Congo1_df$id[Congo1_df$id==4]<-4
# "kwilu'=5
Congo1_df$id[Congo1_df$id==5]<-4
#  lomami=6
Congo1_df$id[Congo1_df$id==6]<-5
# lualaba=7
Congo1_df$id[Congo1_df$id==7]<-6
# maindombe=8
Congo1_df$id[Congo1_df$id==8]<-4
# mainema=9
Congo1_df$id[Congo1_df$id==9]<-7
# mongala=10
Congo1_df$id[Congo1_df$id==10]<-8
# nord kivu=11
Congo1_df$id[Congo1_df$id==11]<-9
# equateur =12
Congo1_df$id[Congo1_df$id==12]<-8
# nord ubangi=13
Congo1_df$id[Congo1_df$id==13]<-8
# sankuru=14
Congo1_df$id[Congo1_df$id==14]<-5
# sud kive=15
Congo1_df$id[Congo1_df$id==15]<-11
# sud ubangi
Congo1_df$id[Congo1_df$id==16]<-8
# tanganyika=17
Congo1_df$id[Congo1_df$id==17]<-6
# tshopo=18
Congo1_df$id[Congo1_df$id==18]<-1
# tshupa=19
Congo1_df$id[Congo1_df$id==19]<-8
# haut katanga=20
Congo1_df$id[Congo1_df$id==20]<-6
# haut lomami=21
Congo1_df$id[Congo1_df$id==21]<-6
# haut uele=22
Congo1_df$id[Congo1_df$id==22]<-1
# Ituri=23
Congo1_df$id[Congo1_df$id==23]<-1
# Kasai central=24
Congo1_df$id[Congo1_df$id==24]<-10
# kasai Oriental=25
Congo1_df$id[Congo1_df$id==25]<-5
# kasai -26
Congo1_df$id[Congo1_df$id==26]<-10





Congo1_df
# merge two files

Congo1_df<-join(Congo1_df,dfd,by="id")

tiff("ANCp.tiff",width=200, height = 200,units ="mm" , res=400)
theme_opts<-list(theme(panel.grid.minor = element_blank(),
                       panel.grid.major = element_blank(),
                       panel.background = element_blank(),
                       plot.background = element_blank(),
                       axis.line = element_blank(),
                       axis.text.x = element_blank(),
                       axis.text.y = element_blank(),
                       axis.ticks = element_blank(),
                       axis.title.x = element_blank(),
                       axis.title.y = element_blank(),
                       plot.title = element_blank()))


ggplot() +  geom_polygon(data = Congo1_df, aes(x = long, y = lat, group = group,fill =diff*100), color = "black", size = 0.25) +
        theme(aspect.ratio=1)+theme_opts+
        scale_fill_gradient2(low = "#DC143C",
                             mid = "white",
                             high = "#228B22",
                             midpoint = 0,
                             space = "Lab",
                             na.value = "grey50",
                             guide = "colourbar",
                             aesthetics = "fill",
                             limits=c(-25,25),name="Change of\n adjusted coverage \n(%)")
dev.off()
?scale_fill_gradient2
dfd$diff
dfd
table(dfd$diff,dfd$province)




