# save as geojson objects
library(rmapshaper)

deforestoilpalm <- st_read('data/deforestoilpalmWGS.shp')
pal <- colorNumeric("Oranges", deforestoilpalm$gridcode)

longtermrisk <- st_read('data/riskmapbinaryMULTIPART.shp')
shorttermrisk <- longtermrisk %>% filter(gridcode == 1)

pa <- st_read('data/pa.shp')
indigenous <- st_read('data/indigenousWGS.shp')
pacontent <- paste(sep = "<br/>", pa$NAME, pa$DESIG_ENG,
                   paste("IUCN Category: ", pa$IUCN_CAT))
paddd <- st_read('data/paddd.shp')
padddcontent <- paste(sep = "<br/>", paddd$Protected,
                      paste("PADDD Year: ", paddd$Year_PADDD))

ecoregions <- st_read('data/ecoregionsWGS.shp')
ecoregions <- sf::st_cast(ecoregions, "POLYGON")
pal3 <- colorNumeric(rainbow(13), ecoregions$OBJECTID)
adminperu <- st_read('data/Departamento.shp')

deforestoilpalm %>% 
  rmapshaper::ms_simplify() %>%
  st_write("geojsons/deforestoilpalm.geojson")

longtermrisk %>% 
  rmapshaper::ms_simplify() %>%
  st_write("geojsons/longtermreisk.geojson")

pa %>% 
  rmapshaper::ms_simplify() %>%
  st_write("geojsons/pa.geojson")

indigenous %>% 
  # rmapshaper::ms_simplify() %>%
  st_write("geojsons/indigenous_nonsimple.geojson")

paddd %>% 
  rmapshaper::ms_simplify() %>%
  st_write("geojsons/paddd.geojson")

ecoregions %>% 
  rmapshaper::ms_simplify() %>%
  st_write("geojsons/ecoregions.geojson")

adminperu %>% 
  rmapshaper::ms_simplify() %>%
  st_write("geojsons/admin.geojson")
