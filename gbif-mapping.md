# Mapping Avicennia alba distribution

*Avicennia alba* Blume (synonym of *Avicennia marina* (Forssk.) Vierh) is one of the species we can found in Mangroves in Vietnam. 
We will use data from the Global Biodiversity Information Facility (GBIF) that can be retrieved from [the GBIF site](https://www.gbif.org/)
by using the R libraries **dismo** that deals with species distribution modeling and **maptools** that provides maps. 
As usual, we'll start defining our working directory and loading (and installing if needed) the required libraries.

```{r, setup, include=FALSE}
# establishing the working directory 
setwd("C:/datosR/virtualforest_IO2")
# installing different useful packages
install.packages("dismo")
install.packages("maptools")

library(dismo)
library(maptools)
```
Now we can retrieve the data from GBIF by using the following code (you can adapt it if you prefer to find other species) and 
check the dimension (numbers of columns and rows) and the names of the columns (variables' names)

```{r, setup, include=FALSE}
# data from gbif for Avicennia alba
Mam.trang <- gbif("Avicennia", "alba", geo=FALSE)

dim(Mam.trang)
colnames(Mam.trang)
```
Now we'll delete all the record with no geografical information and we'll keep only the Vietnamese observations

```{r, setup, include=FALSE}
#deleting record without longitude and latitude missing
Mam.trang <- subset(Mam.trang, !is.na(lon) & !is.na(lat)) 

Mam.trang <- subset (Mam.trang, country == 'Vietnam') #keeping only Vietnamese records
```
Finnally, we'll map the Avicennia alba observations in Vietnam

```{r, setup, include=FALSE}
data(wrld_simpl) # get the world map
plot(wrld_simpl, xlim=c(100,101), ylim=c(8,25), axes=TRUE, col="white")

box()  # restore the box around the map

# plot points where Avicennia alba
points(Mam.trang$lon, Mam.trang$lat, col='red' , pch=20, cex=0.75)
```
We should obtain this map with the Avicennia alba observations in red.

![images](https://github.com/Felipe-Bravo/VirtualForests-IO2/blob/master/images/Avicenia-alba.jpeg)


