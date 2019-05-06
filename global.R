####################################
### Peru Leaflet Map for Shiny
####################################

## Load libraries
library(leaflet) ; library(webshot) ; library(sf) ; library(raster) ; 
library(dplyr) ; library(htmlwidgets) ; library(htmltools) ; library(fs) ;
library(jsonlite)

## Load data layers
gjs_files <- fs::dir_ls("geojsons")

layer_list <- gjs_files %>% purrr::map(~readLines(.x))
layer_list <- layer_list %>% purrr::map(~paste(.x, collapse = "\n")) 
names(layer_list) <- basename(gjs_files)


deforestoilpalm <- layer_list[[2]]

longtermrisk <- layer_list[[5]]

shorttermrisk <- layer_list[[8]]

pa <- layer_list[[6]]

indigenous <- layer_list[[4]]

paddd <- layer_list[[7]]

ecoregions <- layer_list[[3]]

adminperu <- layer_list[[1]]

## Add palettes and popups
deforestoilpalm$style <- list(color = "orange", weight = 0.2, fill = TRUE, fillOpacity = 1)
pal <- colorNumeric("Oranges", deforestoilpalm$gridcode)
deforestoilpalm$features <- lapply(deforestoilpalm$features, function(feat) {
                                   feat$properties$style <- list(fillColor = ~pal(gridcode))
                                   feat
                                   })

# Create an empty leaflet map and set zoom controls to prevent zooming outside study area
make_peru_map <- function(){
                 pmap <- leaflet(options = leafletOptions(zoomControl = TRUE, minZoom = 5)) %>%
                         addProviderTiles(providers$Esri.WorldImagery,
                                          options = providerTileOptions(minZoom = 4),
                                          group= "Esri World Imagery") %>%
                         addMiniMap(zoomLevelOffset = -4) %>% # Add minimap for reference
                         addScaleBar() %>% # Add scale bar
                         setView(lng = -71.622, lat = -9.0, zoom=6)
                 
                 return(pmap)
                 }



