# Covie Rigdon
# Assignment 1 Introduction to R

# 1------------------------------------------------------------------------
library(tidyverse)
df <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/df.csv")

# Revised 2 ---------------------------------------------------------------
df %>%
  rename(ID = ...1) %>% #rename(cars, distance = dist)
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
  select(-...1) %>% #cleaning up new data by removing the id column
  arrange(V1, Variable, by_group = TRUE) %>% #attempt at rearranging data to match screenshot Variable is weird
  add_column(Sign = sign(df.2$Score)) #new column to add sign need to change it to char signs


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

#I am lost on how to proceed I have tried so many methods of trying to make a key that I can merge to actively compute a new column and nothing works


# 5 -----------------------------------------------------------------------
library(tidyverse)
copus <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/COPUS.csv")

df <- tibble(Variables = names(copus), Type = rep(c("Demographic", "Behavior", "Cluster"), c(8, 25, 2))) %>%
  rowwise() %>% mutate(NewVariable=paste(select(df, Variables),select(df, Type),sep='.'))
#I feel so close to completing the missing line I know its a new column made by adding the two characters together


# 6 -----------------------------------------------------------------------
library(tidyverse)
copus <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/COPUS.csv")
copus$Bcluster <- factor(copus$Bcluster, levels = c("Mostly lecture", "Transitioning", "High engagement"))
#I was able to make ggplot use a specific order of Bcluster by assigning them as factors with levels since ggplot follows the order now)
ggplot(data=copus,aes(x=Bcluster,y=Lec)) #simple ggplot to check x axis order


  
  
  
  


