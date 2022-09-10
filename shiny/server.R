#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shinydashboard)
library(dplyr)
library(readr)
library(ggplot2)
library(forcats)

data_medals <- read_csv('../data/olympic_medals.csv')

data_medals <- read_csv('../data/olympic_medals.csv')
data_hosts <- read_csv('../data/olympic_hosts.csv')
data_results <- read_csv('../data/olympic_results.csv')
data_athletes <- read_csv('../data/olympic_athletes.csv')
dt_pays_medal <- data_medals
dt_pays_medal$country_name[dt_pays_medal$country_name == "ROC" ] <- "Russia"
dt_pays_medal$country_name[dt_pays_medal$country_name == "Soviet Union" ] <- "Russia"
dt_pays_medal$country_name[dt_pays_medal$country_name == "Russian Federation" ] <- "Russia"
dt_pays_medal$country_name[dt_pays_medal$country_name == "Olympic Athletes from Russia" ] <- "Russia"

dt_pays_medal$country_name[dt_pays_medal$country_name == "German Democratic Republic (Germany)" ] <- "Germany"
dt_pays_medal$country_name[dt_pays_medal$country_name == "Federal Republic of Germany " ] <- "Germany"

dt_pays_medal$country_name[dt_pays_medal$country_name == "Great Britain" ] <- "UK"

dt_pays_medal$country_name[dt_pays_medal$country_name == "United States of America" ] <- "USA"

dt_pays_medal$country_name[dt_pays_medal$country_name == "People's Republic of China" ] <- "China"

dt_pays_medal$country_name[dt_pays_medal$country_name == "Islamic Republic of Iran" ] <- "Iran"

dt_pays_medal$country_name[dt_pays_medal$country_name == "Islamic Republic of Iran" ] <- "Iran"

dt_pays_medal$nb_medal <- 1

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  output$graphMedalsBySportForOneCountry <- renderPlot({
    data_medals %>% 
      select(discipline_title,country_name) %>% 
      group_by(country_name,discipline_title) %>% 
      filter(country_name == input$pays) %>% 
      count(country_name) %>% 
      ungroup() %>% 
      mutate(discipline_title = fct_reorder(discipline_title, desc(n))) %>% 
      ggplot(aes(y = discipline_title, x = n)) + 
      geom_col(position="dodge", fill="steelblue") +
      coord_flip() + 
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
  })
  
  updateSelectizeInput(session, 'pays', choices = data_medals$country_name, server = TRUE)
  

})
