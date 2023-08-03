#Run random forest model using training data
#
#Predict RF to validation data
#
#Predict RF model to raster stack input variables and save to GTiff as final map


#Load packages
library(randomForest)
library(raster)
library(here)
library(caret) #for confusionMatrix()

#Return relative directory
here()

#Read training and validation data
trainDat =  read.csv(here("data", "trainingData.csv"))
  head(trainDat)
valDat =  read.csv(here("data", "validationData.csv"))
  head(valDat)

################################################################################
# Model specification
################################################################################
#Run randomForest on training data
trainDat$class_num <- as.factor(trainDat$class_num) #set class_num to factor for classification rather than regression

#Class number as a function of predictor variables
output.forest <- randomForest(class_num ~ CHM+GreenVariance+GreenSkewness+GreenEntropy+GreenBand2+ #<-change model variables here
                                  BlueBand3+RedBand1,
                                data=trainDat,
                                ntrees=1000)

#view forest results
print(output.forest)
#print importance of each variable (VIMP)
print(importance(output.forest, type=2))

#predict RF to validation points from ground control frames
validate <- predict(output.forest, valDat)

confusionMatrix(validate,valDat$class_num)

################################################################################
# Classification mapping
################################################################################
#Final Map
#read raster stack; names of rasters must match names of explanatory variables example: CHM=CHM.tif
inputs<-list.files('C:/Users/lee.davis/Desktop/temp/finalLayers', pattern =".tif", full.names =T)
inputs
stackDat <- stack(inputs)

#predict the RF to explanatory variables
r1 <-  raster::predict(object=stackDat, model=output.forest, progress="text")
#filename="outRaster.tif")






