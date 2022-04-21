# Libraries ---------------------------------------------------
library(tidyverse)
setwd("C:/Users/jth0083/Box/Teaching/CHEM 6450 Spring 2022/R22/")

# #1 ----------------------------------------------------------------------
df <- read_csv("data/df.csv")

# #2 ---------------------------------------------------------------------
df2 <- df %>%
  rename(ID = "X1") %>% # 2a
  mutate(across(V2:V6, abs), # 2b
         V7 = if_else(V7 < -.9, NA_real_, V7)) %>% # 2c
  filter(V1 != "D") %>% # 2d
  arrange(V1, desc(V2)) %>% # 2e
  group_by(V1) %>% # 2f
  summarize(AvgV2 = mean(V2),
            SDV2 = sd(V2)) # 2f

# #3 ----------------------------------------------------------------------
df.l <- df %>%
  select(-X1) %>% # get rid of X1
  pivot_longer(-V1, "Variable", values_to = "Score") %>% # pivot, renaming in the process
  mutate(SignScore = if_else(Score < 0, "-", "+")) # create new sign variable


# #4 ----------------------------------------------------------------------
# write in the key data, which follows set patterns
key <- tibble(V1 = rep(LETTERS[1:3], each = 10),
              Variable = rep(str_c("V", 2:11), 3),
              NewValue = 1:30)

df.joined <- df.l %>%
  left_join(key) # left_join is all that's required

# #5 ----------------------------------------------------------------------
copus <- read_csv("data/copus.csv")
df <- tibble(Variables = names(copus),
             Type = rep(c("Demographic", "Behavior", "Cluster"), c(8, 25, 2))) %>%
  mutate(NewVariable = str_c(Type, Variables, sep = ".")) # redacted line, paste strings together with "." separator
df

# #6 ----------------------------------------------------------------------

# make the plot
ggplot(copus, aes(x = Bcluster, y = Lec)) +
  geom_boxplot()

# create a new variable 
copus <- copus %>%
  mutate(Bcluster = factor(Bcluster, levels = c("Mostly lecture", "Transitioning", "High engagement")))

# reproduce the plot, now in desired order
ggplot(copus, aes(x = Bcluster, y = Lec)) +
  geom_boxplot()
