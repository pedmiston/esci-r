library(shiny)
library(ggplot2)
library(grid)
library(plyr)

shinyServer(function(input, output) {
  calcStats <- function () {
    results <- data.frame("study" = factor(c("Luck", "Noluck"), levels = c("Noluck", "Luck"), ordered = TRUE),
                          "m.diff" = c(input$m1, input$m2),
                          "sd.pooled" = c(input$sd1, input$sd2),
                          "n" = c(input$n1, input$n2))
    results$df <- with(results, n + n - 2)
    results$t.95 <- qt(0.975, df = results$df)
    results$t.obt <- with(results, m.diff / (sd.pooled * sqrt(2/n)))
    results$p.obt <- 2 * pt(-results$t.obt, df = results$df)
    results$se.diff <- with(results, sqrt(((sd.pooled^2) * 2) / n))
    results$ci.lwr <- with(results, m.diff - (t.95 * se.diff))
    results$ci.upr <- with(results, m.diff + (t.95 * se.diff))
    
    return(results)
  }
  
  output$nhst <- renderTable({
    nhst <- calcStats() # [ , c("study","m.diff","sd.pooled","sd.diff","n","t.obt","p.obt")]
    nhst$outcome <- ifelse(nhst$p.obt <= 0.05, "significant", "nonsignificant")
    nhst$p.obt <- sprintf("%1.4f", nhst$p.obt)
#     nhst <- rename(nhst, c("study" = "Study",
#                            "m.diff" = "M.diff",
#                            "sd.pooled" = "SD.pooled",
#                            "sd.diff" = "SD.diff",
#                            "n" = "N",
#                            "t.obt" = "t.value",
#                            "p.obt" = "p.value",
#                            "outcome" = "Outcome"))
    
    return(nhst)
  })
  
  output$ci <- renderPlot({
    est <- calcStats()
    est.plot <- ggplot(est, aes(x = study, y = m.diff, ymin = ci.lwr, ymax = ci.upr)) +
      geom_point() +
      geom_errorbar(width = 0.2) + 
      geom_hline(yintercept = 0.0, lty = 2) +
      coord_flip(ylim = c(-2, 8)) +
      scale_x_discrete("") +
      scale_y_continuous("Mean (Diff)", breaks = seq(-2, 8, by = 1)) +
      theme_bw()
    print(est.plot)
  })
})


# theme(panel.background = element_blank(),
#       axis.text = element_text(color = "black", size = 14),
#       axis.line = element_line(size = 0.8),
#       axis.line.y = element_blank(),
#       axis.ticks.x = element_line(size = 0.8, color = "black"),
#       axis.ticks.y = element_blank(),
#       axis.ticks.length = unit(0.8, "lines"))