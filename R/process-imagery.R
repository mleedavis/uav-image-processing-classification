#Create texture surfaces (entropy, variance, skewness) from raster image
#bands and Canopy Height Model (CHM) from imported Digital Surface Model (DSM)
#Digital Terrain Model (DTM)
#
#Note: import raster files as .tif

#Load dependencies
library(here)
library(sf)
library(raster)
library(tmap)
library(spatialEco)# for first-order occurrence measures on ortho image

#Set WD
#setwd("") #<- change working directory here; JK, don't do that, use here()
here()

#Load Rasters

#Load RGB bands here
green.dat <- raster(here("data", "greenBand.tif")) #<-example green band, change naming for red/blue
  st_crs(green.dat) #<-obtain crs; WGS84/EPSG4326 should be standard

#Load DSM and DTM
dsm.dat <- raster("data/dsm.tif")
dtm.dat <- raster("data/dtm/tif")

#Calculate 1st order texture surfaces
#Calculate neighborhood level entropy
green.entropy <- raster.entropy(green.dat,
                                d=15 #neighborhood 15 pixels
  )
  writeRaster(green.entropy, "output/OS_GreenEntropy.tif")

#Calculate neighborhood level variance
green.variance <- raster.moments(green.dat,
                                   type="var",
                                   s = 15) #neighborhood size 15 pixels

writeRaster(green.entropy, "output/OS_GreenVariance.tif")

#Calculate neighborhood level skewness
green.skewness <- raster.moments(green.dat,
                                   type="skew",
                                   s = 15) #neighborhood size 15 pixels

writeRaster(green.entropy, "output/OS_GreenSkewness.tif")

#Calculate Canopy Height Model; subtract dtm from dsm on cell-by-cell basis
chm <- dsm.dat-dtm.dat



