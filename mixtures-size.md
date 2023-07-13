# Analysis of the effect of mixture on tree size in evergreen subtropical forests in Vietnam
## Pipeline
### 1. Preparatory actions
### 2. Obtaining ground data
### 3. Importing remote sensing data from Earth Explorer

---------------------


### Preparatory actions
The first step is to define a working directory for your work. Normally, I have a folder in the root directory where I create inside a subfolder for each project.
You can use your own path and folder names. In this case my working directory will be C:\datosR\virtualforest_IO2

```{r, setup, include=FALSE}
# establishing the working directory 
setwd("C:/datosR/virtualforest_IO2")
```

Next we have to define the output options such as number of digits used and the decimal separator used in the database

```{r, setup, include=FALSE}
# defining output options

options(digits=6) # number of digits to print on output 
options(OutDec=".") # use dot as decimal separator
```
### Obtaining data from our working directory
We'll use data from the National Forest Inventory of Vietnam. You can get detailed information about this dataset at this [link](https://github.com/Felipe-Bravo/VirtualForests-IO2/blob/master/EvergreenBroadleave_northernVietnam-dataDescription.md)
In the following image you can see where the plot is located in Vietnam

<img src="https://github.com/Felipe-Bravo/VirtualForests-IO2/blob/master/images/Map_3SubPSP.png" style="display: block; margin: auto;" />
Plots location in Northern Vietnam (prepared by Doan Thi Nhat Minh)

After loading the dataset we should check the basic features to detect any inconsistence.
```{r, setup, include=FALSE}
# loading the data sets 
datos.m<- 
  read.csv2("ODV83_AGB_ONC3.csv",sep=",",dec=".",header=T,na.string="NA")

# basic features of our dataframe
names(datos.m)
head(datos.m)
tail(datos.m)
```


