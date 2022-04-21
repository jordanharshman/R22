#Adelia Grabowsky
#Assignment 3 Data Visualizations

library(tidyverse)

setwd("C:/Users/abg0011/Documents/CHEM_6450/datafiles")
copus <- read_csv("COPUS.csv")


# #1 ----------------------------------------------------------------------
#Here's my code with adequate commenting
#creating a box plot of Lec variable

ggplot(copus, aes(y = Lec)) +
  geom_boxplot() 



# #2 ----------------------------------------------------------------------
#Here's my code with adequate commenting
#notes- no need to factor because sizes are alphabetical on x-axis

copus.2 <- copus %>% #new object from copus data
  group_by(Size) %>% #grouping by size
  filter(!is.na(Size)) %>% #filtering out rows where size is missing
  count() #counting number of each size group

ggplot(copus.2, aes(x = Size, y = n, fill = Size)) + 
  #creating graphic with size on x, count on y, fill color by size
  geom_col(position = "dodge") + 
  #graphic of columns, dodge so that columns are not stacked (default is stacked)
  scale_fill_manual(values = c("#000000", "#000000", "#000000")) + 
                      scale_y_continuous(name = "count") + 
  #changing shape color to black and y label from n to count
  theme(legend.position = "none") 
#removing legend

### --- pH --- ### FYI you can use geom_bar() to have the stat count it for you

# #3 ----------------------------------------------------------------------
#Here's my code with adequate commenting

copus.3 <- copus %>% #creating a new object from copus data
  select(Broader, Size) %>% #selecting broader and size columns
  group_by(Broader, Size) %>% #grouping by broader and size
  filter(Size !="Missing") %>% #removing rows where size is missing
  count(Broader) #counting instances of broader(discipline)
  
ggplot(copus.3, aes(x = Broader, y = n, fill = Size)) + 
  #creating graphic with Broader on x and count on y
    geom_col(position = "dodge") + 
  #graphic is columns that are not stacked
  facet_wrap(~Size) + 
  #breaking info into 3 groups by size
  scale_y_continuous(name = "count") + 
  #changing y axis label to count (instead of n)
  scale_fill_manual(values = c("#000000", "#000000", "#000000")) +
  #changing fill of shapes to black
  theme(axis.text.x = element_text(angle=270), legend.position = "none") 
#rotating text of x labels, removing legend

scale_fill
# #4 ----------------------------------------------------------------------
#Here's my code with adequate commenting

copus.4 <- copus %>% #creating new object from copus data
  group_by(Broader) %>% #grouping by broader
  summarize(AverageLec = mean(Lec)) #computing the average lecture for each 
#instance of broader, i.e. for each discipline
         
ggplot(copus.4, aes(x = Broader, y = AverageLec, color = Broader)) + 
  #creating graphic with Broader on x and average of lecture on y, fill color by broader
  geom_point(data = copus.4, aes(y = AverageLec), color = "Black") +
  #graphic will be black points
  theme(legend.position = "none")
#removing legend


    

# #5 ----------------------------------------------------------------------
#Here's my code with adequate commenting
#done 

copus.5 <- copus %>% #creating new object from copus data
  select(Broader, Lec) %>% #selecting broader and lecture columns
  group_by(Broader) #grouping by broader

ggplot(copus.5, aes(x = Broader, y = Lec, fill = Broader)) +
  #creating graphic with broader on x and lecture on y, fill color will be by broader
  geom_boxplot() + #graphic will be a boxplot
  scale_fill_manual(values = c("#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF")) +
  #changing boxes to white rather than default colors
  geom_point(data = copus.4, aes(y = AverageLec), color = "Red") +
  #adds a point for the average of lecture for each discipline using the previous
  #copus.4 data, colors the point red
  theme(legend.position = "none") #removing the legend

# #6 ----------------------------------------------------------------------
#Here's my code with adequate 
#done

copus.6 <- copus %>% #creating new object from copus data
  select(Broader, Size, CG:OG) %>% #selecting broader, size, CG, WG, and OG
  filter(Size !="Missing") %>% #removes rows where size is missing
  pivot_longer(!c(Broader, Size), names_to = "GroupWork", 
    values_to = "Percent") %>% #pivots CG, WG, OG to a new variable named groupwork
  #with values named percent, does not pivot Broader or size
  group_by(GroupWork) #groups by groupwork (i.e CG, WG, OG)


ggplot(copus.6, aes(x = GroupWork, y = Percent, fill=Broader)) +
  #creates a graphic with groupwork on x and percent on y and colored by broader
  geom_boxplot(outlier.color = "Black") + #graphic is a boxplot
  facet_wrap(~Size) 
#divides the data into 3 groups by size, large, medium, small



# #7 ----------------------------------------------------------------------
#Here's my code with adequate commenting

#a code from previous plot

copus.6 <- copus %>% #creating new object from copus data
  select(Broader, Size, CG:OG) %>% #selecting broader, size, CG, WG, and OG
  filter(Size !="Missing") %>% #removes rows where size is missing
  pivot_longer(!c(Broader, Size), names_to = "GroupWork", 
               values_to = "Percent") %>% #pivots CG, WG, OG to a new variable named groupwork
  #with values named percent, does not pivot Broader or size
  group_by(GroupWork) #groups by groupwork (i.e CG, WG, OG)


ggplot(copus.6, aes(x = GroupWork, y = Percent, fill = Broader)) +
  #creates a grahic with Groupwork on x, percent on y, and colored by broader
  geom_boxplot(outlier.shape = NA) + #bi. removing outlier points
  scale_y_continuous(limits=c(0,60)) + #bii changing upper limit of y axis
  facet_wrap(~Size)

#c. saving to a 6" wide by 2" tall pdf

ggsave("copus6_boxplot.pdf",
       height = 2,
       width = 6,
       units = "in",
       dpi = 100)

### --- pH --- ### Recall that dpi does not affect vector plots



