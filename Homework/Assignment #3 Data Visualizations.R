library(tidyverse)
copus <- read_csv("data/copus.csv")

# #1 ----------------------------------------------------------------------
# standard boxplot
ggplot(copus, aes(y = Lec)) +
  geom_boxplot()

# #2 ----------------------------------------------------------------------
# use geom_bar() to compute counts for me
ggplot(copus %>% filter(!is.na(Size)), aes(x = Size)) +
  geom_bar()

# #3 ----------------------------------------------------------------------
# facet by Size and rotate text
ggplot(copus %>% filter(!is.na(Size)), aes(x = Broader)) +
  geom_bar() +
  facet_wrap(~Size) +
  theme(axis.text.x = element_text(a = 270))

# #4 ----------------------------------------------------------------------
copus.avg <- copus %>%
  group_by(Broader) %>%
  summarize(AverageLec = mean(Lec))

ggplot(copus.avg, aes(x = Broader, y = AverageLec)) +
  geom_point()

# #5 ----------------------------------------------------------------------
ggplot(copus, aes(x = Broader, y = Lec)) +
  geom_boxplot() +
  geom_point(data = copus.avg, aes(y = AverageLec), color = "red")

# OR

ggplot(copus, aes(x = Broader , y = Lec)) +
  geom_boxplot() + 
  stat_summary(AverageLec="mean", color="red", geom = "point")

# #6 ----------------------------------------------------------------------
copus.l <- copus %>%
  filter(!is.na(Size)) %>%
  select(Broader, Size, CG:OG) %>%
  pivot_longer(c(-Broader, -Size), names_to = "GroupWork", values_to = "Percent")

ggplot(copus.l, aes(x = GroupWork, y = Percent, fill = Broader)) +
  geom_boxplot() +
  facet_wrap(~Size)

# #7 ----------------------------------------------------------------------
ggplot(copus.l, aes(x = GroupWork, y = Percent, fill = Broader)) +
  geom_boxplot(outlier.shape = NA) +
  scale_y_continuous(limits = c(0, 60)) +
  facet_wrap(~Size)

ggsave("HW3_7.pdf",
       height = 2,
       width = 6,
       units = "in")







