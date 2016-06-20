install.packages("RStoolbox") # install 
library(IM)
library(tiff)
library(RStoolbox)
library(raster)
library(plotly)

setwd("V:\\_downloads\\GitHub\\Image_Mean\\")

#Scan directory and store filenames in string, then count total files
files <- as.character(list.files(path="./mean/input/"))
n <- length(files)

#Use first TIF as loop file, then add all together
m_image_tiff <- readTIFF(paste("./mean/input/",files[1],sep=""))
for (i in 2:n){
  test<-paste("./mean/input/",files[i],sep="")
  tiff <- readTIFF(paste("./mean/input/",files[i],sep=""))
  m_image_tiff <- (tiff+m_image_tiff)
}

#Calculate mean and write TIF
m_image_tiff <- (m_image_tiff/n)
writeTIFF(m_image_tiff,"./mean/mean_tiff.tif",bits.per.sample=16L)
#Histo Eq
#m_image_tiff <- histeq(m_image_tiff) #using raster package
m_image_tiff <- ggRGB(m_image_tiff, stretch = "hist") #using RStoolbox

writeTIFF(m_image_tiff,"./mean/mean_tiff_he.tif",bits.per.sample=16L)

#Read mean tif, then compare to in-memory
test_tiff <- readTIFF("./mean/mean_tiff.tif")
test_tiff[1,1,1]
test_tiff[1,1,2]
test_tiff[1,1,3]

m_image_tiff[1,1,1]
m_image_tiff[1,1,2]
m_image_tiff[1,1,3]
