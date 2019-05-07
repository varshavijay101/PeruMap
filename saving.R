#########################################
### Peru Map   5/6/2019
### save shapefiles as geojson objects
#########################################
### load libraries
library(rmapshaper) ; library(geojsonio) ; library (sf) ; library(tidyverse) 

### load files
deforestoilpalm <- st_read('/nfs/vvijay-data/leafletperu/deforestoilpalmWGS.shp')

longtermrisk <- st_read('/nfs/vvijay-data/leafletperu/riskmapbinaryMULTIPART.shp')

shorttermrisk <- longtermrisk %>% filter(gridcode == 1)

pa <- st_read('/nfs/vvijay-data/leafletperu/pa.shp')

indigenous <- st_read('/nfs/vvijay-data/leafletperu/indigenousWGS.shp')

paddd <- st_read('/nfs/vvijay-data/leafletperu/paddd.shp')

ecoregions <- st_read('/nfs/vvijay-data/leafletperu/ecoregionsWGS.shp')
ecoregions <- sf::st_cast(ecoregions, "POLYGON")

adminperu <- st_read('/nfs/vvijay-data/leafletperu/Departamento.shp')

### add color palettes and pop-ups
# pal <- colorNumeric("Oranges", deforestoilpalm$gridcode) 
# deforestoilpalm <- deforestoilpalm %>% 
#                    mutate(col_pal = pal(gridcode))
# 
# pal3 <- colorNumeric(rainbow(13), ecoregions$OBJECTID) 
# ecoregions <- ecoregions %>% 
#               mutate(col_pal = pal3(OBJECTID))
# 
# pacontent <- paste(sep = "<br/>", pa$NAME, pa$DESIG_ENG,
#                    paste("IUCN Category: ", pa$IUCN_CAT))
# pa <- pa %>% mutate(popup = pacontent)
# 
# padddcontent <- paste(sep = "<br/>", paddd$Protected,
#                       paste("PADDD Year: ", paddd$Year_PADDD))
# paddd <- paddd %>% mutate(popup = padddcontent)

### simplify files
deforestoilpalm %>% 
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/deforestoilpalm.geojson")
  # geojson_list() %>% geojson_write(file = "./geojsons/deforestoilpalm.geojson")

longtermrisk %>% 
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/longtermrisk.geojson")
  # geojson_list() %>% geojson_write(file = "./geojsons/longtermrisk.geojson")

shorttermrisk %>% 
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/shorttermrisk.geojson")

pa %>% 
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/pa.geojson")

indigenous %>% 
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/indigenous_nonsimple.geojson")

paddd %>% 
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/paddd.geojson")

ecoregions %>% 
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/ecoregions.geojson")

adminperu %>% 
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/admin.geojson")



