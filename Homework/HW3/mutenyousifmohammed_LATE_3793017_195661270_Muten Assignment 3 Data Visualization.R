
# Yousif Muten ------------------------------------------------------------

# Assignment 3 Data Visualizations ----------------------------------------


library(tidyverse)
library(ggplot2)

getwd()
setwd("C:/Users/Abo-jaber/Box/R class")
copus <- read_excel("COPUS.xlsx")

# 1 -----------------------------------------------------------------------

ggplot(copus.size, aes(x = 0, y = Lec )) +  # create a boxplot
  geom_boxplot()

### --- pH --- ### Error: copus.size not found; where did you create this data?
### Also, don't define an x aesthetic here or else the entire axis is forced to be numeric.
# -0.5

# 2 -----------------------------------------------------------------------

copus %>%  # take copus then...
  filter(!is.na(Size)) %>%     # filter size and remove na      
  ggplot(aes(x = Size , y =  )) +   # create barplot 
  geom_bar()

# 3 -----------------------------------------------------------------------

ggplot(copus, aes(x = Broader, y = , colors = Size))+ # create barplot
  geom_bar() +
  facet_wrap(~Size, nrow = 1) %>%
  na.omit()  # remove na but apparently it is not working

### --- pH --- ### na_omit() not working because you are in a ggplot statement, not a dplyr pipe,
### so you are not modifying the data anymore, just the graph. Either way, na.omit() would get rid
### of any observatino with a missing obs, so that's not what you want either. Lastly, you did not rotate the x axis.
# -0.5

# 4 -----------------------------------------------------------------------

copus.d <- copus %>% # creat new object then group by broader
  group_by(Broader) %>% # then summarize and compute the average lec for each discipline
  summarize(AverageLec = mean(Lec)) %>% # them make a point plot Averagelec for each discipline

  ### --- pH --- ### remove the final pipe; store separately
  
ggplot(copus.d, aes(x = Broader, y = AverageLec)) +
  geom_point()

# 5 -----------------------------------------------------------------------


ggplot(copus, aes(x = Broader, y = Lec)) + # make a boxplot lec for each discipline and compute the mean of lec on as a red dot boxplot
  geom_boxplot() +
  stat_summary(fun=mean, geom = "point", color = "red", fill = "red")

# 6 -----------------------------------------------------------------------

  copus.gw <- copus %>% # create a new object then select only discipline, size and CG:OG size 
    select(Broader,Size,CG:OG) %>% # then pivot into long form
    pivot_longer(!c(Broader, Size), names_to =  "GroupWork", values_to = "Percent") 
  
  ggplot(copus.gw, aes(x = GroupWork, y = Percent, fill = Broader)) +  # create boxplot
    geom_boxplot() +
    facet_wrap(~Size, nrow = 1) + theme(axis.text.x = element_text(size=7, angle=0)) %>%
    na.omit()  # still not removing na

# 7 final plot ------------------------------------------------------------

  ggplot(copus.gw, aes(x = GroupWork, y = Percent, fill = Broader)) + # create boxplot and remove outlier points
  geom_boxplot(outlier.shape = NA) + theme(axis.text.x = element_text(size=5, angle=0)) +
facet_wrap(~Size, nrow = 1) + ylim(min = 0, max = 60) %>% # change the y-axis limits for a max of 60
na.omit()
  ggsave("boxgw.pdf",      # export as a pdf
         height = 2,
         width = 6,
         units = "in",
         dpi = 200)
  ### --- pH --- ### Recall that dpi doesn't do anything with vector image and inches
  
 
  
 