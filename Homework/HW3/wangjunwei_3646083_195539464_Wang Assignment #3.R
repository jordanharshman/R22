#Junwei Wang
#Assignment 3 
# 1. ----------------------------------------------------------------------
library(tidyverse)
setwd("~/Desktop/R22-main 2/data")
copus<-read.csv("COPUS.csv") # load the copus file

ggplot(copus, aes(y = Lec)) +
  geom_boxplot() #code for figure 1
  
# 2 -----------------------------------------------------------------------
copus.2<-copus%>%
  filter(!is.na(Size))# since I need to do data manipulation first, so I create copus.2 for this question
ggplot(copus.2,aes(x=Size))+
  geom_bar()#bar figure for question2 


# 3 -----------------------------------------------------------------------
ggplot(copus.2,aes(x=Broader))+
  geom_bar()+
  facet_wrap(~Size)+
  guides(x=guide_axis(angle =-90))

# Since I need to do the same copus data manipulation as question 2 which is get rid of the NA size, I continue used copus.2 dataset for the figure
# after separate the figures into three based on their size, I rotated the text on the x axix to let it better fit in the space


# 4 -----------------------------------------------------------------------
copus.4<-copus%>% #new manipulation to the data, so new dataset created
  group_by(Broader)%>%
  summarize(AverageLec = mean(Lec)) 
ggplot(copus.4, aes(x=Broader, y=AverageLec))+
  geom_point()


# 5 -----------------------------------------------------------------------
copus.4<-copus%>% #the first step is basically the same as question 4
  group_by(Broader)%>%
  summarize(AverageLec = mean(Lec)) 
ggplot(copus, aes(x=Broader, y=Lec))+
  geom_boxplot()+
  geom_point(data=copus.4, aes(x=Broader, y=AverageLec),color="red")
# graph the boxplot first using the original copus data, then add the geom_point figure(same as question4) and label the average dot in red color.
  

# 6 -----------------------------------------------------------------------
copus.6<-copus.2%>% #I still used the copus.2 dataset which contain no NA size observation.
  select(Broader, Size, OG,CG,WG)%>% #Select these important variables that showed in the figure
  pivot_longer(cols=-c(Broader,Size),names_to = "GroupWork",values_to = "Percent")# arrange the dataset using pivot. Rename OC:WG as GroupWork and rename their corresponding values as percent
ggplot(copus.6, aes(x=GroupWork, y=Percent,fill=Broader))+
  geom_boxplot()+
  facet_wrap(~Size)# graph the figure and seperate the figure based on their sizes
# 7 -----------------------------------------------------------------------
ggplot(copus.6, aes(x=GroupWork, y=Percent,fill=Broader))+ #sme as question 6
  geom_boxplot(outlier.shape = NA)+ #remove the outlier
  facet_wrap(~Size)+ #seperate by sizes, same as question 6
  scale_y_continuous(name = "Percent", limits = c(0,60))# set the y limit 
ggsave("boxplot.pdf",width=6, height=2, units="in", scale=3)
  
### --- pH --- ### I have no suggestions for you; great job!
