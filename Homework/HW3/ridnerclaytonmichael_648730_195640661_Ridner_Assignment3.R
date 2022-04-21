# Clayton Ridner 
# Assignment 3 Data Visualizations 
library(tidyverse) #load tidyverse
setwd("/Users/cridner/Documents") # makes Documents wd (mac)
copus <- read_csv("copus.csv")

# #1 ----------------------------------------------------------------------

ggplot(copus, aes(y=Lec)) +  #use dataset copus, y axis is Lec
  geom_boxplot() #use geometry boxplot


# #2 ----------------------------------------------------------------------

LecSC <- copus %>% #create our variable for Size and Count
  count(Size) %>% #count total number of Size
  filter(!is.na(Size)) %>% #Filter out NA
  rename(Count = n)

ggplot(LecSC, mapping = aes(x = Size, y = Count)) + 
  geom_bar(stat="identity")

### --- pH --- ### could use geom_bar() to get them to count for you

# #3 ----------------------------------------------------------------------

LecSBC <- copus %>% #creating our variable
  group_by(Broader) %>% #group by broader
  count(Size) %>% #count size
  filter(!is.na(Size)) %>% #filter out all NA from Size
  rename(Count = n) 

ggplot(LecSBC, mapping = aes(x = Broader, y = Count)) + 
  geom_bar(stat="identity") +
  facet_wrap(~Size) + #wrap the elements so that they are grouped by size
  theme(axis.text.x = element_text(angle = 270)) #flip the text so it is rotated right

# #4 ----------------------------------------------------------------------

CopusBroadAvg <- copus %>% #make an additional new var
  group_by(Broader) %>% #group by Broader
  summarize(AvgLec = mean(Lec)) #make averages

ggplot(CopusBroadAvg, aes(x = Broader, y = AvgLec)) + #list axes with new var on y
  geom_point() 

### --- pH --- ### Technically didn't ask for standard deviations

# #5 ----------------------------------------------------------------------

CopusBroadLecAvg <- copus %>%
  group_by(Broader, Lec) %>%
  summarize(AverageLec = mean(Lec))
  

ggplot(CopusBroadLecAvg, aes(x = Broader, y = Lec)) + 
  geom_boxplot() + 
  stat_summary(AverageLec ="mean", color = "red")



# #6 ----------------------------------------------------------------------

AnotherCopus <- copus %>%
  group_by(Broader, Size) %>%
  filter(!is.na(Size)) %>%
  select(c("CG","OG","WG")) %>% 
  pivot_longer(c("CG","OG","WG"), names_to = "GroupWork", values_to = "Percent")

ggplot(AnotherCopus, aes(x = GroupWork , y = Percent, fill = Broader)) +
  geom_boxplot() +
  facet_wrap(~Size)


# #7 ----------------------------------------------------------------------

ggplot(AnotherCopus, aes(x = GroupWork, y = Percent, fill = Broader)) +
  geom_boxplot(outlier.shape = NA) +
  scale_y_continuous(limits = c(0,60)) + 
  facet_wrap(~'Size')

ggsave("printout.pdf",
       height = 2,
       width = 6,
       unit = "in")

  
