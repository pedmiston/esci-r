library(shiny)

shinyServer(function(input, output) {
  output$nhst <- renderTable({
    t.obt <- -input$m1 / (input$sd1 * sqrt(1/input$n1 + (1/input$n1)))
    p.obt <- 2 * pt(t.obt, df = input$n1 + input$n1 - 2)
    results <- list('M(diff)' = input$m1,
                    'SD(pooled)' = input$sd1,
                    't value' = t.obt,
                    'p value' = p.obt)
    as.data.frame(results)
  })
})
