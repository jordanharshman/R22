# Yousif Muten
# Assignment 2 introction to R
# Questions 1&2 import the df.csv data to and object and called "df" and use the pipe --------


df<-read.csv("df.csv") # import the df.csv data and called it df
df2 <- df %>% # use the pipe to make the changes a-f and store it as df2
  rename(ID="X") %>% # rename the X as ID
  mutate(across(V2:V6, abs),  # change negative values to positive values in Variables V2 through V6
         V7 = if_else(V7 < -0.9, NA_real_, V7)) %>% # replace any obs with V7 less than - 0.9 with NA
  filter(V1 !="D") %>% # get rid of all observations where V1 is "D"
  group_by(V1) %>% # group by V1
  arrange(desc(V2)) %>% # arrange in decreasing V2
  summarize(mean(V2), sd(V2)) # calculate the mean and sd of V2 for each V2



# #11.5 creating new object from the original data and called it df.1 that matches the screenshot.... --------


df.1<- df %>% # take df, then ...
  select(V1, V2:V11) %>% # select only variables that need to be pivoted
  pivot_longer(-V1, "Variable") %>% # pivot, not including V1, and name the new variable "Variable"
  rename(Score = value)%>% # change the name of the variable " value" to "Score"
  mutate(SignScore = (sign(Score))) # create a new variable called SignScore that return the sign of numeric elements in "Score"

###---pH---### Didn't actually put a + or - here, but that's okay

# II.6 Create dataset "Key" and join it to df.1 ------------------------------


Key <- data.frame(NewValue = c(1:1000), 
                                V1 = (df.1$V1),
                                Variable = (df.1$Variable)) # create dataset that has 3 variables havs common variables with df.1
Key %>% left_join(df.1)      # left join    

a <- Key.1 %>% right_join(df.1) # here I am trying to find another way to solve it but still not working!
b= filter(a,V1 == "A" , Variable == "V2"),
                                   

# Question 5 What is the redacted line? -----------------------------------
###---pH---### Nowhere in the script do you ever bring in the COPUS data set?
###---pH---### -0.5

df <- tibble(Variables = names(copus),
                  type = rep(c("Demographic", "Behavior", "Cluster"), c(8, 25, 2) %>% 
                               unite("NewVariable", type:Variables, remove = FALSE, sep = "."))) # when i did it this way it keeps giving me error
                  
df %>% unite("NewVariable", type:Variables, remove = FALSE, sep = ".") # But this way worked just fine, # paste 2 variables into 1

###---pH---### I am generating error on df; the problem is the ending of your parentheses:
### Line 46 should have 2 additional )'s to close off the rep() and tibble() functions; then the extra two )'s in Line 47 should be removed.
### -0.5

# Question 6: Modify the copus data Bcluster is on the x-axis) so  --------


copus <- copus %>% 
  mutate(Bcluster = factor(Bcluster, levels = c("Mostly lecture","Transitioning", "High engagement")))
mod <- aov(Lec ~ Blucter, data = copus) # define anova model, Lec = DV; Bcluster = IV
TukeyHSD(mod) # posthoc tests occur in order set by factor now
# make boxplot by Bcluster.
ggplot(copus, aes(x = Bcluster, y = Lec)) +
  geom_boxplot()



