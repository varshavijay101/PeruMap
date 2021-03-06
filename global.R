####################################
### Peru Leaflet Map for Shiny
####################################

## Load libraries
# library(leaflet) ; library(sf) ; library(dplyr) ; 
# library(htmlwidgets) ; library(htmltools) ; library(fs) 
data_dir <- "/nfs/vvijay-public-data/PeruMap"
## Load data layers
deforestoilpalm <- st_read(file.path(data_dir, "geojsons/deforestoilpalm.geojson"))

longtermrisk <- st_read(file.path(data_dir, "geojsons/longtermrisk.geojson"))

shorttermrisk <- st_read(file.path(data_dir, "geojsons/shorttermrisk.geojson"))

pa <- st_read(file.path(data_dir,"geojsons/pa.geojson"))

indigenous <- st_read(file.path(data_dir, "geojsons/indigenous_nonsimple.geojson"))

paddd <- st_read(file.path(data_dir, "geojsons/paddd.geojson"))

ecoregions <- st_read(file.path(data_dir, "geojsons/ecoregions.geojson"))

adminperu <- st_read(file.path(data_dir, "geojsons/admin.geojson"))

## Add palettes and popups
pal <- colorNumeric("Oranges", deforestoilpalm$gridcode)

pal3 <- colorNumeric(rainbow(13), ecoregions$OBJECTID)
 
pacontent <- paste(sep = "<br/>", pa$NAME, pa$DESIG_ENG,
                   paste("IUCN Category: ", pa$IUCN_CAT))
 
padddcontent <- paste(sep = "<br/>", paddd$Protected,
                      paste("PADDD Year: ", paddd$Year_PADDD))

# Create an empty leaflet map and set zoom controls to prevent zooming outside study area
make_peru_map <- function(){
                 pmap <- leaflet(options = leafletOptions(zoomControl = TRUE, minZoom = 5)) %>%
                         addProviderTiles(providers$Esri.WorldImagery,
                                          options = providerTileOptions(minZoom = 4),
                                          group= "Esri World Imagery") %>%
                         addMiniMap(zoomLevelOffset = -4) %>% # Add minimap for reference
                         addScaleBar() %>% # Add scale bar
                         setView(lng = -71.622, lat = -9.0, zoom = 5) 

                 return(pmap)
                 }




