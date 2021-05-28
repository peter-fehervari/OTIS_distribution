########## libraries ############

library(tidyverse)
library(sf)
library(raster)

##### import data ########

# read in CLC and nösztép data for GIS prep
setwd("~/Documents/External_work/Tuzok2021/Distribution_Analyses/GIS/Static_raster_basemaps")
clc <- raster("CLC2018_HUN_adm0_masked.tif")
nosztep <- raster("OSZ_ALAPTERKEP_V4_0_LAEA.tif")

# agrotopo
setwd("~/Documents/External_work/Tuzok2021/Distribution_Analyses/GIS/agrotopo")
agrotopo <- st_read("AGROTOPO_lamberth.shp")

# 1x1 km grid overlay
setwd("~/Documents/External_work/Tuzok2021/Distribution_Analyses/GIS/Tuzok_1998_2018_alapadatok")
grid25 <- st_read(dsn="Mao_alap_basepoly_basepuffer_1x1grid_laea.gpkg",
                  layer = "Mao_alap_25x25grid_laea")
grid25 <- grid25[,1]
grid25

#return to home dir
setwd("~/Documents/External_work/Tuzok2021/Distribution_Analyses/OTIS_distribution")


####### data wrangle #########

# rasterize grid

#grid_rast<-rasterize(grid25,clc)
grid25_sp <- as_Spatial(grid25)
clc_extract_df <- extract(clc,grid25_sp,df = TRUE )
str(clc_extract_df)
nosztep_extract_df <- extract(nosztep,grid25_sp,df = TRUE )

write.table(nosztep_extract_df,"nosztep_extract_df_raw.csv",sep=",",dec=".",row.names = F)
write.table(clc_extract_df,"clc_extract_df_raw.csv",sep=",",dec=".",row.names = F)
