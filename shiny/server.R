library(dplyr)
library(plotly)
library(readr)
library(shiny)

function(input, output, session) {
    batiments = read_csv(
        "../data/batiments_troyes_coords.csv",
        col_types = cols(
            ID = col_character(),
            NATURE = col_character(),
            USAGE1 = col_character(),
            USAGE2 = col_character(),
            LEGER = col_character(),
            ETAT = col_character(),
            DATE_CREAT = col_datetime(),
            DATE_MAJ = col_datetime(),
            DATE_APP = col_date(),
            DATE_CONF = col_date(),
            SOURCE = col_character(),
            ID_SOURCE = col_character(),
            ACQU_PLANI = col_character(),
            PREC_PLANI = col_double(),
            ACQU_ALTI = col_character(),
            PREC_ALTI = col_double(),
            NB_LOGTS = col_double(),
            NB_ETAGES = col_double(),
            MAT_MURS = col_character(),
            MAT_TOITS = col_character(),
            HAUTEUR = col_double(),
            Z_MIN_SOL = col_double(),
            Z_MIN_TOIT = col_double(),
            Z_MAX_TOIT = col_double(),
            Z_MAX_SOL = col_double(),
            ORIGIN_BAT = col_character(),
            APP_FF = col_character(),
            LONGITUDE = col_double(),
            LATITUDE = col_double()
        )
    )

    materiaux_murs = read_csv(
        "../data/materiaux_murs.csv",
        col_types = cols(code = col_character(), valeur = col_character())
    )
    materiaux_toits = read_csv(
        "../data/materiaux_toits.csv",
        col_types = cols(code = col_character(), valeur = col_character())
    )

    batiments = batiments %>%
        mutate(LEGER = if_else(LEGER == "Oui", TRUE, FALSE))

    batiments = batiments %>%
        left_join(materiaux_murs,
                  by = c("MAT_MURS" = "code"),
                  relationship = "many-to-one") %>%
        select(-MAT_MURS) %>%
        rename(MAT_MURS = valeur)

    batiments = batiments %>%
        left_join(materiaux_toits,
                  by = c("MAT_TOITS" = "code"),
                  relationship = "many-to-one") %>%
        select(-MAT_TOITS) %>%
        rename(MAT_TOITS = valeur)

    batiments = batiments %>%
        select(
            c(
                NATURE,
                USAGE1,
                USAGE2,
                LEGER,
                DATE_APP,
                ACQU_PLANI,
                NB_LOGTS,
                NB_ETAGES,
                MAT_MURS,
                MAT_TOITS,
                HAUTEUR,
                Z_MIN_SOL,
                Z_MAX_TOIT,
                ETAT,
                LONGITUDE,
                LATITUDE
            )
        )

    output$batiments = renderValueBox({
        valueBox(
            format(nrow(batiments), big.mark = " "),
            "Bâtiments",
            icon = icon("bars"),
            color = "aqua"
        )
    })

    output$variables = renderValueBox({
        valueBox(
            ncol(batiments),
            "Variables",
            icon = icon("table-columns"),
            color = "yellow"
        )
    })

    output$hauteur = renderInfoBox({
        infoBox(
            "Hauteur moyenne (m)",
            round(mean(batiments$HAUTEUR, na.rm = TRUE), 2),
            icon = icon("up-long"),
            color = "purple"
        )
    })

    output$nb_logements = renderInfoBox({
        infoBox(
            "Nombre de logements moyen par bâtiment",
            round(mean(batiments$NB_LOGTS, na.rm = TRUE), 2),
            icon = icon("people-roof"),
            color = "olive"
        )
    })

    output$religieux = renderInfoBox({
        infoBox(
            "Nombre de bâtiments religieux",
            nrow(
                filter(
                    batiments,
                    NATURE %in% c("Chapelle", "Eglise") |
                        USAGE1 == "Religieux"
                ) %>% distinct()
            ),
            "Chapelle, église ou bâtiment à usage religieux",
            icon = icon("church"),
            color = "teal"
        )
    })

    output$ruines = renderInfoBox({
        infoBox(
            "Nombre de bâtiments en ruine",
            nrow(filter(batiments, ETAT == "En ruine")),
            icon = icon("house-chimney-crack"),
            color = "navy"
        )
    })

    abscisse = reactive({
        case_when(
            input$abscisse == "Nature" ~ "NATURE",
            input$abscisse == "Usage" ~ "USAGE1",
            input$abscisse == "Année de construction" ~ "DATE_APP",
            input$abscisse == "Nombre de logements" ~ "NB_LOGTS",
            input$abscisse == "Nombre d'étages" ~ "NB_ETAGES",
            input$abscisse == "Matériaux des murs" ~ "MAT_MURS",
            input$abscisse == "Matériaux des toits" ~ "MAT_TOITS",
            input$abscisse == "Hauteur" ~ "HAUTEUR"
        )
    })

    output$distribution = renderPlotly({
        abscisse = abscisse()
        batiments = batiments %>% filter(!is.na(.[[abscisse]]))
        if (abscisse == "NATURE")
            batiments = batiments %>% filter(.[[abscisse]] != "Indifférenciée")
        if (abscisse == "USAGE1")
            batiments = batiments %>% filter(.[[abscisse]] != "Indifférencié")
        if (abscisse == "HAUTEUR") {
            max_hauteur = ceiling(max(batiments[[abscisse]]))
            batiments = batiments %>% mutate(HAUTEUR = cut(
                .[[abscisse]],
                breaks = seq(0, max_hauteur, by = 1),
                right = FALSE,
                labels = paste0(
                    seq(0, max_hauteur - 1, by = 1),
                    "-",
                    seq(1, max_hauteur, by = 1)
                )
            ))
        }
        if (abscisse == "DATE_APP") {
            batiments = batiments %>% mutate(DATE_APP = as.numeric(format(DATE_APP, "%Y")))
            max_annee = ceiling(max(batiments[[abscisse]]) / 10) * 10
            min_annee = floor(min(batiments[[abscisse]]) / 10) * 10
            batiments = batiments %>% mutate(DATE_APP = cut(
                .[[abscisse]],
                breaks = seq(min_annee, max_annee, by = 10),
                right = FALSE,
                labels = paste0(
                    seq(min_annee, max_annee - 10, by = 10),
                    "-",
                    seq(min_annee + 10, max_annee, by = 10)
                )
            ))
        }
        layout(
            plot_ly(
                batiments,
                x = ~ batiments[[abscisse]],
                marker = list(color = "dimgrey"),
                type = "histogram"
            ),
            xaxis = list(title = input$abscisse),
            yaxis = list(
                title = "Nombre de bâtiments",
                type = if_else(input$echelle == "Linéaire", "linear", "log")
            ),
            annotations = list(
                list(
                    x = 1,
                    y = 1.05,
                    xref = "paper",
                    yref = "paper",
                    text = if_else(
                        input$echelle == "Linéaire",
                        "Échelle linéaire",
                        "Échelle logarithmique (base 10)"
                    ),
                    showarrow = FALSE,
                    font = list(size = 12)
                )
            )
        )
    })

    output$infos = renderUI({
        abscisse = abscisse()
        if (abscisse == "NATURE") {
            batiments = batiments %>% filter(.[[abscisse]] == "Indifférenciée")
        }  else if (abscisse == "USAGE1") {
            batiments = batiments %>% filter(.[[abscisse]] == "Indifférencié")
        } else {
            batiments = batiments %>% filter(is.na(.[[abscisse]]))
        }
        HTML(paste0("<b>", nrow(batiments), "</b>"))
    })

    output$carte <- renderPlotly({
        batiments = batiments %>% mutate(HAUTEUR = if_else(is.na(HAUTEUR), "N/A", as.character(HAUTEUR)))
        plot_ly(data = batiments) %>%
            add_trace(
                type = "scattermapbox",
                lat = ~ LATITUDE,
                lon = ~ LONGITUDE,
                text = ~ HAUTEUR,
                mode = "markers",
                marker = list(
                    size = 10,
                    color = ~ HAUTEUR,
                    colorscale = "Viridis",
                    showscale = TRUE,
                    colorbar = list(title = "Hauteur (en m)")
                )
            ) %>%
            layout(
                mapbox = list(
                    style = "open-street-map",
                    zoom = 9,
                    center = list(lat = 48.29, lon = 4.08)
                )
            )
    })
}
