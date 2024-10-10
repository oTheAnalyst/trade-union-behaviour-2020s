# Load required packages
library(shiny)
library(targets)
library(ggplot2)

# Load pre-saved RDS file
my_data <- targets::tar_read(national_data)

# Convert the 'Year' column to integer to remove decimals
my_data$Year <- as.integer(my_data$Year)

# Define UI for the application
ui <- fluidPage(
  titlePanel("Interactive Data Visualization"),
  
  sidebarLayout(
    sidebarPanel(
      # Input: Checkboxes for selecting data to display
      checkboxGroupInput("variables", "Select Variables to Display:",
                         choices = list("Labor Organizations" = "labor org count", 
                                        "Employers" = "employers", 
                                        "Strikes" = "strikes"),
                         selected = c("labor org count", "employers", "strikes")),
      
      # Input: Radio buttons for selecting chart type
      radioButtons("chartType", "Select Chart Type:",
                   choices = list("Line Chart" = "line", "Bar Chart" = "bar"),
                   selected = "line")
    ),
    
    mainPanel(
      # Display the data table
      tableOutput("dataTable"),
      
      # Display the interactive plot
      plotOutput("interactivePlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Render the data table
  output$dataTable <- renderTable({
    my_data  # Display the pre-loaded data with formatted Year
  })
  
  # Reactive expression to filter selected variables
  selected_data <- reactive({
    # Subset the data based on the selected variables
    my_data[, c("Year", input$variables), drop = FALSE]
  })
  
  # Render the interactive plot based on user inputs
  output$interactivePlot <- renderPlot({
    plot_data <- selected_data()
    
    # Generate the plot based on user selection
    if (input$chartType == "line") {
      ggplot(plot_data, aes(x = Year)) +
        geom_line(aes(y = `labor org count`, color = "Labor Organizations"), data = subset(plot_data, "labor org count" %in% names(plot_data)), size = 1.2) +
        geom_line(aes(y = employers, color = "Employers"), data = subset(plot_data, "employers" %in% names(plot_data)), size = 1.2) +
        geom_line(aes(y = strikes, color = "Strikes"), data = subset(plot_data, "strikes" %in% names(plot_data)), size = 1.2) +
        labs(y = "Count", color = "Legend") +
        ggtitle("Labor Organizations, Employers, and Strikes Over Time") +
        theme_minimal()
      
    } else if (input$chartType == "bar") {
      ggplot(plot_data, aes(x = as.factor(Year))) +
        geom_bar(aes(y = `labor org count`, fill = "Labor Organizations"), data = subset(plot_data, "labor org count" %in% names(plot_data)), stat = "identity", position = "dodge") +
        geom_bar(aes(y = employers, fill = "Employers"), data = subset(plot_data, "employers" %in% names(plot_data)), stat = "identity", position = "dodge") +
        geom_bar(aes(y = strikes, fill = "Strikes"), data = subset(plot_data, "strikes" %in% names(plot_data)), stat = "identity", position = "dodge") +
        labs(y = "Count", x = "Year", fill = "Legend") +
        ggtitle("Labor Organizations, Employers, and Strikes Over Time") +
        theme_minimal()
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
