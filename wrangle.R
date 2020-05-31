#We need to load the readxl library to gring the .xls file in to R.
library(readxl)

#Load the FBI's UCR Data Set from 2016. First three rows are only informational.
alldat <- read_excel("data/crimedat.xls",skip=3)

#The last 7 row are footnote types. I should have a better way to detect this automatically.
#Find the overall length. Then slice off the last 7 entries.
len <- length(alldat[[1]])-7
alldat<-slice(alldat,1:len)

#We need metro areas. These are in the first column. But there are a lot of NA
#values due to formating. We'll need the location of the non-NA values in this 
#column in order to pick off the Metropolitan Area names.

ind1 <- which(!is.na(alldat[[1]]))
metro_areas <- alldat[[1]][ind1]

#Capture the populations of the metro areas as well.These are in the 3rd column
#and are indexed by the same values as the metro areas.
pop <- alldat[[3]][ind1]

#The Crime Stas are in the rows with a "Rate per 100,000 inhabitants" field in
#the second column. We find the index of each of these.In a logical comparison
#with an NA entry, we get NA rather than TRUE or FASLE. We need to replace 
#any NA in our index with a FALSE.

ind2 <- replace_na(alldat[[2]]=="Rate per 100,000 inhabitants",FALSE)

#Create variables for each category of violent crime.We capute only the rate
#and not the raw numbers.

vc <- alldat[[4]][ind2]
murd <- alldat[[5]][ind2]
rape <- alldat[[6]][ind2]
rob <- alldat[[7]][ind2]
ass <- alldat[[8]][ind2]
prop <- alldat[[9]][ind2]
burg <- alldat[[10]][ind2]
lt <- alldat[[11]][ind2]
mvt <- alldat[[12]][ind2]

#Note that there are NAs in some of these vectors.

#Create a data frame with the crime data in it.
crime_data2016 <- data.frame(Metro_Area = metro_areas,Population=pop,VC_Rate = vc,
                   Murder_NNH=murd,Rape=rape,Robbery=rob,Assault=ass,
                   Property=prop,Burglary=burg,Larceny_Theft=lt,
                   Motor_Vehicle_Theft=mvt)


