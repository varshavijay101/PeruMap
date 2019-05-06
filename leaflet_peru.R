### Peru Leaflet Map for Shiny

## Load libraries
library(leaflet)
library(webshot)
library(sf)
library(raster)
library(dplyr)
library(htmlwidgets)
library(htmltools)

# # simple peru map
# make_peru_map <- function(){
#                  pmap <- leaflet() %>%
#                          addProviderTiles(providers$Esri.WorldImagery,
#                                           options = providerTileOptions(minZoom = 4))
#                  return(pmap)
# }

## LOAD DATA LAYERS
deforestoilpalm <- st_read('deforestoilpalmWGS.shp')
pal <- colorNumeric("Oranges", deforestoilpalm$gridcode)

longtermrisk <- st_read('riskmapbinaryMULTIPART.shp')
shorttermrisk <- longtermrisk %>% filter(gridcode == 1)

pa <- st_read('pa.shp')
indigenous <- st_read('indigenousWGS.shp')
pacontent <- paste(sep = "<br/>", pa$NAME, pa$DESIG_ENG,
                   paste("IUCN Category: ", pa$IUCN_CAT))
paddd <- st_read('paddd.shp')
padddcontent <- paste(sep = "<br/>", paddd$Protected,
                      paste("PADDD Year: ", paddd$Year_PADDD))

ecoregions <- st_read('ecoregionsWGS.shp')
ecoregions <- sf::st_cast(ecoregions, "POLYGON")
pal3 <- colorNumeric(rainbow(13), ecoregions$OBJECTID)
adminperu <- st_read('Departamento.shp')

### Function to create Leaflet map
make_peru_map <- function(){
# Create an empty leaflet map and set zoom controls to prevent zooming outside study area
pmap <- leaflet(options = leafletOptions(zoomControl = TRUE, minZoom = 5)) %>%
        addProviderTiles(providers$Esri.WorldImagery,
                         options = providerTileOptions(minZoom = 4),
                         group= "Esri World Imagery") %>%
        addMiniMap(zoomLevelOffset = -4) %>% # Add minimap for reference
        addScaleBar() %>% # Add scale bar
        setView(lng = -71.622, lat = -9.0, zoom=5) #%>% # Center on Peruvian Amazon
#         # addMapPane("ecoreg", zIndex = 400) %>%
#         # addMapPane("defor", zIndex = 430) %>%
#         addPolygons(data = ecoregions,  # ecoregions
#                     color ="white",
#                     weight = 0,
#                     fill = TRUE,
#                     fillColor = ~pal3(OBJECTID),
#                     fillOpacity = .5,
#                     popup = ~as.character(ECO_NAME),
#                     group="Ecoregions"#,
#                     #  options = pathOptions(pane = "ecoreg")
#                     ) %>%
#         addPolygons(data = adminperu, # admin layers
#                     color = "white",
#                     weight = 3.5,
#                     fill = FALSE,
#                     fillColor = "gray",
#                     fillOpacity = 1,
#                     group = "Administrative Regions") %>%
#         addPolygons(data = deforestoilpalm,   # deforest crop and oilpalm
#                     color = "orange",
#                     weight = 0.2,
#                     fill = TRUE,
#                     fillColor = ~pal(gridcode),
#                     fillOpacity = 1,
#                     label = ~as.character(gridcode),
#                     group = "Oil Palm Deforestation"#,
#                     #  options = pathOptions(pane = "defor")
#                     ) %>% 
#         addPolygons(data = pa,    # Add protected Areas and Indigenous Areas
#                     color = "green",
#                     weight = 1,
#                     fill = TRUE,
#                     fillColor = "green",
#                     fillOpacity = .3,
#                     popup = ~as.character(pacontent),
#                     group="Protected Areas") %>%
#         addPolygons(data = indigenous,
#                     color = "palegreen",
#                     weight = 1,
#                     fill = TRUE,
#                     fillColor = "palegreen",
#                     fillOpacity = .2,
#                     group="Indigenous Territories") %>%
#         addPolygons(data = paddd,
#                     color = "red",
#                     weight = 1,
#                     fill = TRUE,
#                     fillColor = "red",
#                     fillOpacity = .3,
#                     popup = ~as.character(padddcontent),
#                     group = "Former Protected Areas (PADDD)") %>%
#         addPolygons(data = longtermrisk,   # Add risk maps
#                     color = "white",
#                     weight = 0,
#                     fill = TRUE,
#                     fillColor = "papayawhip",
#                     fillOpacity = .6,
#                     group = "Long-term Risk Forests") %>%
#         addPolygons(data = shorttermrisk,
#                     color = "white",
#                     weight = 0,
#                     fill = TRUE,
#                     fillColor = "peachpuff",
#                     fillOpacity = .7,
#                     group = "Short-term Risk Forests") %>%
#         addLayersControl(overlayGroups = c("Oil Palm Deforestation", "Short-term Risk Forests",
#                                            "Long-term Risk Forests", "Indigenous Territories", 
#                                            "Protected Areas", "Former Protected Areas (PADDD)",
#                                            "Administrative Regions", "Ecoregions"),
#                          options = layersControlOptions(collapsed = FALSE, autoZIndex = TRUE)) %>%
#         hideGroup(c("Protected Areas", "Indigenous Territories",
#                     "Former Protected Areas (PADDD)", "Ecoregions"))
# # 
return(pmap)
}