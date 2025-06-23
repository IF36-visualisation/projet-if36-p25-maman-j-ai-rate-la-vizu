library(plotly)
library(shiny)
library(shinydashboard)

fluidPage(dashboardPage(
    skin = "blue",
    dashboardHeader(title = "Maman, j'ai raté la vizu"),
    dashboardSidebar(sidebarMenu(
        menuItem("Stats", tabName = "stats", icon = icon("circle-info")),
        menuItem(
            "Graphiques",
            tabName = "graphiques",
            icon = icon("chart-column")
        ),
        radioButtons(
            "echelle",
            "Échelle pour la distribution",
            c("Linéaire",
              "Logarithmique (base 10)")
        ),
        selectInput(
            "abscisse",
            "Abscisse pour la distribution",
            c(
                "Nature" = "NATURE",
                "Usage" = "USAGE1",
                "Année de construction" = "DATE_APP",
                "Nombre de logements" = "NB_LOGTS",
                "Nombre d'étages" = "NB_ETAGES",
                "Matériaux des murs" = "MAT_MURS",
                "Matériaux des toits" = "MAT_TOITS",
                "Hauteur" = "HAUTEUR"
            )
        )
    )),
    dashboardBody(tabItems(
        tabItem(
            tabName = "stats",
            fluidRow(valueBoxOutput("batiments"), valueBoxOutput("variables")),
            fluidRow(
                infoBoxOutput("hauteur"),
                infoBoxOutput("nb_logements"),
                infoBoxOutput("religieux")
            )
        ),
        tabItem(
            tabName = "graphiques",
            box(
                title = "Distribution",
                status = "primary",
                solidHeader = TRUE,
                plotlyOutput("distribution")
            )
        )
    ))
))
