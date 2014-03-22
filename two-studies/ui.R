library(shiny)

SLIDER_STEP_M <- 0.1
SLIDER_STEP_SD <- 0.01

shinyUI(pageWithSidebar(
  
  headerPanel("Two studies"),
  
  sidebarPanel(
    h3("Study 1: Luck"),
    sliderInput("m1", "M(diff)", value = 4.0, min = 0.0, max = 10.0, 
                ticks = TRUE, step = SLIDER_STEP_M),
    sliderInput("sd1", "SD(pooled)", value = 2.83, min = 0.1, max = 20.0, 
                ticks = TRUE, step = SLIDER_STEP_SD),
    numericInput("n1", "N", value = 20, min = 2, max = NA, step = 2),
    br(),
    h3("Study 2: Noluck"),
    sliderInput("m2", "M(diff)", value = 1.5, min = 0.0, max = 10.0, 
                ticks = TRUE, step = SLIDER_STEP_M),
    sliderInput("sd2", "SD(pooled)", value = 4.25, min = 0.1, max = 20.0, 
                ticks = TRUE, step = SLIDER_STEP_SD),
    numericInput("n2", "N", value = 30, min = 2, max = NA, step = 2)
  ),

  # Show a plot of the generated distribution
  mainPanel(
    h3("NHST"),
    tableOutput("nhst"),
    br(),
    h3("95% CI"),
    plotOutput("ci")
  )
))
