########################################################
### Oil Palm Shiny App
### Started by REBlake 5/2/2019
########################################################

library(shiny) ; library(leaflet) 

# Set up your panels for the UI
tabpan_peru <- tabPanel(
    title = "Peru",
    leafletOutput(outputId = "map_peru", width = "100%", height = "72vh") ,
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
                                                         tabpan_info,
                                                         includeCSS("www/css/custom.css")
                                                         )
                   )


### Server  
server <- function(input, output) {
          output$map_peru <- renderLeaflet({withProgress(message = 'Creating map', 
                                                         make_peru_map()
                                                         )
                                            })

          observe({if(!(1 %in% input$checkGroup)){
                   leafletProxy("map_peru") %>% clearGroup("Ecoregions")
                   }else{
                   leafletProxy("map_peru") %>% clearGroup("Ecoregions") %>% 
                   addPolygons(data = ecoregions, color ="white", weight = 0,
                               fill = TRUE, fillColor = ~pal3(OBJECTID),
                               fillOpacity = .5, popup = ~as.character(ECO_NAME),
                               group = "Ecoregions"
                               )
                   }})
          observe({if(!(2 %in% input$checkGroup)){
                   leafletProxy("map_peru") %>% clearGroup("Long-term Risk Forests")
                   }else{
                   leafletProxy("map_peru") %>% clearGroup("Long-term Risk Forests") %>% 
                   addPolygons(data = longtermrisk, color = "white", weight = 0,
                               fill = TRUE, fillColor = "papayawhip", fillOpacity = .6,
                               group = "Long-term Risk Forests"
                               )
                   }}) 
          observe({if(!(3 %in% input$checkGroup)){
                    leafletProxy("map_peru") %>% clearGroup("Administrative Regions")
                    }else{
                    leafletProxy("map_peru") %>% clearGroup("Administrative Regions") %>% 
                    addPolygons(data = adminperu, color = "white", weight = 3.5,
                                fill = FALSE, fillColor = "gray", fillOpacity = 1,
                                group = "Administrative Regions"
                                )
                    }})
           observe({if(!(4 %in% input$checkGroup)){
                    leafletProxy("map_peru") %>% clearGroup("Oil Palm Deforestation")
                    }else{
                    leafletProxy("map_peru") %>%  clearGroup("Oil Palm Deforestation") %>% 
                    addPolygons(data = deforestoilpalm, color = "orange", weight = 0.2,
                                fill = TRUE, fillColor = ~pal(gridcode), fillOpacity = 1,
                                label = ~as.character(gridcode),
                                group = "Oil Palm Deforestation"
                                )
                    }})
           observe({if(!(5 %in% input$checkGroup)){
                    leafletProxy("map_peru") %>% clearGroup("Protected Areas")
                    }else{
                    leafletProxy("map_peru") %>% clearGroup("Protected Areas") %>% 
                    addPolygons(data = pa, color = "green", weight = 1,
                                fill = TRUE, fillColor = "green", fillOpacity = .3,
                                popup = ~as.character(pacontent),
                                group = "Protected Areas"
                                )
                    }})
           observe({if(!(6 %in% input$checkGroup)){
                    leafletProxy("map_peru") %>% clearGroup("Indigenous Territories")
                    }else{
                    leafletProxy("map_peru") %>% clearGroup("Indigenous Territories") %>% 
                    addPolygons(data = indigenous, color = "palegreen", weight = 1,
                                fill = TRUE, fillColor = "palegreen", fillOpacity = .2,
                                group = "Indigenous Territories"
                                )
                    }})
           observe({if(!(7 %in% input$checkGroup)){
                    leafletProxy("map_peru") %>% clearGroup("Former Protected Areas (PADDD)")
                    }else{
                    leafletProxy("map_peru") %>% clearGroup("Former Protected Areas (PADDD)") %>% 
                    addPolygons(data = paddd, color = "red", weight = 1,
                                fill = TRUE, fillColor = "red", fillOpacity = .3,
                                popup = ~as.character(padddcontent),
                                group = "Former Protected Areas (PADDD)"
                                )
                    }})
           observe({if(!(8 %in% input$checkGroup)){
                    leafletProxy("map_peru") %>% clearGroup("Short-term Risk Forests")
                    }else{
                    leafletProxy("map_peru") %>% clearGroup("Short-term Risk Forests") %>% 
                    addPolygons(data = shorttermrisk, color = "white", weight = 0,
                                fill = TRUE, fillColor = "peachpuff", fillOpacity = .7,
                                group = "Short-term Risk Forests"
                                )
                    }})
           
          
          # output$map_globe <- renderLeaflet({
          #                     leaflet() %>%
          #                     addProviderTiles(providers$Esri.WorldImagery)
          #                     })
          # 
          }  


### App

shinyApp(ui = ui, server = server)
 



