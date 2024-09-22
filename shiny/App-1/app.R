## app.R ##
library(shiny)
library(bslib)
library(ggplot2)
library(palmerpenguins)


penguins <- palmerpenguins::penguins


ui <- page_sidebar(
  title = "Penguins dashboard",
  sidebar = sidebar(
    title = "Histogram controls",
    varSelectInput(
      "var", "Select variable",
      dplyr::select_if(penguins, is.numeric)
    ),
    numericInput("bins", "Number of bins", 30)
  ),
  card(
    card_header("Histogram"),
    plotOutput("p")
  )
)

server <- function(input, output) {
  output$p <- renderPlot({
    ggplot(penguins) +
      geom_histogram(aes(!!input$var), bins = input$bins) +
      theme_bw(base_size = 20)
  })
}

cards <- list(
  card(
    full_screen = TRUE,
    card_header("Bill Length"),
    plotOutput("bill_length")
  ),
  card(
    full_screen = TRUE,
    card_header("Bill depth"),
    plotOutput("bill_depth")
  ),
  card(
    full_screen = TRUE,
    card_header("Body Mass"),
    plotOutput("body_mass")
  )
)

color_by <- varSelectInput(
  "color_by", "Color by",
  penguins[c("species", "island", "sex")],
  selected = "species"
)

ui <- page_sidebar(
  title = "Penguins dashboard",
  sidebar = color_by,
  layout_columns(cards[[1]], cards[[2]]),
   cards[[3]]
   
  
)

means <- colMeans(
  penguins[c("bill_length_mm", "bill_depth_mm", "body_mass_g")],
  na.rm = TRUE
)

ui <- page_sidebar(
  title = "Penguins dashboard",
  sidebar = color_by,
  layout_columns(
    fill = FALSE,
    value_box(
      title = "Average bill length",
      value = scales::unit_format(unit = "mm")(means[[1]]),
      showcase = bsicons::bs_icon("align-bottom")
    ),
    value_box(
      title = "Average bill depth",
      value = scales::unit_format(unit = "mm")(means[[2]]),
      showcase = bsicons::bs_icon("align-center")
    ),
    value_box(
      title = "Average body mass",
      value = scales::unit_format(unit = "g", big.mark = ",")(means[[3]]),
      showcase = bsicons::bs_icon("handbag")
    )
  ),
  layout_columns(
    cards[[1]], cards[[2]]
  ),
  cards[[3]]
)
means <- colMeans(
  penguins[c("bill_length_mm", "bill_depth_mm", "body_mass_g")],
  na.rm = TRUE
)

ui <- page_sidebar(
  title = "Penguins dashboard",
  sidebar = color_by,
  layout_columns(
    fill = FALSE,
    value_box(
      title = "Average bill length",
      value = scales::unit_format(unit = "mm")(means[[1]]),
      showcase = bsicons::bs_icon("align-bottom")
    ),
    value_box(
      title = "Average bill depth",
      value = scales::unit_format(unit = "mm")(means[[2]]),
      showcase = bsicons::bs_icon("align-center")
    ),
    value_box(
      title = "Average body mass",
      value = scales::unit_format(unit = "g", big.mark = ",")(means[[3]]),
      showcase = bsicons::bs_icon("handbag")
    )
  ),
  layout_columns(
    cards[[1]], cards[[2]]
  ),
  cards[[3]]
)


ui <- page_sidebar(
  title = "Penguins dashboard",
  sidebar = color_by,
  theme = bs_theme(
    bootswatch = "darkly",
    base_font = font_google("Inter"),
    navbar_bg = "#25443B"
  ),
  !!!cards
)

# Enable thematic
thematic::thematic_shiny(font = "auto")

# Change ggplot2's default "gray" theme
theme_set(theme_bw(base_size = 16))

# New server logic (removes the `+ theme_bw()` part)
server <- function(input, output) {
  gg_plot <- reactive({
    ggplot(penguins) +
      geom_density(aes(fill = !!input$color_by), alpha = 0.2) +
      theme(axis.title = element_blank())
  })
  
  output$bill_length <- renderPlot(gg_plot() + aes(bill_length_mm))
  output$bill_depth <- renderPlot(gg_plot() + aes(bill_depth_mm))
  output$body_mass <- renderPlot(gg_plot() + aes(body_mass_g))
}



shinyApp(ui, server)