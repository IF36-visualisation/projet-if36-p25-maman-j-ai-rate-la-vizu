library(plotly)
library(shiny)
library(shinydashboard)

fluidPage(dashboardPage(
    skin = "blue",
    dashboardHeader(title = "Maman, j'ai raté la vizu"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Stats", tabName = "stats", icon = icon("circle-info")),
            menuItem(
                "Graphiques",
                tabName = "graphiques",
                icon = icon("chart-column")
            ),
            radioButtons(
                "echelle",
                "Échelle pour la distribution",
                c("Linéaire", "Logarithmique (base 10)")
            ),
            selectInput(
                "abscisse",
                "Abscisse pour la distribution",
                c(
                    "Nature",
                    "Usage",
                    "Année de construction",
                    "Nombre de logements",
                    "Nombre d'étages",
                    "Matériaux des murs",
                    "Matériaux des toits",
                    "Hauteur"
                )
            )
        )
    ),
    dashboardBody(tabItems(
        tabItem(
            tabName = "stats",
            fluidRow(
                valueBoxOutput("batiments"),
                valueBoxOutput("variables"),
                infoBox(
                    "Information sur les stats",
                    "Les moyennes ne prennent pas en compte les bâtiments où l'information n'est pas renseignée !",
                    icon = icon("info"),
                    color = "blue"
                )
            ),
            fluidRow(
                infoBoxOutput("hauteur"),
                infoBoxOutput("nb_logements"),
                infoBoxOutput("religieux")
            ),
            fluidRow(infoBoxOutput("ruines"))
        ),
        tabItem(tabName = "graphiques", fluidRow(
            box(
                title = "Distribution",
                status = "primary",
                solidHeader = TRUE,
                plotlyOutput("distribution")
            ),
            box(
                title = "Informations complémentaires",
                status = "info",
                solidHeader = TRUE,
                HTML(
                    "Les bâtiments dont la valeur est non connue pour la variable sélectionnée en tant qu'abscisse ne sont pas pris en compte pour le graphique.<br>"
                ),
                HTML(
                    "Pour la nature et l'usage, les bâtiments indifférenciés sont ignorés.<br>"
                ),
                HTML("Le nombre de N/A et Indifférencié :<br>"),
                uiOutput("infos")
            )
        ), fluidRow(
            box(
                title = "Hauteur des bâtiments selon leur emplacement géographique",
                status = "warning",
                solidHeader = TRUE,
                plotlyOutput("carte")
            )
        ))
    ))
))
