##############################
library(dplyr)
library(stringr)
dvp<-read.csv("dvp_province_year.csv")
# id=1 kasai-oriental
# id=2 Tshopo
# id=3 Ituri
# id=4 Kongo central
# id=5 Mai-Ndombe
# id=6 Kwilu
# id=7 Kwango
# id=8 Equatuer
# id=9 Sud-Ubangi
# id=10 Nord-Ubangi
# id=11 Mongala
# id=12 Tshuapa
# id=13 Bas-Uele
# id=14 Haut-Uele
# id=15 Nord-Kivu
# id=16 Maniema
# id=17 Lualaba
# id=18 Haut-Lomami
# id=19 Tanganyika
# id=20 Haut-Katanga
# id=21 Sankuru
# id=22 Lomami
# id=23 Kasai-Central
# id=24 Kasai
# id=25 Sud-Kivu
# id=26 Kinshasa

cord<-read.csv("DRC_coord.csv")
#############################################
cord$h<-cord$X_ID
cord$X_ID[cord$X_ID==1]<-"Kasai Oriental"
cord$X_ID[cord$X_ID==2]<-"Orientale"
cord$X_ID[cord$X_ID==3]<-"Orientale"
cord$X_ID[cord$X_ID==4]<-"Bas Congo"
cord$X_ID[cord$X_ID==5]<-"Bandundu"
cord$X_ID[cord$X_ID==6]<-"Bandundu"
cord$X_ID[cord$X_ID==7]<-"Bandundu"
cord$X_ID[cord$X_ID==8]<-"Equateur"
cord$X_ID[cord$X_ID==9]<-"Equateur"
cord$X_ID[cord$X_ID==10]<-"Equateur"
cord$X_ID[cord$X_ID==11]<-"Equateur"
cord$X_ID[cord$X_ID==12]<-"Equateur"
cord$X_ID[cord$X_ID==13]<-"Orientale"
cord$X_ID[cord$X_ID==14]<-"Orientale"
cord$X_ID[cord$X_ID==15]<-"Nord Kivu"
cord$X_ID[cord$X_ID==16]<-"Maniema"
cord$X_ID[cord$X_ID==17]<-"Katanga"
cord$X_ID[cord$X_ID==18]<-"Katanga"
cord$X_ID[cord$X_ID==19]<-"Katanga"
cord$X_ID[cord$X_ID==20]<-"Katanga"
cord$X_ID[cord$X_ID==21]<-"Kasai Oriental"
cord$X_ID[cord$X_ID==22]<-"Kasai Oriental"
cord$X_ID[cord$X_ID==23]<-"Kasai Occidental"
cord$X_ID[cord$X_ID==24]<-"Kasai Occidental"
cord$X_ID[cord$X_ID==25]<-"Sud Kivu"
cord$X_ID[cord$X_ID==26]<-"Kinshasa"
names(cord)[names(cord)=="X_ID"]="province"
cord$province %>% table
######################
d<-str_split(dvp$province_year,"_")
x<-unlist(d)
df<-data.frame(province=x,id=1:length(df$x))
df<-df[df$id%%2==1,]
df
dvp$province<-df$province
dvp$year<-rep(c(2010,2018))
dvp2010<-dvp[dvp$year==2010,]
dim(dvp2010)
dvp2018<-dvp[dvp$year==2018,]
dim(dvp2018)
dvp<-data.frame(province=unique(dvp$province),change=dvp2018$ADJMEAN-dvp2010$ADJMEAN)
dvp
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
anc$province<-as.factor(anc$province)
anc$province%>% table()
anc<-anc[order(anc$X_X,anc$X_Y),]
table(anc$province,anc$change)
cord
table(anc$change,anc$province)

cord$change[cord$province=="Bandundu"]<- -0.000098
cord$change[cord$province=="Bas Congo"]<- -0.010437
cord$change[cord$province=="Equateur"]<- 0.09951
cord$change[cord$province=="Kasai Occidental"]<- 0.102609
cord$change[cord$province=="Kasai Oriental"]<- -0.03548
cord$change[cord$province=="Katanga"]<- 0.08686
cord$change[cord$province=="Maniema"]<- 0.017574
cord$change[cord$province=="Nord Kivu"]<- 0.01661
cord$change[cord$province=="Orientale"]<- 0.0678856
cord$change[cord$province=="Sud Kivu"]<- 0.00606
cord$change[cord$province=="Kinshasa"]<- 0.0238
dvp
cord$province %>% table
length(unique(cord$change))


tiff("map_dvp.tiff",width=200,height=200,units='mm',res=600)
ggplot() +  geom_polygon(data = cord, aes(x = X_X, y = X_Y, group =province,fill=change*100),color="black", size = 0.25) +
        theme(aspect.ratio=1)+theme_opts+
        theme(legend.title = element_text(face = "bold"))+
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

