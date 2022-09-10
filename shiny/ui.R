#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shinydashboard)
library(shinyWidgets)


## ui.R ##
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Medailles par sport", tabName="barchartViz", icon = icon("th"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName= "barchartViz",
      selectizeInput('pays', label="Choix du pays", choices = NULL, selected=NULL),
      fluidRow(
        box(width=12, height = 12, title = "Medailles par sport pour un pays", solidHeader = TRUE, status = "primary", plotOutput("graphMedalsBySportForOneCountry"))
      )
    )
  )
)

# Put them together into a dashboardPage
dashboardPage(
  skin = "blue",
  dashboardHeader(title = "Projet IF36 : JO"),
  sidebar,
  body
)

