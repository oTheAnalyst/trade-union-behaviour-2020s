# Load required packages
library(shinydashboard)
library(shiny)
library(bslib)
library(targets)
library(ggplot2)
library(plotly)
library(DBI)
library(RSQLite)

file_location <- "~/trade_union-strikes.db"
con <- DBI::dbConnect(RSQLite::SQLite(), file_location)

RSQLite::dbListTables(con)

data1 <- RSQLite::dbReadTable(con, "kpi_employer_strikes")
data2 <- RSQLite::dbReadTable(con, "kpi_strikes")

national_data <- targets::tar_read(national_data)
print(national_data)
# Load pre-saved RDS file



# Define UI components
color_by <- selectInput(
  inputId = "color_var",
  label = "Choose Color By:",
  choices = c("employers", "strikes"),
  selected = "strikes"
)

cards <- list(
  card(
    full_screen = TRUE,
    card_header("Strikes"),
    plotlyOutput("strikes")  # Use plotlyOutput instead of plotOutput for interactive plots
  )
)

ui <- page_fluid( 
        titlePanel("KPI for Union Strikes"),
        layout_column_wrap(
                         value_box(
                           title = "Pay",
                           width = 4,
                           value = data2$Pay,
                           theme = "white"
                         ),
                         value_box(
                           title = "Staffing",
                           width = 4,
                           value = data2$staffing,
                           theme = "white"
                         ),
                         value_box(
                           title = "Recognition",
                           width = 4,
                           value = data2$Union.recognition,
                           theme = "white"
                         ),
                         value_box(
                           title = "Health and Saftey",
                           width = 4,
                           value = data2$Health.and.safety,
                           theme = "white"
                         ),
                 ),
        mainPanel(
          plotOutput("strikes"))
            )


server <- function(input, output) {
  # Reactive expression to generate the ggplot
  output$strikes <- renderPlot({
      ggplot(national_data, aes(x = Year, y = strikes ))+
       geom_point()+
      xlab("Year")
  })
 
}
# Run the application
shinyApp(ui, server)
