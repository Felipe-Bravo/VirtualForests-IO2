# establishing the working directory 

setwd("C:/datosR/virtualforest_IO2")
# installing different useful packages
install.packages("dismo")
install.packages("maptools")

library(dismo)
library(maptools)

# data from gbif for Avicennia alba
Mam.trang <- gbif("Avicennia", "alba", geo=FALSE)

dim(Mam.trang)
colnames(Mam.trang)

#deleting record without longitude and latitude missing
Mam.trang <- subset(Mam.trang, !is.na(lon) & !is.na(lat)) 

Mam.trang <- subset (Mam.trang, country == 'Vietnam') #keeping only Vietnamese records

data(wrld_simpl) # get the world map
plot(wrld_simpl, xlim=c(100,101), ylim=c(8,25), axes=TRUE, col="white")

box()  # restore the box around the map

# plot points where Avicennia alba
points(Mam.trang$lon, Mam.trang$lat, col='red' , pch=20, cex=0.75)
