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
* Texture Analysis and Canopy Height Model calculation (use process-imagery.R)
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
  

# Pre-processing Imagery to Obtain Orthomosaics, DTM, and DSM
Pre-processing imagery to orthorectify imagery, produce final orthomosaics, incorporate ground control points, and produce digital terrain and digital surface models can be carried out in a variety of proprietary and open source softwares. An example image should look something like this green band which has been extracted from a final mosaic (for ease of display the green band is rendered with a blan to white stretch here...): 


![](images/OS_GreenBand2.png)

# Texture Analysis and Canopy Height Model Calculation
Texture analysis is used to generate additional predictor variables beyond red-blue-green values obtained from image pixels.  Texture analysis defines a new pixel value based on neighboring rgb values. Neighborhoods with similar values (bare ground for instance) will result in 'smoother' textures than neighborhoods with dissimilar values (shrubs, trees, or other 'rougher' surfaces). This step can be very slow for larger extents  (modification to loop through parallel process on the to-do list). 

Neighborhood variance, entropy and skewness are computed here. Neighborhood (window) size should be set based on the number of pixels that covers objects of interest. In this example a neighborhood of 15 pixels was utilized.  

This example raster is a zoomed in view of a smaller area from the image above:


![](images/OS_GreenBand2_clip.png)

# Image Classification with Random Forests

