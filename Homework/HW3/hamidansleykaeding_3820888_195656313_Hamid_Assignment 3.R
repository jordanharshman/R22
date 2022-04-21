#ANSLEY HAMID
#ASSIGNMENT 3: DATA VISUALIZATION

### --- pH --- ### No comments!
# -1

library(ggplot2)
library(dplyr)
# 1 -----------------------------------------------------------------------

ggplot(copus, aes(y = Lec)) + 
  geom_boxplot()


# 2 -----------------------------------------------------------------------

copus <- copus %>% filter(!is.na(Size))
ggplot(copus, aes(x = Size)) + 
  geom_bar()


# 3 -----------------------------------------------------------------------

copus <- copus %>%
  filter(!is.na(Size))
ggplot(copus, aes(x = Broader)) +
  geom_bar()+
  facet_wrap(~Size) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# 4 -----------------------------------------------------------------------

copus <- copus %>%
  ungroup()

copus <- copus %>%
  group_by(Broader) %>%
  summarize(AverageLec = mean(Lec))

ggplot(copus, aes(x = Broader, y = AverageLec)) +
  geom_point()

### --- pH --- ### Yours is different than mine because you have removed NAs from Size
# 5 -----------------------------------------------------------------------

### --- pH --- ### I generated an error here: you overwrote copus with a summarized copus and only two variables
### in lines 37-39
# -0.5

copus <- copus %>%
  group_by(Broader) %>%
  summarize(c(AverageLec = mean(Lec)), Lec) %>%
  rename("AverageLec" = "c(AverageLec = mean(Lec))")

ggplot(copus, aes(x = Broader, y = Lec))+ 
  geom_boxplot() +
  geom_point(copus, aes(x = Broader, y = AverageLec))

### --- pH --- ### Continuing from previous error, you have two objects both names copus. One has raw data
### to draw a boxplot; the other has summarized data, but right now copus is just the summary. You'd need to define
### a new object to store them separately

# 6 -----------------------------------------------------------------------

copus <- copus %>%
  group_by(Broader) %>%
  select(Broader, Size, CG, WG, OG) #only select necessary variables

sapply(copus, class)  #Check classes for copus variables and change to character for pivot
copus[3] <- sapply(copus[3],as.character)
copus[4] <- sapply(copus[4],as.character)
copus[5] <- sapply(copus[5],as.character)

copus <- copus %>%
  pivot_longer( cols = CG:OG, names_to = "Group Work") %>% #pivot around the group work variables and name the new variable group work
  group_by(`Group Work`)

copus<- copus %>%
  group_by(Broader)
  
sapply(copus, class) #check classes and change value to numeric so it can be plotted
copus[4] <- sapply(copus[4], as.numeric)

ggplot(copus, aes( x = `Group Work`, y = value, fill = Broader)) +
  geom_boxplot()+
  geom_point()+
  facet_wrap(~Size) #splits data into facet grid

### --- pH --- ### Why did you convert to character variable in lines 71-73? You endd up converting them
### back in line 83? 

# 7 -----------------------------------------------------------------------

ggplot(copus, aes( x = `Group Work`, y = value, fill = Broader)) +
  geom_boxplot(outlier.shape = NA)+
  ylim(0,60) +
  facet_wrap(~Size) #splits data into facet grid

ggsave("Data_Vis.pdf",
       height = 2,
       width = 6,
       units = "in",
       dpi = 72)

### --- pH --- ### Recall that dpi doesn't do anything in vector files. 