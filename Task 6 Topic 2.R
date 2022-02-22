library(tidyverse)
copus <- read_csv("C:/Users/jth0083/Box/Teaching/CHEM 6450 Spring 2022/R22/data/COPUS.csv")

# 1 Layout has fixed, table, round, other, and missing categories. If you were to merge table, round, and other into one category (“flexible”), what is the average centered lecture (Lec) percent by class Size and Layout?

copus %>%
  filter(!is.na(Layout)) %>%
  mutate(Lec.c = Lec - mean(Lec),
         NewLayout = if_else(Layout == "Round" | Layout == "Table" | Layout == "Other", 
                             "Flex", Layout)) %>%
  group_by(Size, NewLayout) %>%
  summarize(Avg = mean(Lec.c))

# 2 Instructor ID #358  (biologist) has requested a data set that shows how much more or less they engage in all 25 behaviors from the average biology instructor in each of her 16 classes. Export a spreadsheet with just the requested 25 variables plus a dummy class identifier.

AvgBio <- copus %>%
  filter(Broader == "Biological") %>%
  summarize(across(L:T_O, mean)) %>%
  slice(rep(1:n(), each = 16))

dat358 <- copus %>%
  filter(`Instructor ID` == 358) %>%
  select(L:T_O)

soln <- (dat358 - AvgBio) %>%
  mutate(Class = 1:n())

write_csv(soln, "export.csv")

# 3 General research question: To what extent do biology instructors employ different teaching behaviors in small, medium, and large classes?



