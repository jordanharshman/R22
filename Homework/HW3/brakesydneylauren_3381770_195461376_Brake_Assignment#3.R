# SYDNEY BRAKE
# Assignment 3 Data Visualization

### --- pH --- ### No comments!
# -1

# #1 ----------------------------------------------------------------------
library(tidyverse)
copus=read.csv(file.choose())

ggplot(copus, aes( y = Lec)) +
  geom_boxplot() 

# #2 ----------------------------------------------------------------------

copus2 <- copus %>%
  group_by(Size) %>%
  filter(!is.na(Size)) %>%
  summarize(count = n())

ggplot(copus2, aes(x = Size , y = count)) +
  geom_col()


# #3 ----------------------------------------------------------------------
copus3 <- copus %>%
  group_by(Size, Broader) %>%
  filter(!is.na(Size)) %>%
  summarize(count = n())

ggplot(copus3, aes(x = Broader , y = count)) +
  geom_col() +
  facet_wrap(~Size) +
  theme(axis.text.x = element_text(angle = 90))

### --- pH --- ### FYI, if you use geom_bar() or "stat = "count""it will add these for you;
### you wouldn't have to tally the numbers yourself. Also, the angle is 270, but same diff as 90

# #4 ----------------------------------------------------------------------

copus4 <- copus %>%
  group_by(Broader) %>%
  summarize(AverageLec = mean(Lec))

ggplot(copus4, aes(x = Broader , y = AverageLec)) +
  geom_point() 


# #5 ----------------------------------------------------------------------
copus5 <- copus %>%
  group_by(Broader, Lec) %>%
  summarize(AverageLec = mean(Lec))

### --- pH --- ### 
### In the copus5 object you have 816 rows; you grouped by repeats of individual Lec values, 
### which is odd. This means that if there were 100 chemists who all had 100% Lec, it will combine
### all into 1 person and compute the average of 100 people with 100% Lec, which is 100. Your boxplots 
### and averages are incorrect, therefore. This would work if you just used copus instead of copus5. If
### we're getting really technical, I also did NOT ask for standard deviations
# - 0.5

ggplot(copus, aes(x = Broader , y = Lec)) +
  geom_boxplot() + 
  stat_summary(AverageLec="mean", color="red")


# #6 ----------------------------------------------------------------------

copus6 <- copus %>%
  group_by(Broader, Size) %>%
  filter(!is.na(Size)) %>%
  select(c("CG", "OG", "WG")) %>%
  pivot_longer(c("CG", "OG", "WG"), names_to = "GroupWork", values_to = "Percent") 
  
ggplot(copus6, aes(x = GroupWork , y = Percent, fill = Broader)) +
  geom_boxplot() +
  facet_wrap(~Size)

# #7 ----------------------------------------------------------------------

ggplot(copus6, aes(x = GroupWork , y = Percent, fill = Broader)) +
  geom_boxplot(outlier.shape = NA) +
  scale_y_continuous(limits = c(0,60)) +
  facet_wrap(~Size)

ggsave("lastquestion.pdf",
       height = 2,
       width = 6,
       units = "in")
