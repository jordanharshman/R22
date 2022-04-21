# Libraries ---------------------------------------------------------------
library(tidyverse)
library(dplyr)


setwd("//Users/april/Dropbox/R data") # makes Desktop wd (home mac)
setwd("//Users/ars0152/Dropbox/R data") # makes Desktop wd (laptop & work mac)


copus <- read.csv("COPUS.csv") # base R way

# APRIL SMITH
# Assignment 3 Data Viz

### --- pH --- ### No comments! 
# -1

# 1 -----------------------------------------------------------------------

Lec <- copus %>%
  select(Lec) 

boxplot(Lec)

### --- pH --- ### This is base R, I always recommend ggplot()

BarChart(Lec)

### --- pH --- ### Is this a function?

# 2 -----------------------------------------------------------------------

size <- copus %>%
  select(Size)%>%
  na.omit() 

### --- pH --- ### caution with na.omit() as it will delete anyone with missing from any variable. That worked 
### here because you selected only the Size columns, but that may not always be viable. 

ggplot(size, aes(x=Size))+
  geom_bar()


# 3 -----------------------------------------------------------------------

broad <- copus %>%
  select(Size, Broader)%>%
  na.omit() 

ggplot(broad, aes(x = Broader)) +
  geom_bar() +
  facet_wrap(~Size)

### --- pH --- ### Did not rotate x-axis text
# -0.5

# 4 -----------------------------------------------------------------------

AvgLec <- copus %>%
  filter(Broader %in% c("Biological", "Chemical", "Computer", "Engineering", "Geological",
                        "Mathematics", "Missing", "Physical")) %>%
  group_by(Broader) %>%
  summarize(AvgLec = mean(Lec)) %>%
  na.omit()

ggplot(AvgLec, aes(x = Broader, y = AvgLec)) +
  geom_point()


# 5 -----------------------------------------------------------------------

dot <- copus %>%
  select(Lec, Broader)

### --- pH --- ### these selects aren't really necessary; can just use copus object


ggplot(dot, aes(x = Broader, y = Lec)) +
  geom_boxplot() +
  stat_summary(Lec=mean, geom="point", shape=20, size=3, color="red", fill="red")

# 6 -----------------------------------------------------------------------

copus.gw <- copus %>% 
  select(Broader, Size, CG:OG) %>% #select relevant vars
  filter(Size !="Missing") %>% #remove missing
  pivot_longer(c(-Broader, -Size), "GroupWork") %>%
  rename(Percent = value)

ggplot(copus.gw, aes(x = GroupWork, y = Percent, fill=Broader)) +
  geom_boxplot() +
  facet_wrap(~Size)


# 7 -----------------------------------------------------------------------

ggplot(copus.gw, aes(x = GroupWork, y = Percent, fill=Broader)) +
  geom_boxplot(outlier.shape = NA) +
  facet_wrap(~Size) + 
  ylim(0, 60)

# df doubled resolution, in inches
ggsave("plot7.pdf",
       height = 2,
       width = 6,
       units = "in",
       dpi = 200)
### --- pH --- ### recall that dpi doesn't do anything for vector file in inches
