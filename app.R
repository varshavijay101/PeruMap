########################################################
### Oil Palm Shiny App
### Started by REBlake 5/2/2019
########################################################

library(shiny) ; library(leaflet) 

#source("global.R")

# Set up your panels for the UI
tabpan_peru <- tabPanel(title = "Peru",
                        leafletOutput(outputId = "map_peru", width = "100%", height = "72vh") ,
                        absolutePanel(top = 240, right = 5, left = "auto", draggable = TRUE, fixed = TRUE,
                                      width = 330, height = "auto",
                                      checkboxGroupInput("checkGroup", label = h4(tags$span("Data Layers", style = "color: white;")),
                                                         choiceNames = list(tags$span("Eco Regions", style = "color: white;"),
                                                                            tags$span("Long-term Risk Forests", style = "color: white;"),
                                                                            tags$span("Administrative Regions", style = "color: white;"),
                                                                            tags$span("Oil Palm Deforestation", style = "color: white;"),
                                                                            tags$span("Protected Areas", style = "color: white;"),
                                                                            tags$span("Indigenous Territories", style = "color: white;"),
                                                                            tags$span("Former Protected Areas (PADDD)", style = "color: white;"),
                                                                            tags$span("Short-term Risk Forests", style = "color: white;")
                                                                            ),
                                                         choiceValues = c(1, 2, 3, 4, 5, 6, 7, 8),
                                                         selected = c(3)
                                                         )
                                      )
                        )

# tabpan_globe <- tabPanel(title = "Global",
#                          leafletOutput(outputId = "map_globe", width = "100%", height = "72vh"),
#                          absolutePanel(top = 100, right = 10, left = "auto", draggable = TRUE, fixed = TRUE,
#                                        width = 330, height = "auto",
#                                        checkboxGroupInput("checkGroup", label = h4("Data Layers"),
#                                                           choices = list("Choice 1" = 1,
#                                                                          "Choice 2" = 2,
#                                                                          "Choice 3" = 3)
#                                                           )
#                                        )
#                          )

tabpan_info <- tabPanel("More Information",
                        h4("About this application"),
                        HTML('<p>This is more information
                             <br/>
                             about your app here.'),
                        br(),
                        br(),
                        h4("How to cite this page, and source code"),
                        HTML('<p> YOUR CITATION TO YOUR PAPER HERE
                             <br/>
                             Code is available from: XXXXXX')
                        )




### UI
ui <- htmlTemplate("template.html", content = navbarPage(title = "Oil Palm Deforestation Mapping",
                                                         tabpan_peru, 
                                                         # tabpan_globe, 
                                                         tabpan_info
                                                         )
                   )


### Server  
server <- function(input, output) {
    output$map_peru <- renderLeaflet({withProgress(message = 'Creating map', 
        make_peru_map()
    )
    })
    
    checkGroup <- reactiveValues(oldChecks = NULL, newChecks = NULL)
    
    observe({
        checkGroup$oldChecks <- checkGroup$newChecks
        checkGroup$newChecks <- input$checkGroup
        addGroup <- setdiff(checkGroup$newChecks, checkGroup$oldChecks)
        delGroup <- setdiff(checkGroup$oldChecks, checkGroup$newChecks)
        
        if (1 %in% delGroup) {
            leafletProxy("map_peru") %>%
                clearGroup("Ecoregions")
        } else if (1 %in% addGroup) {
            leafletProxy("map_peru") %>%
                addPolygons(data = ecoregions, color ="white", weight = 0,
                    fill = TRUE, fillColor = ~pal3(OBJECTID),
                    fillOpacity = .5, popup = ~as.character(ECO_NAME),
                    group = "Ecoregions"
                )
        } else if (2 %in% delGroup) {
            leafletProxy("map_peru") %>%
                clearGroup("Long-term Risk Forests")
        } else if (2 %in% addGroup) {
            leafletProxy("map_peru") %>%
                addPolygons(data = longtermrisk, color = "white", weight = 0,
                    fill = TRUE, fillColor = "papayawhip", fillOpacity = .6,
                    group = "Long-term Risk Forests"
                )
        } else if (3 %in% delGroup) {
            leafletProxy("map_peru") %>%
                clearGroup("Administrative Regions")
        } else if (3 %in% addGroup) {
            leafletProxy("map_peru") %>%
                addPolygons(data = adminperu, color = "white", weight = 3.5,
                    fill = FALSE, fillColor = "gray", fillOpacity = 1,
                    group = "Administrative Regions"
                )
        } else if (4 %in% delGroup) {
            leafletProxy("map_peru") %>%
                clearGroup("Oil Palm Deforestation")
        } else if (4 %in% addGroup) {
            leafletProxy("map_peru") %>%
                addPolygons(data = deforestoilpalm, color = "orange", weight = 0.2,
                    fill = TRUE, fillColor = ~pal(gridcode), fillOpacity = 1,
                    label = ~as.character(gridcode),
                    group = "Oil Palm Deforestation"
                )
        } else if (5 %in% delGroup) {
            leafletProxy("map_peru") %>%
                clearGroup("Protected Areas")
        } else if (5 %in% addGroup) {
            leafletProxy("map_peru") %>%
                addPolygons(data = pa, color = "green", weight = 1,
                    fill = TRUE, fillColor = "green", fillOpacity = .3,
                    popup = ~as.character(pacontent),
                    group = "Protected Areas"
                )
        } else if (6 %in% delGroup) {
            leafletProxy("map_peru") %>%
                clearGroup("Indigenous Territories")
        } else if (6 %in% addGroup) {
            leafletProxy("map_peru") %>%
                addPolygons(data = indigenous, color = "palegreen", weight = 1,
                    fill = TRUE, fillColor = "palegreen", fillOpacity = .2,
                    group = "Indigenous Territories"
                )
        } else if (7 %in% delGroup) {
            leafletProxy("map_peru") %>%
                clearGroup("Former Protected Areas (PADDD)")
        } else if (7 %in% addGroup) {
            leafletProxy("map_peru") %>%
                addPolygons(data = paddd, color = "red", weight = 1,
                    fill = TRUE, fillColor = "red", fillOpacity = .3,
                    popup = ~as.character(padddcontent),
                    group = "Former Protected Areas (PADDD)"
                )
        } else if (8 %in% delGroup) {
            leafletProxy("map_peru") %>%
                clearGroup("Short-term Risk Forests")
        } else if (8 %in% addGroup) {
            leafletProxy("map_peru") %>%
                addPolygons(data = shorttermrisk, color = "white", weight = 0,
                    fill = TRUE, fillColor = "peachpuff", fillOpacity = .7,
                    group = "Short-term Risk Forests"
                )
        }
        
        # output$map_globe <- renderLeaflet({
        #                     leaflet() %>%
        #                     addProviderTiles(providers$Esri.WorldImagery)
        #                     })
        # 
    })
}


### App

shinyApp(ui = ui, server = server)
 



