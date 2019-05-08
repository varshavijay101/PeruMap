########################################################
### Oil Palm Shiny App
### Started by REBlake 5/2/2019
########################################################

library(shiny) ; library(leaflet) 

# Set up your panels for the UI
tabpan_peru <- tabPanel(title = p("Peru Map", style = "font-size: 18px;"),
                        div(class = "outer", tags$head(includeCSS("styles.css")),
                        leafletOutput(outputId = "map_peru", width = "100%", height = "100%") , # 
                        absolutePanel(top = 240, right = 5, left = "auto", draggable = TRUE, fixed = TRUE,
                                      width = 330, height = "auto",
                                      checkboxGroupInput("checkGroup", label = h4("Data Layers"),
                                                         choiceNames = list("Eco Regions",
                                                                            "Long-term Risk Forests",
                                                                            "Administrative Regions",
                                                                            "Oil Palm Deforestation",
                                                                            "Protected Areas",
                                                                            "Indigenous Territories",
                                                                            "Former Protected Areas (PADDD)",
                                                                            "Short-term Risk Forests"
                                                                            ),
                                                         choiceValues = c(1, 2, 3, 4, 5, 6, 7, 8),
                                                         selected = c(3)
                                                         )
                                      )
                            )
                        )

# tabpan_globe <- tabPanel(title = "Global",
#                          leafletOutput(outputId = "map_globe", width = "100%", height = "75vh"),
#                          absolutePanel(top = 100, right = 10, left = "auto", draggable = TRUE, fixed = TRUE,
#                                        width = 330, height = "auto",
#                                        checkboxGroupInput("checkGroup", label = h4("Data Layers"),
#                                                           choiceNames = list("Choice 1",
#                                                                              "Choice 2",
#                                                                              "Choice 3"),
#                                                           choiceValues = c(1, 2, 3)
#                                                           )
#                                        )
#                          )

tabpan_info <- tabPanel(title = p("More Information", style = "font-size: 18px;"),
                        h3("About this application"),
                        HTML('<p>This is more information
                             <br/>
                             about your app here.'),
                        br(),
                        br(),
                        h3("How to cite this page, and source code"),
                        HTML('<p> YOUR CITATION TO YOUR PAPER HERE
                             <br/>
                             Code is available from: XXXXXX')
                        )




### UI
ui <- htmlTemplate("template.html", content = navbarPage(title = strong(""),
                                                         tabpan_peru, 
                                                         # tabpan_globe, 
                                                         tabpan_info,
                                                         includeCSS("www/css/custom.css")
                                                         )
                   )



### App

# shinyApp(ui = ui, server = server)
 



