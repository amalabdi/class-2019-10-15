library(tidyverse)
library(janitor) # hint tabyl
library(fs)

# without map, it doesn't run, just replicates.
# size in the sample has to match the size of the tibble- as in replicate
# which_bowl = map(1:5, ~sample(c("Bowl 1", "Bowl 2"), size = 10000, replace = TRUE)) %>% 

x <- tibble(replicate = 1:10000) %>% 
  mutate(which_bowl = sample(c("Bowl 1", "Bowl 2"), size = 10000, replace = TRUE)) %>% 
  mutate(cookie = ifelse(which_bowl == "Bowl 1",
                  sample(c("vanilla", "chocolate"), size = 10000, replace = TRUE, prob = c(3/4, 1/4)),
                  sample(c("vanilla", "chocolate"), size = 10000, replace = TRUE, prob = c(1/2, 1/2))))

  
# if I pick a vanilla, what are the odds it comes from Bowl 1? Bayesian probability
# adorn comes from janitor package
# if we don't define the denominator, where does it come from? row
#tabyl makes a frequency table

x %>% 
  tabyl(which_bowl, cookie) %>% 
  adorn_percentages(denominator = "col") %>% 
  adorn_pct_formatting()


# Download a file
download.file("https://docs.google.com/spreadsheets/d/e/2PACX-1vSaerGnn1tDQfgiyJRl7jnn1Au7Ev6Qt7BwMpl53ZgzAyMnANQfog9y4es4ZExlX5tjEgl0mPIyTGcP/pub?gid=480043959&single=true&output=csv",
              destfile = "trains.csv")
trains <- read_csv("trains.csv")

# what is the average affect treatment on attitude

trains %>% 
  group_by(treatment) %>% 
  summarise(avg = mean(attitude))
