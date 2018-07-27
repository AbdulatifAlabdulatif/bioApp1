library(shiny)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  output$content <- renderDataTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    # when reading semicolon separated files,
    # having a comma separator causes `read.csv` to error
    tryCatch(
      {
        df <- read.csv(input$file1$datapath,
                       header = input$header,
                       sep = input$sep
                      )
        #quote = input$quote
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    )
    
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
    
  })
  

     output$result <- renderPrint({
       
       req(input$file1)
       # when reading semicolon separated files,
       # having a comma separator causes `read.csv` to error
       tryCatch(
         {
           df <- read.csv(input$file1$datapath,
                          header = input$header,
                          sep = input$sep
           )
           #quote = input$quote
         },
         error = function(e) {
           # return a safeError if a parsing error occurs
           stop(safeError(e))
         }
       )
       df = df[-1, ]
       df <- as.matrix(df)
       x <- t(df)
    if(input$Meth == 'ShannonDiversit'){
      y <- diversity(x)
      return(y)
    }else if(input$Meth == 'SimpsonDiversity'){
      return(diversity(x, index = "simpson"))
      }else if(input$Meth == 'ChaoRichness'){
        ChaoRichness(df, datatype = "abundance", conf = 0.95)
    }else{
      h <- diversity(x)
      S <- specnumber(x)
      return (h/log(S))
    }
       
       
  })
  
    output$sum <- renderPrint({
    summary(input$file1)
  })
  
    output$Plot <- renderPlot({

      req(input$file1)
      # when reading semicolon separated files,
      # having a comma separator causes `read.csv` to error
      tryCatch(
        {
          df <- read.csv(input$file1$datapath,
                         header = input$header,
                         sep = input$sep
          )
          #quote = input$quote
        },
        error = function(e) {
          # return a safeError if a parsing error occurs
          stop(safeError(e))
        }
      )
      df = df[-1, ]
      df <- as.matrix(df)
      x <- t(df)
      if(input$Meth == 'ShannonDiversit'){
        y <- diversity(x)
        #par(mfrow=c(2,2))
        plot(y)
      }else if(input$Meth == 'SimpsonDiversity'){
        j <- diversity(x, index = "simpson")
        plot(j)
      }else if(input$Meth == 'ChaoRichness'){
        m <- ChaoRichness(df, datatype = "abundance", conf = 0.95)
        plot(m)
      }else{
        h <- diversity(x)
        S <- specnumber(x)
        z <- h/log(S)
        plot(z)
      }
          })
    
})


