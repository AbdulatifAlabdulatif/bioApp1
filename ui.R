#install.packages("vegan")
#install.packages("iNEXT")
#library(vegan)
#library(iNEXT)

list_of_packages = c("ggplot2","vegan", "iNEXT","diveRsity")

lapply(list_of_packages, 
       function(x) if(!require(x,character.only = TRUE)) install.packages(x))

library(shiny)

# Define UI for data upload app ----
  #*************************************
  ui <- fluidPage(
    
    # App title ----
    titlePanel("Assessment applcation"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
      
      # Sidebar panel for inputs ----
      sidebarPanel(
        
        # Input: Select a file ----
        fileInput("file1", "Choose CSV File",
                  multiple = FALSE,
                  accept = c("text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv")),
        
        # Horizontal line ----
        tags$hr(),
        
        # Input: Checkbox if file has header ----
        checkboxInput("header", "Header", TRUE),
        
        # Input: Select separator ----
        radioButtons("sep", "Separator",
                     choices = c(Comma = ",",
                                 Semicolon = ";",
                                 Tab = "\t"),
                     selected = ","),
        
        # Input: Select quotes ----
      #  radioButtons("quote", "Quote",
       #              choices = c(None = "",
        #                         "Double Quote" = '"',
         #                        "Single Quote" = "'"),
          #           selected = '"'),
        
        # Horizontal line ----
        tags$hr(),
        
        # Input: Select number of rows to display ----
        radioButtons("disp", "Display",
                     choices = c(Head = "head",
                                 All = "Shannon Diversity"),
                     selected = "head"),
        
        radioButtons("Meth", "Method",
                     choices = c(ShannonDiversity = "ShannonDiversit",
                                 SimpsonDiversity = "SimpsonDiversity",
                                 PielouEvenness = "PielouEvenness",
                                 ChaoRichness ="ChaoRichness"),
                                 selected = "ShannonDiversit")
        
      ),
      
       
      # Main panel for displaying outputs ----
      mainPanel(
        tabsetPanel(type="tab",
          tabPanel("Dataset", dataTableOutput("content")),
          tabPanel("Summary", verbatimTextOutput("sum")),
          tabPanel("Result", verbatimTextOutput("result")),
          tabPanel("Plot", plotOutput("Plot"))) 
      )
      
    )
  )
  #*************************************
  # App title ----
 