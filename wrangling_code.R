# import important packages for wrangling dataset.
library(tidyverse)
library(readr)

# import two variables: child_mortality_0_5_year_olds_dying_per_1000_born & Life expectancy years
life<- read_csv("life_expectancy_years.csv")
child <- read_csv("child_mortality_0_5_year_olds_dying_per_1000_born.csv")

# Make the wide dataset into long dataset with columns: country, Year, values.
# Then, we combine two long dataset to get a summary dataset with columns: country, year, income, and population. 
# During this process, we keep NA withour dropping them. 
long_child <- child %>% 
  tibble() %>% 
  gather(key= Year, value = "Child",-country) 

long_life <- life %>% 
  tibble() %>% 
  gather(key= Year, value = "Life",-country)

full_df <- inner_join(long_child,long_life)
