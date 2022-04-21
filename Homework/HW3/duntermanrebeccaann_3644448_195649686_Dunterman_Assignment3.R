# REBECCA DUNTERMAN
# Assignment 3 Introduction to R


library(tidyverse)  #load the tidyverse
library(dplyr)      #load dplyr

setwd("C:/Users/rebdu/Documents/Foundations_of_R spring22") #set the working directory
copus <- read_csv("copus.csv")#load in / read copus for later
#copus.csv <-read.csv("copus.csv") #a different format for loading in the data


# 1 -----------------------------------------------------------------------
ggplot(copus, aes(y = Lec)) +   # tell ggplot that lec will be the y axis
  geom_boxplot()                #make it a boxplot 
#2 ----------------------------------------------------------------------
copus.2 <- copus %>%       #create copus object 2
  filter(!is.na(Size))     #remove nas 
ggplot(copus.2, aes(x = Size)) +  #   tell gggplot to use copus 2 and  size as x axis
  geom_bar()         #make it bar graph
              
#3  --------------------------------------------------------------
ggplot(copus.2, aes(x = Broader)) +     #tell ggplot to use copus 2 again anf set broader as x axis
  geom_bar() +        #make it a bar graph
  guides(fill = "none") +   
  facet_wrap(~Size)   #make multiple plots that change by size

### --- pH --- ### Text rotation?

#4 ---------------------------------------------------------------
copus.4 <- copus %>%  # make a 4th copus object
  group_by(Broader) %>%   #sort by broader
  summarize(AvgLec = mean(Lec)) %>% # find the mean of lec and create an object with it
  na.omit()  #leave out nas
ggplot(copus.4, aes(x = Broader, y = AvgLec)) + # tell ggplot to use copus 4 with broader as x axis and averagelec as y axis
  geom_point()

#5 -------------------------------------------------------------------


ggplot(copus, aes(x = Broader,y = Lec)) + # tell ggplot to use copus with x axis broader and y axis lec
  geom_boxplot()  #create boxplot
#add AvgLec points for each group

### --- pH --- ### Did not add averages
# -1

# 6 -----------------------------------------------------------------------

#copus.6 <- copus %>%
#  filter(!is.na(Size))
#ggplot(copus.6, aes(y = CG, fill = Broader)) +
 # geom_boxplot()+
#facet_wrap(~Size)

#copus.6 <- copus %>%
 # filter(!is.na(Size))
#ggplot(copus.6, aes(y = WG, fill = Broader))+
 # geom_boxplot()+
#facet_wrap(~Size)

#copus.6 <- copus %>%
 # filter(!is.na(Size))
#ggplot(copus.6, aes(y = OG, fill = Broader))+
 # geom_boxplot()+
  #facet_wrap(~Size)

 copus.6a <- pivot_longer(copus, CG:OG ,names_to = "Groupwork", values_to = "Percent")%>% #make data longform by cg wg and og, name those three as group work and name their values percent
 filter(!is.na(Size)) #get rid of nas
 
 ggplot(copus.6a, aes(y = Percent, x = Groupwork, fill = Broader))+  #tell ggplot to use copus6.a with y axis persent, x axis groupwork, clumped by broader
 geom_boxplot()+  # make it a boxplot
 facet_wrap(~Size) #make multiple changed by size
 

# 7 ----------------------------------------------------------------------

copus.6a <- pivot_longer(copus, CG:OG ,names_to = "Groupwork", values_to = "Percent")%>%
filter(!is.na(Size))
 
 ggplot(copus.6a, aes(y = Percent, x = Groupwork, fill = Broader))+  #same as above
   geom_boxplot(outlier.shape = NA)+ #hide outliers
   ylim(0, 60)+  #y axis cannot be above 60
   facet_wrap(~Size)
 ggsave("question7.pdf",  
        height = 2,
        width = 6,
        units = "in",
        dpi = 72)      #save as a pdf that is 2x6inches  with defult dpi
 
 ### --- pH --- ### Recall that dpi isn't doing anything in vector files
  

 