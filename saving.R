#########################################
### Peru Map   5/6/2019
### save shapefiles as geojson objects
#########################################
### load libraries
library(rmapshaper) ; library(geojsonio) ; library (sf) ; library(raster)

### load files
deforestoilpalm <- raster('/nfs/vvijay-data/leafletperu/deforestoilpalm.tif')

longtermrisk <- st_read('/nfs/vvijay-data/leafletperu/riskmapbinaryMULTIPART.shp')

shorttermrisk <- longtermrisk %>% filter(gridcode == 1)

pa <- st_read('/nfs/vvijay-data/leafletperu/pa.shp')

indigenous <- st_read('/nfs/vvijay-data/leafletperu/indigenousWGS.shp')

paddd <- st_read('/nfs/vvijay-data/leafletperu/paddd.shp')

ecoregions <- st_read('/nfs/vvijay-data/leafletperu/ecoregionsWGS.shp')
ecoregions <- sf::st_cast(ecoregions, "POLYGON")

adminperu <- st_read('/nfs/vvijay-data/leafletperu/Departamento.shp')


### simplify files
deforestoilpalm %>% aggregate(fact = 4, filename = "/nfs/vvijay-data/leafletperu/deforestoilpalm_factor4.tif")

deforestoilpalm
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/deforestoilpalm.geojson")

longtermrisk %>% 
  rmapshaper::ms_simplify(keep = 0.05, keep_shapes = TRUE) %>%
  st_write("geojsons/longtermrisk.geojson")

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



