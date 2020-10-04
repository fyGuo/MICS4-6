library(dplyr)
library(stringr)
library(ggplot2)
library(easyGgplot2)
library(ggthemes)
kasaianc<-read.csv("anc_kasai_wealth.csv")
kasaianc<-select(kasaianc,winyear,ADJMEAN,LOWCI,HIGHCI)
kasaianc
t<-strsplit(kasaianc$winyear,"_") %>% unlist()
kasaianc$wealth<-t[seq(1,19,2)]
kasaianc$year<-t[seq(2,20,2)]
kasaianc$ser<-"ANC1"
#############################################
kasaidvp<-read.csv("dvp_kasai_wealth.csv")
kasaidvp<-select(kasaidvp,winyear,ADJMEAN,LOWCI,HIGHCI)
kasaidvp
t<-strsplit(kasaidvp$winyear,"_") %>% unlist()
kasaidvp$wealth<-t[seq(1,19,2)]
kasaidvp$year<-t[seq(2,20,2)]
kasaidvp$ser<-"Skilled birth attendance"
kasai<-rbind(kasaianc,kasaidvp)
kasai
kasai$wealth<-factor(kasai$wealth,
                     levels =c("poorest","poor",
                                "middle","wealth",
                                     "wealthest"),
                     labels = c("Poorest","Poorer","Middle","Wealthier",
                                "Wealthiest"))
kasai$text<-sprintf("%0.2f", round(kasai$ADJMEAN*100,2), digits = 2)

p1<-ggplot(kasai,aes(x=wealth,y=ADJMEAN*100,fill=as.factor(year)))+
        geom_bar(stat='identity',position =  position_dodge(0.9),
                 color="black",width=0.8)+
        geom_text(aes(x=wealth,y=HIGHCI*100+4,
                      label=text),size=3,
                  position = position_dodge(0.9))+
        geom_errorbar(aes(ymin=LOWCI*100,ymax=HIGHCI*100),width=0.2,
                      position = position_dodge(0.9))+
        facet_grid(ser~.)+
        scale_fill_manual(values = c("white","grey"),name="Year")+
        theme_classic()+
        theme(strip.background = element_rect(colour="white", fill="white"))+
        theme(strip.text = element_text(size=13))+
        theme(legend.position="bottom")+
        ylab("Coverage (%)")+
        labs(title = "Kasai")+
        theme(plot.title = element_text(hjust=0.5))
############################################ 

kivuanc<-read.csv("anc_kivu_wealth.csv")
kivuanc<-select(kivuanc,winyear,ADJMEAN,LOWCI,HIGHCI)
kivuanc
t<-strsplit(kivu$winyear,"_") %>% unlist()
kivuanc$wealth<-t[seq(1,19,2)]
kivuanc$year<-t[seq(2,20,2)]
kivuanc$ser<-"ANC1"
#######################################
kivudvp<-read.csv("dvp_kivu_wealth.csv")
kivudvp<-select(kivudvp,winyear,ADJMEAN,LOWCI,HIGHCI)
kivudvp
t<-strsplit(kivudvp$winyear,"_") %>% unlist()
kivudvp$wealth<-t[seq(1,19,2)]
kivudvp$year<-t[seq(2,20,2)]
kivudvp$ser<-"Skilled birth attendance"
kivu<-rbind(kivuanc,kivudvp)
kivu
kivu$wealth<-factor(kivu$wealth,
                     levels =c("poorest","poor",
                               "middle","wealth",
                               "wealthest"),
                     labels = c("Poorest","Poorer","Middle","Wealthier",
                                "Wealthiest"))
kivu$text<-sprintf("%0.2f", round(kivu$ADJMEAN*100,2), digits = 2)

p2<-ggplot(kivu,aes(x=wealth,y=ADJMEAN*100,fill=as.factor(year)))+
        geom_bar(stat='identity',position =  position_dodge(0.9),
                 color="black",width=0.8)+
        geom_text(aes(x=wealth,y=HIGHCI*100+4,
                      label=text),size=3,
                  position = position_dodge(0.9))+
        geom_errorbar(aes(ymin=LOWCI*100,ymax=HIGHCI*100),width=0.2,
                      position = position_dodge(0.9))+
        facet_grid(ser~.)+
        scale_fill_manual(values = c("white","grey"),name="Year")+
        theme_classic()+
        theme(strip.background = element_rect(colour="white", fill="white"))+
        theme(strip.text = element_text(size=13))+
        theme(legend.position="bottom")+
        ylab("Coverage (%)")+
        labs(title = "Kivu")+
        theme(plot.title = element_text(hjust=0.5))
p2
####################################################

otheranc<-read.csv("anc_other_wealth.csv")
otheranc<-select(otheranc,winyear,ADJMEAN,LOWCI,HIGHCI)
otheranc
t<-strsplit(other$winyear,"_") %>% unlist()
otheranc$wealth<-t[seq(1,19,2)]
otheranc$year<-t[seq(2,20,2)]
otheranc$ser<-"ANC1"
#######################################
otherdvp<-read.csv("dvp_other_wealth.csv")
otherdvp<-select(otherdvp,winyear,ADJMEAN,LOWCI,HIGHCI)
otherdvp
t<-strsplit(otherdvp$winyear,"_") %>% unlist()
otherdvp$wealth<-t[seq(1,19,2)]
otherdvp$year<-t[seq(2,20,2)]
otherdvp$ser<-"Skilled birth attendance"
other<-rbind(otheranc,otherdvp)
other
other$wealth<-factor(other$wealth,
                    levels =c("poorest","poor",
                              "middle","wealth",
                              "wealthest"),
                    labels = c("Poorest","Poorer","Middle","Wealthier",
                               "Wealthiest"))
other$text<-sprintf("%0.2f", round(other$ADJMEAN*100,2), digits = 2)

p3<-ggplot(other,aes(x=wealth,y=ADJMEAN*100,fill=as.factor(year)))+
        geom_bar(stat='identity',position =  position_dodge(0.9),
                 color="black",width=0.8)+
        geom_text(aes(x=wealth,y=HIGHCI*100+4,
                      label=text),size=3,
                  position = position_dodge(0.9))+
        geom_errorbar(aes(ymin=LOWCI*100,ymax=HIGHCI*100),width=0.2,
                      position = position_dodge(0.9))+
        facet_grid(ser~.)+
        scale_fill_manual(values = c("white","grey"),name="Year")+
        theme_classic()+
        theme(strip.background = element_rect(colour="white", fill="white"))+
        theme(strip.text = element_text(size=13))+
        theme(legend.position="bottom")+
        ylab("Coverage (%)")+
        labs(title = "Others")+
        theme(plot.title = element_text(hjust=0.5))
        
################################
tiff("wealth_change.tiff",width=400,height=200,units = "mm",res = 600)
ggplot2.multiplot(p1,p2,p3,cols=3)
dev.off()
pdf("wealth_change.pdf",width=15,height =7.5)
ggplot2.multiplot(p1,p2,p3,cols=3)
dev.off()
