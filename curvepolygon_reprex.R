library(reprex)
library(sf)
library(dplyr)

# Download example data
# This repo available: https://github.com/ARMurray/example_data
# gpkg: https://github.com/ARMurray/example_data/blob/master/data/gc_cast.gpkg

# load data
sf <- st_read("./data/gc_cast.gpkg")

# A singular CURVEPOLYGON
cp <- sf%>%
  filter(COMID == "167120949")

# extract nested geometries
geoms <- lapply(cp$geom, `[`)

# cast to different geom
mp <- lapply(geoms, function(x) sf::st_multipolygon( x = x ) )

# Create sf object
sf_mp <- sf::st_sfc(mp)%>%
  st_sf()

# Check and Plot
sf_mp
plot(sf_mp)


# Multiple CURVEPOLYGONS
mcp <- sf%>%
  filter(COMID == "21411435")

m.geoms <- lapply(mcp$geom, `[`)

# This throws error: "Error in vapply(y, ncol, 0L) : values must be length 1, but FUN(X[[1]]) result is length 0"
m.mp <- lapply(m.geoms, function(x) sf::st_multipolygon( x = x ) )
