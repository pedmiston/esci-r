library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  calcNHST <- function (m, sd, n) {
    df <- n + n - 2
    t <- m / (sd * sqrt(1/n + 1/n))
    p <- 2 * pt(-t, df = df)
    return(data.frame('M.diff' = m,
                      'SD.pooled' = sd,
                      'df' = df,
                      't' = t,
                      'p' = sprintf('%1.4f', p)))
  }
  
  output$nhst <- renderTable({
    rbind(calcNHST(input$m1, input$sd1, input$n1),
          calcNHST(input$m2, input$sd2, input$n2))
  })
  
  output$ci <- renderPlot({
    data <- rbind(calcNHST(input$m1, input$sd1, input$n1),
                  calcNHST(input$m2, input$sd2, input$n2))
    print(ggplot(data, aes(x = c(1,2), y = M.diff, ymin = M.diff - SD.pooled, ymax = M.diff + SD.pooled)) +
      geom_point() +
      geom_errorbar() + 
      coord_flip(ylim = c(0, 10)) +
      scale_x_reverse('Study', breaks = c(1,2)))
  })
})
