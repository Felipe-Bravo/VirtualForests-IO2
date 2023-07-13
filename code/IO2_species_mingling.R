# establishing the working directory 

setwd("C:/datosR/virtualforest_IO2")

# defining output options

options(digits=6) # number of digits to print on output 
options(OutDec=".") # use dot as decimal separator

# loading the data sets 
datos.m<- 
  read.csv2("ODV83_AGB_ONC3.csv",sep=",",dec=".",header=T,na.string="NA")

# basic features of our dataframe

names(datos.m)
head(datos.m)
tail(datos.m)

# calculating the distance to the nearest trees

dist.m<-data.frame()

nvecinos<-3 # defining the number of neighbours

# starting the loop
for (i in 1:nrow(datos.m)){
  distij <- ((datos.m$Long[i]-datos.m$Long)^2+(datos.m$Lat[i]-datos.m$Lat)^2)^(1/2) 
  # obtaining the distance from tree i (our target) to every tree
  
  
  # now we identify the tree i and its neighbours and order it from closest to 
  # farthest distance to our target tree
  temp<-data.frame(arbol=datos.m$ID[i],vecino=datos.m$ID,
                   sp.arbol=datos.m$Species_sci[i],sp.vecino=datos.m$Species_sci,
                   dbh.arbol=datos.m$DBH_cm[i],dbh.vecino=datos.m$DBH_cm,
                   H.arbol=datos.m$Ht_m[i],H.vecino=datos.m$Ht_m,
                   distij)
  temp<-temp[order(distij),]
  
  # delete the first raw because is our target tree i (closest one to tree i)
  temp<-temp[-1,]
  vecinos<-temp[1:nvecinos,]  # select the nvecinos trees closest to tree i
  
  dist.m <- rbind(dist.m,vecinos) # now joint the result with our original
} 
# close the loop

head(dist.m)  # to finish this part we check the new structure of our dataset
###################
# Define the mixture variable for each tree, 0 if the species is the same 
# 1 otherwise

dist.m$Vij <- ifelse ((dist.m$sp.arbol==dist.m$sp.vecino), 0, 1)
write.csv(dist.m,file="dist_m.csv") # write the outcome in the working directory
head (dist.m) # check if everything is ok


# we calculate the mingling index for each target tree for the nearest neighbours

nfilas =seq(1,length(dist.m[,1]), by=nvecinos)
resultado=c()
# for each different tree
for (i in nfilas){
  vectordindices = c()
  # keep the mingling index value for each target tree
  for (j in seq(0,nvecinos-1)){
    vectordindices=c(vectordindices, dist.m$Vij[i+j])
  }
  # calculate the average of the mingling index for each tree and store it
  indiceagregadoi = mean(vectordindices)
  resultado=c(resultado,rep(indiceagregadoi,nvecinos))
}
# add the mingling indext to our data
resultado <-as.matrix(resultado)
colnames(resultado)<-"Mi"
dist.m=cbind(dist.m,resultado)
head(dist.m) # check if everything is ok

new <- dist.m[nfilas,] 
names (new) # check the order of the columns

mixture <- new [,c(1,3,5,7,9,11)] #select the columns with the i tree information

# check if everything is ok
names(mixture)
head(mixture)
tail(mixture)
#################
linear.model <- lm(mixture$dbh.arbol ~ mixture$Mi)
summary(linear.model)
AIC(linear.model)

