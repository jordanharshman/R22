
### --- pH --- ### No comments
### -1

# #! ----------------------------------------------------------------------

ggplot(copus, aes(y=Lec)) + geom_boxplot()


# #2 ----------------------------------------------------------------------

copus <- copus %>%
  filter(!is.na(Size))
ggplot(copus, aes( x = Size)) + geom_bar()


# #3 ----------------------------------------------------------------------

copus <- copus %>%
  filter(!is.na(Size)) %>%
  
### --- pH --- ### Error; you should get rid of the pipe here; can't mix %>% from pipe and + from ggplot.
### Also, you missed the text rotation
  # -0.5
  
  ggplot(copus, aes(x=Broader))+
  geom_bar()+
  facet_wrap(~Size)


# #4 ----------------------------------------------------------------------

copus <- copus %>%
  ungroup()

copus <- copus %>%
  group_by(Broader) %>%
  summarise(Avelec = mean(Lec))


ggplot(copus, aes(x = Broader, y = Avelec)) + geom_point()  

# #5 ----------------------------------------------------------------------

ggplot(copus2, aes(x = Broader, y = Lec)) + geom_boxplot() + geom_point(aes(x = Broader, y = Avelec, colour ="red"))
                                                                        
### --- pH --- ### References copus2 which doesn't exist in your code
# -0.5


# #6 ----------------------------------------------------------------------

copus <- copus %>%
  group_by(Broader) %>%
  select(Broader, Size, CG, WG, OG)

sapply(copus, class)  #wont pivot because its not a character so I changed them
copus[3] <- sapply(copus[3],as.character)
copus[4] <- sapply(copus[4],as.character)
copus[5] <- sapply(copus[5],as.character)

copus <- copus %>%
  pivot_longer( cols = CG:OG, names_to = "Group Work") %>% 
  group_by(`Group Work`)

copus<- copus %>%
  group_by(Broader)

sapply(copus, class) #change these to numbers so I can graph them
copus[4] <- sapply(copus[4], as.numeric)

ggplot(copus, aes( x = `Group Work`, y = value, fill = Broader)) + geom_boxplot()+ geom_point()+ facet_wrap(~Size) 

### --- pH --- ### Why did you convert to character variable in lines 71-73? You endd up converting them
### back in line 83?

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

### --- pH --- ### Recall that dpi doesn't do anything in vector files. 

