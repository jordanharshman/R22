
### --- pH --- ### No comments
### -1

# #! ----------------------------------------------------------------------

ggplot(copus, aes(y = Lec)) +
  geom_boxplot() 

# #2 ----------------------------------------------------------------------

copus <- copus %>%
  filter(!is.na(Size))
ggplot(copus, aes(x = Size)) +
  geom_bar() #creating bar chart

# #3 ----------------------------------------------------------------------

copus <- copus %>%
  filter(!is.na(Size)) #filtering out NA’s
ggplot(copus, aes(x = Broader)) +
  geom_bar() +
  facet_wrap(~Size) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# #4 ----------------------------------------------------------------------

copus <- copus %>%
  ungroup()
copus.a <- copus %>%
  group_by(Broader) %>%
  summarize(AvgLec = mean(Lec))
ggplot(copus.a, aes(x=Broader, y = AvgLec)) + geom_point()

# #5 ----------------------------------------------------------------------

copus <- copus %>%
  group_by(Broader) %>%
  summarize(c(AvgLec = mean(Lec)), Lec) %>%
  rename(“AvgLec = mean(Lec))”)
ggplot(copus, aes(x = Broader, y = Lec)) +
  geom_boxplot() +
  geom_point(aes(x = Broader, y = AvgLec, colour = “red”)) #creating red mean point


### --- pH --- ### Generates an error for me: I think you are trying to keep Lec in there for later use, but that data isn't going to help
### because you'll need Lec for all variables, not just the 8 summaries.
# -0.5


# #6 ----------------------------------------------------------------------
Copus <- copus %>%
  Group_by(Broader) %>%
  sapply()(FUN_simplify = TRUE, USE.NAMES = TRUE)

Sapply(copus, class)
copus[3] <- sapply(copus[3],as.character) #need to have character, column 3
copus[4] <- sapply(copus[4],as.character) #need to have character, column 4

copus[5] <- sapply(copus[5],as.character) #need to have character, column 5
copus <- copus %>%
  pivot_longer(cols = CG:OG, names_to = “GroupWork”) %>% #create GroupWork
  #pivot around GroupWork
  
  group_by(“GroupWork”)
copus <- copus %>%
  group_by(Broader)

sapply(copus, class) #change values to numeric to plot
copus[4] <- sapply(copus[4], as.numeric)
ggplot(copus, aes( x = “GroupWork”,  y = value, fill = Broader)) +
  geom_boxplot () +
  geom_point () +
  facet_wrap(~Size)

### --- pH --- ### Why did you convert to character variable in lines 71-73? You endd up converting them
### back in line 83? Could not get code to run; error about the "Groupwork in the top of the line
# -0.5

# #7 ----------------------------------------------------------------------

ggplot(copus, aes( x = `Group Work`, y = value, fill = Broader)) +
  geom_boxplot(outlier.shape = NA)+
  ylim(0,60) +
  facet_wrap(~Size) 

ggsave("Data_Vis.pdf",
       height = 2,
       width = 6,
       units = "in",
       dpi = 72)

### --- pH --- ### Recall that dpi doesn't do anything in vector files, code would work if you had produced a plot 

