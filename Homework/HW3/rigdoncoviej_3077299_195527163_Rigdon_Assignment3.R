# Covie Rigdon
# Assignment 3 Data Visualizations

library(tidyverse)
library(ggridges)
copus <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/COPUS.csv")

# 1------------------------------------------------------------------------
LecB <- LecBC %>%
  filter(Broader == "Biological") # data manipulation to keep only bio

### --- pH --- ### Error: LecBC not found. Why are you using Lec BC and not copus?
# -0.5

ggplot(LecB, aes(y = Lec)) + #gg box plot with lecB data and y lec
  geom_boxplot()

# 2 -----------------------------------------------------------------------
copus.size <- copus %>% #data manipulation to take out NA values
  filter(!is.na(Size))

ggplot(copus.size, aes(x = Size, fill = Cluster)) + #a gg bar plot with X size and cluster fill so they are on same graph
  geom_bar() 

# 3 -----------------------------------------------------------------------
copus.size <- copus %>% #data manipulation to take out NA values
  filter(!is.na(Size))

ggplot(copus.size, aes(x = Broader)) + #Bar gg plot with x value of broaders with a facet wrap to join the different sizes
  geom_bar() +
  facet_wrap(~Size) +
  theme(axis.text.x = element_text(angle = 270, vjust = 0.5, hjust=1)) # A theme change to see the x legend names better

# 4 -----------------------------------------------------------------------
copus.ds <- copus %>% #data manipulation group the data by broader to find the averagelec and omit NA values
  group_by(Broader) %>%
  summarize(AverageLec = mean(Lec)) %>%
  na.omit()

ggplot(copus.ds, aes(x = Broader, y = AverageLec )) + #point gg plot with x broader and y averagelec ploted
  geom_point()

# 5 -----------------------------------------------------------------------
copus.ds <- copus %>% #data manipulation group the data by broader to find the averagelec and omit NA values
  group_by(Broader) %>%
  summarize(AverageLec = mean(Lec)) %>%
  na.omit()

LecB1 <- copus %>% #data manipulation group the data by broader and then creating a variable to of lec thats plottable
  group_by(Broader) %>%
  summarize(Lec1 = Lec)

ggplot(copus.ds, aes(x = Broader, y = AverageLec, )) + #The point plot from before but with color being specified
  geom_boxplot(data = LecB1, aes(y=Lec1)) + # A boxplot added with a different y value(lec) that is not averaged
  geom_point(color = "red")

# 6 -----------------------------------------------------------------------
#this did not work I could not figure out how to properly graph a percentage as well as multiple graphs inside the graph
#leaving it here to figure out how off I was from key later but I spent way to long messing with graphs on here
copus.s <- copus %>%
  select(CG, Broader, Size) %>%
  group_by(Size) %>%
  na.omit()
percent = (copus.s$CG/mean(copus.s$CG))
ggplot(copus.s, aes(x=CG, fill = Broader)) +
  geom_boxplot() +
  geom_bar() +
  facet_wrap(~Size)


copus.size <- copus %>%
  filter(!is.na(Size))

ggplot(copus.size, aes(x = Broader, fill = Broader, color = Broader)) +
  geom_bar() +
  facet_wrap(~Size)

### --- pH --- ### Valient effort!
# -2

