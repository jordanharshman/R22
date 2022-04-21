# Covie Rigdon
# Assignment 1 Introduction to R

library(tidyverse)
copus <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/df.csv")

copus %>%
  mutate(Lec.c = Lec - mean(Lec)) %>% #Center the data by subtracting lec dat from mean
  mutate(NewLayout = if_else(layout()))

###--- pH ---### if you don't need this code, you should get rid of it

# 1------------------------------------------------------------------------
library(tidyverse) ###--- pH ---### already libraried
library(dplyr)     ###--- pH ---### already libraried in tidyverse, redundant
df <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/df.csv")

# Revised 2 --------------------------------------------------------------- 
df %>%
  rename(ID = X1) %>% #rename(cars, distance = dist)
  mutate(V2=abs(V2), V3=abs(V3), V4=abs(V4), V5=abs(V5), V6=abs(V6)) %>% #mutate(.data, ..., .keep = "all", .before = NULL,  .after = NULL) Compute new column(s).
  mutate(V7 = replace(V7, V7 < -.9, NA_real_)) %>% #replace values less then -.9 with NA
  filter(V1 != "D") %>% #removes v1 that equals D
  arrange(V1, desc(V2)) %>% #arranges by V1 then by V2
  group_by(V1) %>% #groups the data by v1
  summarize(Mean = mean(V2), Sd = sd(V2)) #outputs the mean and sd of v2 within the grouped v1

# 3 -----------------------------------------------------------------------
library(tidyverse)
df.1 <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/df.csv") #clean input of data
df.2 <- gather(df.1, Variable, Score, V2:V11, factor_key=TRUE) #Tidy way of reorganizing data from wide to long
df.2 <- df.2 %>%
  select(-X1) %>% #cleaning up new data by removing the id column
  arrange(V1, Variable, by_group = TRUE) %>% #attempt at rearranging data to match screenshot; I am struggling to arrange the variable column in a way to match the screenshot)
  add_column(Sign = sign(df.2$Score)) #new column to add sign need to change it to char signs is there an easier way to swap data from num to chr to assign -. or + signs instead of using -1, 1

###---pH---### Notes:
# L31 you can still continue the pipe; also, gather() is old (will die soon), use pivot_longer() instead
# You didn't actually replace the Sign column with a + or - as requested, but -1 and 1 works

# 4 -----------------------------------------------------------------------
#Create this dataset in R (call it "key") and join it to df.l (from #3) so every obs in df.l 
#that has V1 = "A" and Variable = "V2" should be assigned a NewValue = 1; every obs in 
#df.l that has V1 = "A" and Variable = "V3" should be assigned a New Value = 2... and 
#so on. Here is the desired, joined data.

library(tidyverse)
key <- df.2
key <- key %>%
  select(-Score) %>% #cleaning up the key
  select(-Sign) %>%
  
  nest_join(df.2, key, by = NULL, copy = FALSE, keep = FALSE, name = NULL)

left_join(df.2, key, by = NULL, copy = FALSE, keep = FALSE, name = NULL)

#I am lost on how to proceed I have tried so many methods of trying to make a key that I can merge to actively compute a new column, and nothing works

###---pH---### -1

# 5 -----------------------------------------------------------------------
library(tidyverse)
copus <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/COPUS.csv")

df <- tibble(Variables = names(copus), Type = rep(c("Demographic", "Behavior", "Cluster"), c(8, 25, 2))) %>%
  rowwise() %>% mutate(NewVariable=paste(select(df, Variables),select(df, Type),sep='.'))
#I feel so close to completing the missing line I know it's a new column made by adding the two characters together (this works except it is adding the entire Variable and Type chars together is there a way to force the selection to only pertain to its line?)

###---pH---### -1

# 6 -----------------------------------------------------------------------
library(tidyverse)
copus <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/COPUS.csv")
copus$Bcluster <- factor(copus$Bcluster, levels = c("Mostly lecture", "Transitioning", "High engagement"))
#I was able to make ggplot use a specific order of Bcluster by assigning them as factors with levels since ggplot follows the order now)
ggplot(data=copus,aes(x=Bcluster,y=Lec)) #simple ggplot to check x axis order





