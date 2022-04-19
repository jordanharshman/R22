library(tidyverse)

phyco <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/Phycocyanin/Phycocyanin%20Data.csv") %>%
  select(Enclosure, Treatment, Interval, Temp, `Phycocyanin (ug/L)`, 
         `Secchi (cm)`, `DO (mg/L)`) %>%
  rename(Day = Interval, ID = Enclosure, PC = `Phycocyanin (ug/L)`,
         Secci = `Secchi (cm)`, DO = `DO (mg/L)`) %>%
  mutate(ID = as.numeric(str_remove(ID, "Community-")),
         Day = as.numeric(recode(Day, "0hr." = "0", "2hr." = "0.0833", "24hr." = "1", "48hr." = "2",
                                 "72hr." = "3", "1week" = "7", "2week" = "14")),
         PC = as.numeric(PC)) %>%
  filter(Treatment != "Pond",
         Day != 0.0833)

