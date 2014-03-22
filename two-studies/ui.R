library(shiny)

SLIDER_STEP_M <- 0.1
SLIDER_STEP_SD <- 0.1

shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Two studies"),

  # Sidebar with a slider input for number of observations
  sidebarPanel(    
    sliderInput("m1", "M(diff)", value = 4, min = 0, max = 10, 
                ticks = TRUE, step = SLIDER_STEP_M),
    sliderInput("sd1", "SD(pooled)", value = 2.83, min = 0.01, max = 20, 
                ticks = TRUE, step = SLIDER_STEP_SD),
    numericInput("n1", "N", value = 20, min = 2, max = NA, step = 2),
    br(),
    sliderInput("m2", "M(diff)", value = 4, min = 0, max = 10, 
                ticks = TRUE, step = SLIDER_STEP_M),
    sliderInput("sd2", "SD(pooled)", value = 2.83, min = 0.01, max = 20, 
                ticks = TRUE, step = SLIDER_STEP_SD),
    numericInput("n2", "N", value = 20, min = 2, max = NA, step = 2)
  ),

  # Show a plot of the generated distribution
  mainPanel(
    tableOutput("nhst"),
    plotOutput("ci")
  )
))
