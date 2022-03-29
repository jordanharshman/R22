# Libraries and Imports ---------------------------------------------------

library(tidyverse)

setwd("C:/Users/jth0083/Box/Teaching/CHEM 6450 Spring 2022/R22/Data") # set wd
copus <- read.csv("COPUS.csv") # read in copus data

# III.2 ggplot ------------------------------------------------------------

# create dataset that gives average of lecture for all class sizes broken down
# for just chemistry and biology:
copus.ds <- copus %>%
  filter(Broader %in% c("Biological", "Chemical")) %>%
  group_by(Broader, Size) %>%
  summarize(AvgLec = mean(Lec)) %>%
  na.omit()

ggplot(copus.ds, aes(x = Broader, y = AvgLec, fill = Size)) # map data, creates blank plot; no geometries added!

ggplot(copus.ds, aes(x = Broader, y = AvgLec, fill = Size)) + # map data
  geom_col(position = "dodge")                                # add column geometry, dodge columns

# III.3 Plot Elements -----------------------------------------------------

# Make columns narrower
ggplot(copus.ds, aes(x = Broader, y = AvgLec, fill = Size)) + 
  geom_col(position = "dodge", width = .5)                    # CHANGE: make columns narrower

# Stack the columns instead of dodging
ggplot(copus.ds, aes(x = Broader, y = AvgLec, fill = Size)) + 
  geom_col(position = "stack", width = .5)                    # CHANGE: make columns narrower
# geom_col(width = .5)                                        # "stack" is the default, so I could leave it

# Go back to dodging, let color represent Broader and x-axis represent Size
ggplot(copus.ds, aes(x = Size, y = AvgLec, fill = Broader)) + # CHANGE: map x to Size and fill to Broader
  geom_col(position = "dodge", width = .5)                    # CHANGE: go back to dodge

# Plot centered lecture variable (Lec – average(Lec) )
copus.ds <- copus.ds %>%                                      # CHANGE: need to compute new variable before plotting
  mutate(AvgLec.c = AvgLec - mean(copus$Lec))                 # compute new variable as centered Lec

ggplot(copus.ds, aes(x = Size, y = AvgLec.c, fill = Broader)) + # CHANGE: y mapping, new variable AvgLec.c
  geom_col(position = "dodge", width = .5)

# Get more gradients on y-axis
ggplot(copus.ds, aes(x = Size, y = AvgLec.c, fill = Broader)) + 
  geom_col(position = "dodge", width = .5) +
  scale_y_continuous(breaks = -7:7)                             # CHANGE: defined breaks for y-axis

# ...that was a bit overkill
ggplot(copus.ds, aes(x = Size, y = AvgLec.c, fill = Broader)) + 
  geom_col(position = "dodge", width = .5) +
  scale_y_continuous(breaks = seq(-6, 6, 2))                    # CHANGE: redefined breaks for y-axis

# Change the x-axis and y-axis label; they aren’t descriptive
ggplot(copus.ds, aes(x = Size, y = AvgLec.c, fill = Broader)) + 
  geom_col(position = "dodge", width = .5) +
  scale_y_continuous(breaks = seq(-6, 6, 2), 
                     name = "Centered Average Lecture") +       # CHANGE: place a y-axis label
  scale_x_discrete(name = "Class Size")
# + ylab("Centered Average Lecture") + xlab("Class Size")       # Quicker alternative

# Reorder the x-axis
copus.ds <- copus.ds %>%                                      # CHANGE: need to manipulate before plotting
  mutate(Size = factor(Size, levels = rev(unique(Size))))     # CHANGE: define Size as factor with levels

# Exact same code as previously run now produces different order (CHANGE: data)
ggplot(copus.ds, aes(x = Size, y = AvgLec.c, fill = Broader)) + 
  geom_col(position = "dodge", width = .5) +
  scale_y_continuous(breaks = seq(-6, 6, 2), 
                     name = "Centered Average Lecture") +       
  scale_x_discrete(name = "Class Size")

### March 22

# Expand label on x-axis to be more descriptive
ggplot(copus.ds, aes(x = Size, y = AvgLec.c, fill = Broader)) + 
  geom_col(position = "dodge", width = .5) +
  scale_y_continuous(breaks = seq(-6, 6, 2), 
                     name = "Centered Average Lecture") +       
  scale_x_discrete(labels = c("Small\n(<50)", "Medium\n(>50, <100)", "Large\n(>100)"), # CHANGE: labels
                   name = "Class Size")

# Change appearance of text
ggplot(copus.ds, aes(x = Size, y = AvgLec.c, fill = Broader)) + 
  geom_col(position = "dodge", width = .5) +
  scale_y_continuous(breaks = seq(-6, 6, 2), 
                     name = "Centered Average Lecture") +       
  scale_x_discrete(labels = c("Small\n(<50)", "Medium\n(>50, <100)", "Large\n(>100)"),
                   name = "Class Size") +
  theme(axis.text.x = element_text(color = "red"))            # CHANGE: make x-axis red font; we'll talk about colors

# Move the legend
ggplot(copus.ds, aes(x = Size, y = AvgLec.c, fill = Broader)) + 
  geom_col(position = "dodge", width = .5) +
  scale_y_continuous(breaks = seq(-6, 6, 2), 
                     name = "Centered Average Lecture") +       
  scale_x_discrete(labels = c("Small\n(<50)", "Medium\n(>50, <100)", "Large\n(>100)"),
                   name = "Class Size") +
  theme(axis.text.x = element_text(color = "red"),
        legend.position = "top")


# III.4 Example representations ----------------------------------------------

# Make a dataset that only contains chem/bio and just the two variables of interest:
LecBC <- copus %>%
  select(Broader, Lec) %>%
  filter(Broader %in% c("Chemical", "Biological"))

# Ideas to display Lec by Broader:

# stacked histograms, bins = 30
ggplot(LecBC, aes(x = Lec, fill = Broader)) +
  geom_histogram()

# stacked histograms, bins = 50
ggplot(LecBC, aes(x = Lec, fill = Broader)) +
  geom_histogram(bins = 50)

# facetted histograms, bins = 30
ggplot(LecBC, aes(x = Lec, fill = Broader)) +
  geom_histogram() +
  facet_wrap(~Broader)

# mirrored histograms, bins = 30
LecB <- LecBC %>%
  filter(Broader == "Biological") # keep only bio
LecC <- LecBC %>%
  filter(Broader == "Chemical")   # keep only chem

ggplot(LecB, aes(x = Lec, y = ..density.., fill = Broader)) +
  geom_histogram() +
  geom_histogram(data = LecC, aes(y = -..density..), fill = "#00BFC4")

# overlapped density, adjust = 1
ggplot(LecBC, aes(x = Lec, fill = Broader)) +
  geom_density(alpha = .8)

# overlapped density, adjust = .25
ggplot(LecBC, aes(x = Lec, fill = Broader)) +
  geom_density(adjust = .25, alpha = .8)

# facetted density, adjust = 1
ggplot(LecBC, aes(x = Lec, fill = Broader)) +
  geom_density() +
  facet_wrap(~Broader)

# mirrored density, adjust = 1
# LecB and LecC already created
ggplot(LecB, aes(x = Lec, y = ..density.., fill = Broader)) +
  geom_density() +
  geom_density(data = LecC, aes(y = -..density..), fill = "#00BFC4")
  
# boxplots
ggplot(LecBC, aes(x = Broader, y = Lec, fill = Broader)) +
  geom_boxplot()

# data points
ggplot(LecBC, aes(x = Broader, y = Lec, color = Broader)) +
  geom_point()

# jittered points
ggplot(LecBC, aes(x = Broader, y = Lec, color = Broader)) +
  geom_jitter(height = 1, width = .25, alpha = .3)

# bubbles
# need to compute sizes first; get dataset that has number of obs with rounded
# Lec of every value observed:
bubbleBC <- LecBC %>%
  mutate(rLec = round(Lec)) %>%
  group_by(rLec, Broader) %>%
  tally()

ggplot(bubbleBC, aes(x = Broader, y = rLec, size = n, color = Broader)) +
  geom_jitter(height = 1, width = .05, alpha = .6)

# violin plot
ggplot(LecBC, aes(y = Lec, x = Broader, fill = Broader)) +
  geom_violin()

# dotplot
ggplot(LecBC, aes(x = Lec, y = ..count.., fill = Broader)) +
  geom_dotplot(stackratio = .15) 

# ridgeline plot...?
library(ggridges)
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges()

# ridgeline plot... binlines?
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline")

# averages, points
# need to make the averages data first (saving sd as well):
LecBCavg <- copus %>%
  filter(Broader %in% c("Biological", "Chemical")) %>%
  group_by(Broader) %>%
  summarize(Avg = mean(Lec),
            SD = sd(Lec))

ggplot(LecBCavg, aes(x = Broader, y = Avg, color = Broader)) +
  geom_point(size = 4)

# averages, bars
ggplot(LecBCavg, aes(x = Broader, y = Avg, fill = Broader)) +
  geom_bar(stat = "identity")

# averages, error bars
# need to manipulate high/low values:
LecBCavg <- LecBCavg %>%
  mutate(low = Avg - SD,
         high = Avg + SD)

ggplot(LecBCavg, aes(x = Broader, y = Avg, color = Broader)) +
  geom_point(size = 4) +
  geom_errorbar(aes(ymin = low, ymax = high))

# DYNAMITE PLOTS; BEWARE!!!!!!!!!!!!!
ggplot(LecBCavg, aes(x = Broader, y = Avg, fill = Broader, color = Broader)) +
  geom_bar(stat = "identity") +
  geom_errorbar(aes(ymin = low, ymax = high))

# Frankenstein combo
ggplot(LecBC, aes(x = Broader, y = Lec, fill = Broader, color = Broader)) +
  geom_boxplot(alpha = 0) + 
  geom_violin(alpha = 0) +
  geom_jitter(height = 1, width = .25, alpha = .3) +
  geom_point(data = LecBCavg, aes(y = Avg), size = 4, shape = 21, color = "Black") +
  geom_errorbar(data = LecBCavg, aes(y = Avg, ymin = low, ymax = high), color = "Black")

# III.4 Making detailed plot ----------------------------------------------

library(ggridges) # if you haven't done so already

# Make a dataset that only contains chem/bio and just the two variables of interest:
LecBC <- copus %>%
  select(Broader, Lec) %>%
  filter(Broader %in% c("Chemical", "Biological"))

# Starting point, let's make a plot:
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline")

# Legend is redundant
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline") +
  theme(legend.position = "none")                          # CHANGE: remove legend

# Change labels
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline") +
  scale_x_continuous(name = "% Time Spent Lecturing") +    # CHANGE: change label
  scale_y_discrete(name = "Discipline") +                  # CHANGE: change label
  theme(legend.position = "none")

# remove grey background
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline") +
  scale_x_continuous(name = "% Time Spent Lecturing") +    
  scale_y_discrete(name = "Discipline") + 
  theme_bw() +                                            # CHANGE: change theme
  theme(legend.position = "none")

# remove gridlines
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline") +
  scale_x_continuous(name = "% Time Spent Lecturing") +    
  scale_y_discrete(name = "Discipline") + 
  theme_bw() +                                            
  theme(legend.position = "none",
        panel.grid = element_blank())                     # CHANGE: remove gridlines

# feel the school spirit
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline") +
  scale_x_continuous(name = "% Time Spent Lecturing") +    
  scale_y_discrete(name = "Discipline") + 
  scale_fill_manual(values = c("#03244d", "#dd550c")) +   # CHANGE: Auburn colors
  theme_bw() +                                            
  theme(legend.position = "none",
        panel.grid = element_blank())

# give it a title
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline") +
  scale_x_continuous(name = "% Time Spent Lecturing") +    
  scale_y_discrete(name = "Discipline") + 
  scale_fill_manual(values = c("#03244d", "#dd550c")) +   
  ggtitle("Lecturing:", subtitle = "Biologists compared to chemists") + # CHANGE: title
  theme_bw() +                                            
  theme(legend.position = "none",
        panel.grid = element_blank())

# center title
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline") +
  scale_x_continuous(name = "% Time Spent Lecturing") +    
  scale_y_discrete(name = "Discipline") + 
  scale_fill_manual(values = c("#03244d", "#dd550c")) +   
  ggtitle("Lecturing:", subtitle = "Biologists compared to chemists") + 
  theme_bw() +                                            
  theme(legend.position = "none",
        panel.grid = element_blank(),
        plot.title = element_text(hjust = .5),                        # CHANGE: center title
        plot.subtitle = element_text(hjust = .5))                     # CHANGE: center subtitle

# center title
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline", scale = 7) +                  # CHANGE: tweak the scale
  scale_x_continuous(name = "% Time Spent Lecturing") +    
  scale_y_discrete(name = "Discipline") + 
  scale_fill_manual(values = c("#03244d", "#dd550c")) +   
  ggtitle("Lecturing:", subtitle = "Biologists compared to chemists") + 
  theme_bw() +                                            
  theme(legend.position = "none",
        panel.grid = element_blank(),
        plot.title = element_text(hjust = .5),
        plot.subtitle = element_text(hjust = .5))

# change tick marks, need to change data
LecBC <- LecBC %>%
  mutate(Broader = recode(Broader, "Biological" = "Biologists",
                          "Chemical" = "Chemists"))

ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline", scale = 7) +                  
  scale_x_continuous(name = "% Time Spent Lecturing") +    
  scale_y_discrete(name = "Discipline") + 
  scale_fill_manual(values = c("#03244d", "#dd550c")) +   
  ggtitle("Lecturing:", subtitle = "Biologists compared to chemists") + 
  theme_bw() +                                            
  theme(legend.position = "none",
        panel.grid = element_blank(),
        plot.title = element_text(hjust = .5),
        plot.subtitle = element_text(hjust = .5))

# final plot...?
ggplot(LecBC, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline", scale = 7, alpha = .9, color = "black", bins = 35) +
  scale_x_continuous(name = "% Time Spent Lecturing", limits = c(-2,104)) +    
  scale_y_discrete(name = NULL) + 
  scale_fill_manual(values = c("#03244d", "#dd550c")) +   
  ggtitle("Lecturing:", subtitle = "Biologists compared to chemists") + 
  theme_minimal() +                                            
  theme(legend.position = "none",
        panel.grid = element_blank(),
        plot.title = element_text(hjust = .5, vjust = -20),
        plot.subtitle = element_text(hjust = .5, vjust = -22))

# Side note: good for plotting every discipline if that's the RQ
Lec <- copus %>%
  select(Broader, Lec) %>%
  filter(Broader != "Missing")

ggplot(Lec, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_density_ridges(stat = "binline", scale = 3, alpha = .9, color = "black", bins = 35) +
  scale_x_continuous(name = "% Time Spent Lecturing", limits = c(-2,104)) +    
  scale_y_discrete(name = NULL) + 
  scale_fill_brewer(palette = "Set1") +   
  ggtitle("Lecturing:", subtitle = "Comparison of all disciplines") + 
  theme_minimal() +                                            
  theme(legend.position = "none",
        panel.grid = element_blank(),
        plot.title = element_text(hjust = .5),
        plot.subtitle = element_text(hjust = .5))

# III.5 Familiarity with Geoms ------------------------------------------------------

# geom_point()
ggplot(copus, aes(x = Lec, y = L)) +
  geom_point() # significant overlap

# geom_jitter()
ggplot(copus, aes(x = Lec, y = L)) +
  geom_jitter() # helped the overlap, but not much

# geom_smooth
ggplot(copus, aes(x = Lec, y = L)) +
  geom_smooth(method = "lm", se = FALSE) # loess smooth by default, use method = lm for y=mx+b

# geom_smooth()
ggplot(copus, aes(x = Lec, y = L)) +
  geom_count() # has to be exact match, probably want rounded matches

# geom_rug() (combined with geom_point())
ggplot(copus, aes(x = Lec, y = L)) +
  geom_point() + # significant overlap
  geom_rug() # significant overlap

# geom_bar()
ggplot(copus, aes(x = Broader)) +
  geom_bar() # will tally these things for you

  # if you've already tallied...
  Disciplines <- copus %>%
    group_by(Broader) %>%
    tally()
  
  ggplot(Disciplines, aes(x = Broader)) +
    geom_bar() + # obviously incorrect, counted 1 of everything!
    ylab("Whatever")
  
  ggplot(Disciplines, aes(x = Broader, y = n)) +
    geom_bar() # error, can't have a y variable
  
  ggplot(Disciplines, aes(x = Broader, y = n)) +
    geom_bar(stat = "identity") # tells it not to calculate it's own counts

# March 24
  
# geom_histogram()
ggplot(copus, aes(x = RTW)) +
  geom_histogram() # basic histogram
  
# geom_density()
ggplot(copus, aes(x = RTW)) +
  geom_density() # basic density plot

# geom_violin(), which are two density plots mirrored to form a shape
ggplot(copus, aes(x = "RTW", y = RTW)) + # need to define some label to hold the value
  geom_violin()

# geom_boxplot()
ggplot(copus, aes(y = RTW)) +
  geom_boxplot() # computes the boxplot for us

# geom_errorbar()
# need to do some manipulation first: compute average and sd (not efficient)
errbar <- copus %>%
  select(RTW) %>%
  summarize(Avg = mean(RTW),
            Sd = sd(RTW)) %>%
  mutate(high = Avg + Sd,
         low = Avg - Sd)

ggplot(errbar, aes(x = "RTW", y = Avg, ymin = low, ymax = high)) + # need a few more aesthetics
  geom_errorbar() + # plot the errorbar
  geom_point(size = 4)

# geom_line()
# filter out Ins 8 and create a dummy obs 1:number of rows
Ins8 <- copus %>%
  filter(Instructor.ID == 8) %>%
  mutate(Obs = 1:n())

ggplot(Ins8, aes(x = Obs, y = Lec)) +
  geom_line()

# geom_segment()
ggplot(Ins8, aes(x = Obs, y = Lec, xend = Obs, yend = 0)) +
  geom_segment()

# geom_curve()
ggplot(Ins8, aes(x = Obs, y = Lec, xend = Obs, yend = 0)) +
  geom_curve()

# geom_text()
ggplot(Ins8, aes(x = Lec, y = T_PQ, label = Obs)) +
  geom_text()

# geom_label()
ggplot(Ins8, aes(x = Lec, y = T_PQ, label = Obs)) +
  geom_label()

# III.6 Facets ------------------------------------------------------------

# Problem with making individual plots:
#   Creation of several objects:
copus.s <- copus %>%
  filter(Size == "Small")
copus.m <- copus %>%
  filter(Size == "Medium")
copus.l <- copus %>%
  filter(Size == "Large")

#  Code is repetitive:
ggplot(copus.s, aes(x = Lec)) +
  geom_histogram() +
  ggtitle("Small")

ggplot(copus.m, aes(x = Lec)) +
  geom_histogram() +
  ggtitle("Medium")

ggplot(copus.l, aes(x = Lec)) +
  geom_histogram() +
  ggtitle("Large")

# Solution: facets
# going to get rid of the missing data from Size first:
copus.size <- copus %>%
  filter(!is.na(Size))

ggplot(copus.size, aes(x = Lec)) +
  geom_histogram() +
  facet_wrap(~Size)

# "free the scales"
ggplot(copus.size, aes(x = Lec)) +
  geom_histogram() +
  facet_wrap(~Size, scales = "free_y")

# generate density plot for each cluster
ggplot(copus, aes(x = Lec)) +
  geom_density(fill = "grey50") +
  facet_wrap(~Cluster)

# For a plot like this, we need to worry about how many people are being represented.
# It looks like Cluster 6 is flat, but they aren't, it's just that there aren't a lot
# of people in it compared to the others. We can "free the scales" for this purpose:

ggplot(copus, aes(x = Lec)) +
  geom_density(fill = "grey50") +
  facet_wrap(~Cluster, scales = "free_y")

# Which discipline allows class size to regulate cluster assignment?
# modify data first to eliminate missing data
copus.m <- copus %>%
  filter(!is.na(Size), Broader != "Missing") %>%
  mutate(Cluster = as.character(Cluster)) # making this character allows us to color them

# Proof of concept: make a non-facetted plot first:
ggplot(copus.m, aes(x = Cluster, fill = Cluster)) +
  geom_bar() +
  guides(fill = "none") # alternative way to remove a legend

ggplot(copus.m, aes(x = Cluster, fill = Cluster)) +
  geom_bar() +
  guides(fill = "none") +
  # "broken down by: Size
  facet_wrap(~Size)

ggplot(copus.m, aes(x = Cluster, fill = Cluster)) +
  geom_bar() +
  guides(fill = "none") +
  facet_wrap(~Broader)


# contrast to facet_grid(); you can only free the scales by row (or by column), 
# you can't completely free all scales
ggplot(copus.m, aes(x = Cluster, fill = Cluster)) +
  geom_bar() +
  guides(fill = "none") +
  facet_grid(Size~Broader, scales = "free_y") # facet by discipline

# With faceting, their is always more than one option. We are displaying 3 variables,
# so you can mix and match them:
ggplot(copus.m, aes(x = Cluster, fill = Cluster)) +
  geom_bar() +
  guides(fill = "none") +
  facet_wrap(Broader~Size, scales = "free_y", nrow = 7) # flipped of previous

ggplot(copus.m, aes(x = Broader, fill = Cluster)) + # CHANGE: plot discipline on x-axis
  geom_bar() +
  guides(fill = "none") +
  facet_wrap(Size~Cluster, scales = "free_y", nrow = 3) + # CHANGE: facet by Cluster 
  theme(axis.text.x = element_text(a = 270, hjust = 0, vjust = .25)) # rotate the x-axis labels

# Task 1 ------------------------------------------------------------------


# III.7 Plot details: Colors ------------------------------------------------------
# compare only chem to bio instructors on Lec distribution (object exists from waaaay above)

# default colors:
ggplot(LecBC, aes(x = Broader, y = Lec, fill = Broader)) +
  geom_boxplot()

# choose color from color picker: bold!
ggplot(LecBC, aes(x = Broader, y = Lec, fill = Broader)) +
  geom_boxplot() +
  scale_fill_manual(values = c("#2cf00e", "#e31ced"))

# choose color from a "professional" palette: business
# https://visme.co/blog/website-color-schemes/   I choose #2 "Bright Accent Colors"
ggplot(LecBC, aes(x = Broader, y = Lec, fill = Broader)) +
  geom_boxplot() +
  scale_fill_manual(values = c("#242582", "#F64C72"))

# choose color from RColor Brewer: Pastels!
ggplot(LecBC, aes(x = Broader, y = Lec, fill = Broader)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Pastel1")

# choose color from an image: The Spongebob graph!
ggplot(LecBC, aes(x = Broader, y = Lec, fill = Broader, color = Broader)) +
  geom_boxplot(size = 2) +
  scale_fill_manual(values = c("#FFF75F", "#F6A3A5")) +
  scale_color_manual(values = c("#DC9234", "#D2DC22")) +
  theme_minimal()

# III.7 Plot details: Google ----------------------------------------------

ggplot(copus, aes(x = Lec, y = RTW, color = L)) +
  geom_jitter() +
  theme_bw() +
  scale_color_grey()

# III.7 hjust / vjust -----------------------------------------------------

# https://stackoverflow.com/questions/7263849/what-do-hjust-and-vjust-do-when-making-a-plot-using-ggplot

# March 29

# III.8 Exporting Graphs --------------------------------------------------

ggplot(copus, aes(x = Lec, y = Broader, fill = Broader)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Set1") +
  theme_minimal() + 
  xlab("Percent of Class Lecturing") +
  ylab("Discipline") +
  ggtitle("Lecture Time by Discipline") +
  theme(legend.position = "none",
        plot.title = element_text(hjust = .5))

# 72 dpi, small image (5 kb)
ggsave("boxLec_disc_low.png",
       height = 214,
       width = 518,
       units = "px",
       dpi = 72)

# 600 dpi, large image (5 kb)
ggsave("boxLec_disc_high.png",
       height = 214 * 8.33,
       width = 518 * 8.33,
       units = "px",
       dpi = 72 * 8.33)

# increase resolution without increasing image size:
ggsave("boxLec_disc_wonky.png",
       height = 214,
       width = 518,
       units = "px",
       dpi = 72 * 8.33)

# 1200 dpi, very large image (185 kb), notice this took a second
ggsave("boxLec_disc_ultra.png",
       height = 214 * (1200 / 72),
       width = 518 * (1200 / 72),
       units = "px",
       dpi = 72 * (1200 / 72))

df <- data.frame(x = 1:5, y = 1:5)

# vector file, small image (8 kb)
ggsave("boxLec_disc_vec.pdf",
       height = 214,
       width = 518,
       units = "px",
       dpi = 72)

# vector file, medium image (5 kb), jumbled mess
ggsave("boxLec_disc_vec_med.pdf",
       height = 214,
       width = 518,
       units = "px",
       dpi = 600)

df <- data.frame(x = 1:3, y = 1:3)
ggplot(df, aes(x = x, y = y)) +
  geom_point()

# df medium resolution
ggsave("df_low_res.pdf",
       height = 214,
       width = 518,
       units = "px",
       dpi = 100)

# df doubled resolution
ggsave("df_dbl_res.pdf",
       height = 214,
       width = 518,
       units = "px",
       dpi = 200)

# df medium resolution, in inches
ggsave("df_low_res_in.pdf",
       height = 2,
       width = 2,
       units = "in",
       dpi = 100)

# df doubled resolution, in inches
ggsave("df_dbl_res_in.pdf",
       height = 2,
       width = 2,
       units = "in",
       dpi = 200)










