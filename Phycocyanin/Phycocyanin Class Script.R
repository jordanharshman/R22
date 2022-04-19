# Libraries ---------------------------------------------------------------
library(tidyverse)
library(corrplot)

# 1. Data Cleaning ----------------------------------------------------------
# Going to:
#  - rename variables and only keep what we need
#  - get everything that should be numbers to numeric, change hrs to days
#  - got rid of Pond and 2hr. measurements because of missing

phyco <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/Phycocyanin/Phycocyanin%20Data.csv") %>%
  select(Enclosure, Treatment, Interval, Temp, `Phycocyanin (ug/L)`, 
         `Secchi (cm)`, `DO (mg/L)`) %>%
  rename(Day = Interval, ID = Enclosure, PC = `Phycocyanin (ug/L)`,
         Secci = `Secchi (cm)`, DO = `DO (mg/L)`) %>%
  mutate(ID = as.numeric(str_remove(ID, "Community-")),
         Day = as.numeric(recode(Day, "0hr." = "0", "2hr." = "0.0833", "24hr." = "1", "48hr." = "2",
                                 "72hr." = "3", "1week" = "7", "2week" = "14")),
         PC = as.numeric(PC),
         PC = case_when(Day == 7 & Treatment == "Urea" & PC > 400 ~ NA_real_, TRUE ~ PC)) %>%
  filter(Treatment != "Pond",
         Day != 0.0833)

# 2. Exploration - Distributions ---------------------------------------------
# First, see if any data are outliers and general shape of distributions:
phyco.l <- phyco %>%
  select(Temp:DO) %>%
  pivot_longer(everything())

ggplot(phyco.l, aes(x = value)) +
  geom_histogram() +
  facet_wrap(~name, scales = "free")

# Nothing too concerning, caution about Temperature

# What about the relationships between the variables?
corrplot(cor(phyco %>% select(-ID:-Day)), type = "lower")

# Want to ask: Are these expected? Anything amiss here?

# Explorations: Relationships ---------------------------------------------
# Decided that we should at how the PC changes across Days by treatment group.

# 1. All-in-one plot

# Compute average +/- sd for phyco
PC.avg <- phyco %>%
  group_by(Treatment, Day) %>%
  summarize(Avg = mean(PC, na.rm = TRUE),
            SD = sd(PC, na.rm = TRUE)) %>%
  mutate(High = Avg + SD,
         Low = Avg - SD)

# plot with errorbars
ggplot(PC.avg, aes(x = Day, y = Avg, color = Treatment, group = Treatment)) +
  geom_point(position = position_dodge(width = .5)) +
  geom_errorbar(aes(ymin = Low, ymax = High), position = position_dodge(width = .5)) +
  geom_line(position = position_dodge(width = .5)) +
  theme_classic()

# facet above plot by Treatment
ggplot(PC.avg, aes(x = Day, y = Avg, color = Treatment, group = Treatment)) +
  geom_point(position = position_dodge(width = .5)) +
  geom_errorbar(aes(ymin = Low, ymax = High), position = position_dodge(width = .5)) +
  geom_line(position = position_dodge(width = .5)) +
  facet_wrap(~Treatment) +
  theme_classic() +
  theme(legend.position = "none")

# 2. Focus on the averages, not the standard deviations
ggplot(PC.avg, aes(x = Day, y = Avg, color = Treatment, group = Treatment)) +
  geom_point(position = position_dodge(width = .5)) +
  geom_line(position = position_dodge(width = .5)) +
  theme_classic()

# 3. Show the raw data, faceted
ggplot(phyco, aes(x = Day, y = PC, color = Treatment, group = Treatment)) +
  geom_point() +
  facet_wrap(~Treatment) +
  theme_classic()

# Day 7 collection of Urea has 1 clear outlier; let's get rid of it above

# 4. Swap to boxplots
phyco.l <- phyco %>%
  select(Day, Treatment, PC) %>%
  pivot_longer(c(-Treatment, -Day))

ggplot(phyco, aes(x = "PC", y = PC, fill = Treatment)) +
  geom_boxplot() +
  facet_wrap(~Day, scales = "free")

# 5. Heat map (raw)
PC.avg <- PC.avg %>%
  group_by(Treatment) %>%
  mutate(Scaled = Avg/max(Avg) * 100) %>%
  mutate(Dayf = factor(Day, levels = c(0, 1, 2, 3, 7, 14)))

ggplot(PC.avg, aes(x = Dayf, y = Treatment, fill = Avg, label = round(Avg)))+
  geom_tile() +
  geom_text(color = "white") +
  scale_fill_gradient(low = "grey80", high = "black") +
  theme_bw() +
  theme(legend.position = "none") 

# 6. Heat map (stnd)
ggplot(PC.avg, aes(x = Dayf, y = Treatment, fill = Scaled, label = round(Scaled)))+
  geom_tile() +
  geom_text(color = "white") +
  scale_fill_gradient(low = "white", high = "black", limits = c(0,100)) +
  theme_bw() +
  theme(legend.position = "none") 









