###### Import important packages to visualation. 
library(ggplot2)
library(tidyverse)
  
###### The visualation function renturned 2 plots. 

ch_us_vis_fun <- function(df){
  
  ####### Filter country == China &US, which help us to get the whole life & Child about China.
  ####### Next step is to find the lag difference to show the change through time. 
  vis_df <- full_df %>% 
    filter(country =="China" |country =="United States") %>% # filter country 
    as.data.frame() %>% # Make as dataframe
    mutate(child_diff = (Child - lag(Child))/Child*100, # use the second row minus the previous row to calculate the difference 
           life_diff = (Life- lag(Life))/Life*100) # also for life
  
  ####### The comparsion plot of child 
  p1 <- ggplot(data=vis_df) +
    # load the data point
    geom_line(aes(x=as.Date(Year, "%Y"), y=child_diff, group = country, colour = country)) +
    # Add the 0% line
    geom_hline(yintercept=0,color="red") +
    # adjust the time break
    scale_x_date(date_breaks = '20 years',date_labels = '%Y') +
    # Add the lengend label and the title
    labs(title="The Comparsion of US and China's Death of children of 5 years of age \n per 1000 live births",
         x ="Years seperated by 20 years", y = "The change rate (Unit:%)")
  
  ######## The comparsion plot of life
  p2 <- ggplot(data=vis_df) +
    # load the data point
    geom_line(aes(x=as.Date(Year, "%Y"), y=life_diff, group = country, colour = country)) +
    # Add the 0% line
    geom_hline(yintercept=0,color="red") +
    # adjust the time break
    scale_x_date(date_breaks = '20 years',date_labels = '%Y') +
    # Add the lengend label and the title
    labs(title="The Comparsion of US and China's the average number of years a newborn \n child would live if current mortality pattern were to stay the same",
         x ="Years seperated by 20 years", y = "The change rate (Unit:%)")
  return(list(p1,p2))
}
