#Junwei Wang
#Assignment 2 
# 1. ----------------------------------------------------------------------
#II.3 Import the df.csv data to an object called “df”. 
library(tidyverse)
setwd("~/Desktop/R22-main 2/data")
df<-read.csv("df.csv")

# 2. ----------------------------------------------------------------------
#2.	II.4 In one continuous statement connected by piping operators, making the following changes to df and store it as df2:
df2<-df %>%
  rename("ID"="X")%>% #a.Rename “X1” as “ID”
  mutate(V2=abs(V2),V3=abs(V3),V4=abs(V4),V5=abs(V5),V6=abs(V6))%>% #b.	All negative values in Variables V2 though V6 should have been positive (all values will be positive for these variables); change this
  
  ## --- pH --- ## FYI can condense into: mutate(across(V2:V6, abs))
  
  mutate(V7=if_else(V7<(-0.9),NA_real_,V7))%>% #c.	Any obs with V7 less than -0.9 is an outlier; replace these instances with NA, but do not remove the rest of their data. 
  filter(V1!="D")%>% #d.	Get rid of all observations where V1 is “D”
  arrange(V1, desc(V2))%>% #e.	Sort the data by V1 (A to C) and within each category, in decreasing V2
  group_by(V1)%>% 
  summarize(Mean=mean(V2),SD=sd(V2))#f.	Calculate the mean and standard deviation of V2 for each category of V1


# 3 -----------------------------------------------------------------------
#3.II.5 Ignoring all modifications in #2 and starting from a fresh import of df.csv, modify the data into an object called df.l that matches the screenshot here:
df1<-df%>%
  select(V1:V11)%>% #select only V1 to V11 columns
  pivot_longer(-V1, "Variable")%>% #pivot, using V1 as the key variable, and others are named as "Variable"
  rename("Score"="value") %>% #rename the default "value" column as "Score"
  mutate(SignScore=if_else(Score<0,"-","+"))# make a variable call "SignSocre" that mark all the negative values in "Variable" with "-" and positive ones with "+"

## --- pH --- ## Can rename variables within pivot: pivot_longer(-V1, "Variable", values_to = "Score")

# 4 -----------------------------------------------------------------------
#4.	II.6  
key<-df%>% #create this "key" datasheet, which will joined into df1 later.
  select(V1:V11)%>% #select only V1 to V11 columns
  pivot_longer(-V1, "Variable")%>% #pivot, using V1 as the key variable, and others are named as "Variable"
  rename("Score"="value") %>% #rename the default "value" column as "Score"
  mutate(V1_num_assign=recode(V1,"A"=0*10,"B"=1*10,"C"=2*10,"D"=3*10)) %>%# replace ABCD with the tens digit value they are supposed to be
  mutate(Variable_num_assign=rep(1:10,times=100,each=1))%>%#assign numbers for V2:V11 to get 1000 rows
  mutate(NewValue=V1_num_assign+Variable_num_assign)#make a NewValue variable by adding the tens digit of ABCD group corresponding values and V2:V11 corresponding values 
joined<-key%>% #create joined file for the combined the df1 and the key dataframe
  select(V1, Variable, Score, NewValue)%>% #select the columns that wanted to combined with df1. I worried about mismatch since that the "NewValue" data is repeated, so I select multiple variables to join.
  left_join(df1)#join df1
joined<-joined[,c("V1","Variable","Score", "SignScore","NewValue")]#rearrange the order of the columns

## --- pH --- ## Works, but you are fundamentally doing soething different that what I asked

# 5 ----------------------------------------------------------------------
#II.7 Study the code section below that has one line that has been redacted. What is the redacted line?
copus<-read.csv("COPUS.csv")
f<-tibble(Variables=names(copus), Type=rep(c("Demographic","Behavior","Cluster"),c(8,25,2)))%>%
  mutate(NewVariable=str_c(Type, Variables, sep="."))# This line is the redacted line.


# 6 -----------------------------------------------------------------------
#6.	II.8 One problem (of many) with the following plot is that the x-axis should be presented in the order of “Mostly lecture”, followed by “Transitioning”, and finally “High engagement”. Modify the copus data (Bcluster is on the x-axis) so that this variable will show up correctly in the plot. 
copus%>%
  mutate(Bcluster=fct_relevel(Bcluster,"Mostly lecture","Transitioning","High engagement"))%>% #relevel the x-axis "Bcluster" with the new order
  ggplot(aes(x=Bcluster,y=Lec))+geom_boxplot()#generate the boxplot for it
  
  

