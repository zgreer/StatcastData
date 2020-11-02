##install.packages("devtools");
##library(devtools)
##devtools::install_github("BillPetti/baseballr")
library(baseballr);
##install.packages("tidyverse");
library(tidyverse);
##install.packages("lubridate");
library(lubridate);

##Enter season to be scraped
season=2020

#Creating list of dates to scrape
dates=seq(ymd(paste(season,"-03-16",",")),ymd(paste(season,"-11-15",",")), by="5 days");

#Scraping Loop
pitch_data=data.frame()
for(i in 1:length(dates)){
  if(i>length(dates)){
    batters=suppressMessages(scrape_statcast_savant_batter_all(start_date=dates[i], 
                                                               end_date=dates[i]+days(4)))
    pitchers=suppressMessages(scrape_statcast_savant_pitcher_all(start_date=dates[i], 
                                                                 end_date=dates[i]+days(4)))
    pitch_sub=suppressMessages(batters %>%
                                 rename(batter_name=player_name) %>%
                                 inner_join(pitchers %>% rename(pitcher_name=player_name)))
    pitch_data=rbind(pitch_data,pitch_sub)
    print(paste(dates[i],"sub section complete"))
  }
  else {
    batters=suppressMessages(scrape_statcast_savant_batter_all(start_date=dates[i], 
                                                               end_date=dates[i]+days(4)))
    pitchers=suppressMessages(scrape_statcast_savant_pitcher_all(start_date=dates[i], 
                                                                 end_date=dates[i]+days(4)))
    pitch_sub=suppressMessages(batters %>%
                                 rename(batter_name=player_name) %>%
                                 inner_join(pitchers %>% rename(pitcher_name=player_name)))
    pitch_data=rbind(pitch_data,pitch_sub)
    print(paste(dates[i],"sub section complete")) 
    rm(batters, pitchers, pitch_sub, i)
  }
}





