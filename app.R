########################################################
### Oil Palm Shiny App
### Started by REBlake 5/2/2019
########################################################

library(shiny) ; library(leaflet) 

source("global.R")

# Set up your panels for the UI
tabpan_peru <- tabPanel(title = "Peru",
                        leafletOutput(outputId = "map_peru", width = "100%", height = "92vh"),
                        absolutePanel(top = 100, right = 10, left = "auto", draggable = TRUE, fixed = TRUE,
                                      width = 330, height = "auto",
                                      checkboxGroupInput("checkGroup", label = h4(tags$span("Data Layers", style = "color: white;")),
                                                         choiceNames = list(tags$span("Eco Regions", style = "color: white;"),
                                                                            tags$span("Administrative Regions", style = "color: white;"),
                                                                            tags$span("Oil Palm Deforestation", style = "color: white;")),
                                                         choiceValues = c(1,2,3),
                                                         selected = c(2,3)
                                                         )
                                      )
                        )

tabpan_globe <- tabPanel(title = "Global",
                         leafletOutput(outputId = "map_globe", width = "100%", height = "92vh"),
                         absolutePanel(top = 100, right = 10, left = "auto", draggable = TRUE, fixed = TRUE,
                                       width = 330, height = "auto",
                                       checkboxGroupInput("checkGroup", label = h4("Data Layers"),
                                                          choices = list("Choice 1" = 1, 
                                                                         "Choice 2" = 2, 
                                                                         "Choice 3" = 3)
                                                          )
                                       )
                         )

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
ui <- navbarPage(title = "Oil Palm Deforestation Mapping",
                 tabpan_peru, 
                 tabpan_globe, 
                 tabpan_info
                 )
  

### Server  
server <- function(input, output) {
          output$map_peru <- renderLeaflet({withProgress(message = 'Creating map', 
                                                         make_peru_map()
                                                         )
                                            })

          observe({if(!(1 %in% input$checkGroup)){
                   leafletProxy("map_peru") %>% clearShapes() 
                   }else{
                   leafletProxy("map_peru") %>% 
                   addGeoJSON(geojson = ecoregions, color ="white", weight = 0, 
                              fill = TRUE, #fillColor = col_pal, 
                              fillOpacity = .5,# popup = ~as.character(popup),
                              group = "Ecoregions"
                              )
                   }})
         
           observe({if(!(2 %in% input$checkGroup)){
                    leafletProxy("map_peru") %>% clearShapes()    
                    }else{
                    leafletProxy("map_peru") %>%
                    addGeoJSON(geojson = adminperu, color = "white", weight = 3.5,
                                fill = FALSE, fillColor = "gray", fillOpacity = 1,
                                 group = "Administrative Regions"
                                 )
                    }})
           
           observe({if(!(3 %in% input$checkGroup)){
                    leafletProxy("map_peru") %>% clearShapes()
                    }else{
                    leafletProxy("map_peru") %>%
                    addGeoJSON(geojson = deforestoilpalm, color = "orange", weight = 0.2,
                                 fill = TRUE, #fillColor = col_pal, fillOpacity = 1,
                                # label = ~as.character(gridcode), 
                                 group = "Oil Palm Deforestation"
                                 )
                    }})

           
          
          output$map_globe <- renderLeaflet({
                              leaflet() %>%
                              addProviderTiles(providers$Esri.WorldImagery)
                              })
  
          }  


### App

shinyApp(ui = ui, server = server)
 



