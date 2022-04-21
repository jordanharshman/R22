# Covie Rigdon
# Assignment 1 Introduction to R

# #1 ----------------------------------------------------------------------
x <- 1:5 #defined a object x with 1-5 numeric elements
x2 <- x + 1 #defined a new object with object x adding 1 to each element

# 2 -----------------------------------------------------------------------
set.seed(42)
exp <- rnorm(100, 1.1, .1) # experimental
set.seed(42)
con <- rnorm(100, 1, .1) # control
d <- (mean(exp)-mean(con))/(sqrt(sd(exp)+sd(con))/2) #Cohens d with exp and con

### I'm getting a different value than you; it seems you are missing the squared components of the sd's
### -.5

# 3 -----------------------------------------------------------------------

data <- seq(0, 200, .5) #a object named data from 0 - 200 counting by .5
set.seed(42)
dat.sample <- sample(data, 50, replace = FALSE) #sampling 1 - 50 data points
dat.sample.sort <- sort(dat.sample, decreasing = FALSE) #sorting dat.sample into a new obj
min <- dat.sample.sort [1] #lowest number
q1 <- ((dat.sample.sort[12]+dat.sample.sort[13])/2) #25% number
median <- dat.sample.sort [25] #median number
q3 <- ((dat.sample.sort[37]+dat.sample.sort[38])/2) #75 percent number
max <- dat.sample.sort [50] #max number

### works, but check out summary()

# 4 -----------------------------------------------------------------------
set.seed(42)
grades <- rnorm(200, mean = 80, sd = 20) #data set with 200 numbers with a mean at 80 with a sd of 20
grades[grades>100]<- 100 #replaces all values over 100 with 100
grades <- sort(grades, decreasing = FALSE)  #sorting grades
top.third.grades <- grades[133:200] #grabbing the top 1/3 grades manually

### I encourage you to find ways to avoid absolute coding

top.third.grades.avg <- mean(top.third.grades)
top.third.grades.sd <- sd(top.third.grades)
grades.breaks <- c(0, 59.995, 69.995, 79.995, 89.995, 100) #assigning values to be used as breaks in creating a data table it goes 0-60, 60-70 etc can see in levels under group_tags
tags <- c("F", "D", "C", "B", "A") #labels for the data table SAME LENGTH AS BREAKS (levels) 
group_tags <- cut(grades, grades.breaks, tags) #cut takes grades and uses the other two arguments to classify the data

### good use of cut() here

### I see you've been reading ahead or have prior experience!
### However, you didn't library(ggplot2), fyi :)

ggplot(data = as_tibble(group_tags), mapping = aes(x=value)) + #the data for the plot to use and graph across the x axis
  geom_bar(fill="bisque",color="white",alpha=0.7) + #type of plot and format
  stat_count(geom="text", aes(label=sprintf("%.4f",..count../length(group_tags))), vjust=-0.5) + #setting up the format for displaying the length of each group tags
  labs(x='Grade') + #x label
  theme_minimal() #Used a guide online to count and plot the grades following a example ggplot
