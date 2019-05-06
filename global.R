## Load libraries
library(leaflet)
library(webshot)
library(sf)
library(raster)
library(dplyr)
library(htmlwidgets)
library(htmltools)



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


