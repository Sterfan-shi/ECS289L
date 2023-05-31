# knitr::opts_chunk$set(echo = False)

stringify_coord <- function(coord) {
  if (coord < 0) {
    # print("coord is negative")
    scoord <- paste("m", as.character(-1*coord), sep = "")
  } else {
    # print("coord is non-negative")
    scoord <- as.character(coord)
  }
  # print(paste("scoord is:", scoord, sep = ""))
  return(scoord)
}

# sdir is for source directory; tdir is for target directory
inject_soil_profile <- function(sdir, tdir, lon, lat, model) {
  sp <- get_isric_soil_profile(lonlat = c(lon, lat))
  tag <- paste("-latlon_", stringify_coord(lat), "_", stringify_coord(lon), sep="")
  edit_apsimx_replace_soil_profile(
    file = model,
    src.dir = sdir,
    wrt.dir = tdir,
    soil.profile = sp,
    edit.tag = tag,
    overwrite = FALSE,
    verbose = TRUE
  )
}


library(ggplot2)
library(apsimx)

lll <- list(c(-17.6,30.8), c(-17.6,31.3), c(-17.6,31.8), c(-17.6,32.3), c(-17.6,32.8), 
            c(-18.1,30.8), c(-18.1,31.3), c(-18.1,31.8), c(-18.1,32.3), c(-18.1,32.8), 
            c(-18.6,30.8), c(-18.6,31.3), c(-18.6,31.8), c(-18.6,32.3), c(-18.6,32.8),
            c(-19.1,30.8), c(-19.1,31.3), c(-19.1,31.8), c(-19.1,32.3), c(-19.1,32.8)
            )
            

sdir <- "~/Desktop"
tdir <- "~/Desktop/X"
model_prefix <- "Soybean-A"
model_suffix <- ".apsimx"
model <- paste(model_prefix, model_suffix, sep="")


for (lonlat in lll) {
  tag <- paste("-latlon_", stringify_coord(lonlat[2]), "_", stringify_coord(lonlat[1]), sep="")
  inject_soil_profile(sdir, tdir, lonlat[2], lonlat[1], model)
}

#tag <- paste("-lonlat_", stringify_coord(lon), "_", stringify_coord(lat), sep="")
 
#inject_soil_profile(sdir, tdir, lon, lat, model)

