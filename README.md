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
  + Collect UAV imagery and field data including ground control points (GCPs) and vegetation data within at the species/functional group level of interest: see documents folder for details and basic overview
* Process imagery
  + Process photos and GCPs in 3rd party software to obtain orthomosaics, DTM and DSMs
* Texture and Canopy Height Model calculation (use process-imagery.R)
  + Process orthomosaic bands to obtain first-order-occurrence measures for textural analysis
  + Caculate vegetation height (CHM)
* Image classification process (QGIS or similar)
  +Prep raster data 
    - Clip orthomosaic raster to polygon to eliminate edge effects and no-data cells
    - Resample all rasters to the clipped basline raster
    - Clip resampled rasters to the clipped baseline raster
  +Prep Training and Validation data
    - Training data: photo-interpret patches of pure vegetation, assign unique class codes, generate random sample points
    _ Validation data: assign uniqie class codes to GCPs, generate random sample points
    _ Join random sample points to their polygons/GCPs and then extract values for all input raster varibles to random sample points; there should be a column for all response and explanotory variables in the resulting attribute tables
* Random Forest Classification (classify-imagery.R)
  

# Pre-processing imagery to obtain orthomosaics, DTM, and DSM
Pre-processing imagery to orthorectify imagery, produce final orthomosaics, incorporate ground control points, and produce digital terrain and digital surface models can be carried out in a variety of proprietary and open source softwares. An example image should look something like this: 


![caption.](images/OS_GreenBand2.png)


