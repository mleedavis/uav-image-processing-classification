# uav-image-processing-classification

This repository contains example code flow to process and classify orthorectified UAV vegetation imagery 
to identify functional groups and species 

This requires processing orthomosaics, Digital Terrain Models (DTM), and 
Digital Surface Models (DSM) in 3rd party software, typically your flight
planning software, as input.

# Table of Contents

* [UAV phenology-based data aquisition and processing steps](https://github.com/mleedavis/uav-image-processing-classification#data-aquisition-and-processing-steps) 
* [Pre-processing imagery to obtain orthomosaics, DTM, and DSM rasters](https://github.com/mleedavis/uav-image-processing-classification#pre-processing-imagery-to-obtain-orthomosaics,-DTM,-and-DSM)


# Data aquisitions and processing steps

* Collect field data
  + Collect UAV imagery and field data including ground control points (GCPs) and vegetation data within at the species/functional group level of interest
* Process imagery
  + Process photos and GCPs in 3rd party software to obtain orthomosaics, DTM and DSMs
* Texture and Canopy Height Model calculation (use process-imagery.R)
  + Process orthomosaic bands to obtain first-order-occurrence measures for textural analysis
  + Caculate vegetation height (CHM)
* Image classification process (QGIS or similar and classify-imagery.R)
  + Clip orthomosaic raster to polygon to eliminate edge effects and no-data cells
  + Resample all rasters to the clipped basline raster
  + Clip resampled rasters to the clipped baseline raster
    ++ test
  

# Pre-processing imagery to obtain orthomosaics, DTM, and DSM
