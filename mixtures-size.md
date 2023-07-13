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
The name's variables is as follow

No:	Numerical order
Year:	Year of measurement
ODV:	Permanent sample plots ID
ONC:	Sub- Permanent sample plots ID
ODD:	Quadrat ID (from 1 to 25)
Order:	Tree ID at quadrat level
ID:	Tree ID at Permanent sample plot level
YID:	Tree ID at Permanent sample plot level in measured year
Species_vi:	Tree species in Vietnamese
Species_en:	Tree species in Vietnamese without accent
Species_sci:	Tree species in Latin (Unknown: Un identified; Not in report: Not included in final report but in excel raw data)
Peri_cm:	Perimeter at breast height (cm)
DBH_cm:	Diameter at breast height (cm)
Ht_m:	Total height (m)
Hdc_m:	Height to crown base (m)
E_m:	Crown length at East direction (m)
W_m:	Crown length at West direction (m)
S_m:	Crown length at South direction (m)
N_m:	Crown length at North direction (m)
Quality	Tree quality: a, b, c where
  a: is a straight, beautiful stemmed tree, with a long log, no pests or hollow;
  b: curved, deflected stem, a tree with a defect but still able to take advantage of 70% of the stem volume;
  c: is a tree with pests or dead ends, hollow, can use less than 30% of the trunk of the tree;
Long:	Longitude EPSG:4326 - WGS 84
Lat:	Latitude EPSG:4326 - WGS 84
Ghi_chu:	Note in Vietnamese 
Note:	Note in English
Hreg_m:	Total height (m) calculated from developed D-H model 
AGB_Hreg:	Total biomass weight calculated from DBH_cm and Hreg_m for whole tree (kg)
AGB_Ho:	Total biomass weight calculated from DBH_cm and Ht_m for whole tree (kg)
AGB_kg:	Equal to AGB_Hreg for tree without height measurement and equal to AGB_Ho for tree with height measured from the field (kg)

The aboveground biomass was calculated with the following equations:


For species listed in reports of FIPI
AGB=0.0547 ×DBH^2.1148×H^0.6131			Expected value of error (%): -0.5614	(Nguyễn et al., 2012)

For Mallotus philippinensis 
AGB=5.882 ×DBH^2.1.7251148	Adj. R2: 0.8561			(Dang et al., 2018)

For other species
AGB=e^(-3.1141+0.9719×ln⁡(DBH^2×H) )	Adj. R2: 0.97	MSE: 0.1161		(Brown et al., 1989)

where AGB is Above ground biomass (kg); H is Total height (m); DBH is Diameter at breast height (cm)
Expected value of error (%) is the error (in percentage) of the predicted total AGB as compared to the measured total AGB of a set of trees.

Equations were obtained from 
Brown, S., Gillespie, A. J. R., & Lugo, A. E. (1989). Biomass Estimation Methods for Tropical Forests with Applications to Forest Inventory Data. Forest Science, 35(4), 881–902 [https://doi.org/10.1093/forestscience/35.4.881](https://doi.org/10.1093/forestscience/35.4.881)
Dang, T. T. H., Do, H. T., Trinh, M. Q., Nguyen, H. M., Bui, T. T. X., & Nguyen, T. D. (2018). Allometric relations between biomass and diameter at breast height and height of tree in natural forests at Me Linh Station for Biodiversity, Vinh Phuc Province, Vietnam. Journal of Vietnamese Environment, 9(5), 264–271. [https://doi.org/10.13141/jve.vol9.no5.pp264-271](https://doi.org/10.13141/jve.vol9.no5.pp264-271)
Nguyễn, Đ. H., Lê, T. G., Đào, N. T., Phạm, T. H., Phạm, T. L., Nguyễn, T. K., & Hà, M. T. (2012). PART B-2: Tree allometric equations in Evergreen broadleaf and Bamboo forests in the North East region, Viet Nam. In UN -REDD Programme Vietnam (Issue October)[https://www.un-redd.org/sites/default/files/2021-10/Part%20B-2%20Tree%20allometric%20equations%20in%20Evergreen%20broadleaf%20and%20Bamboo%20forests%20in%20the%20North%20East%20region%2C%20Viet%20Nam.pdf](https://www.un-redd.org/sites/default/files/2021-10/Part%20B-2%20Tree%20allometric%20equations%20in%20Evergreen%20broadleaf%20and%20Bamboo%20forests%20in%20the%20North%20East%20region%2C%20Viet%20Nam.pdf]








