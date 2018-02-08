library(googlesheets)
library(dplyr)
gs_ls()
be <- gs_title("Obituaries Dataset")
gs_ws_ls(be)
mydata <- gs_read(ss=be,ws = "Data")
apply(mydata['Morgue'], 2, function(x) length(which(!is.na(x))))
mean(mydata$Size,na.rm = TRUE)
head(mydata$Size)

//Removing Wrongly calculated dates, which are negative and those greater than 100
mydata$Death_to_Burial = as.numeric(mydata$Death_to_Burial)
for(i in 1:nrow(mydata['Death_to_Announce']))
{
  if(is.na(mydata$Death_to_Burial[i])){
    mydata$Death_to_Burial[i] = "NA"
  }else if(mydata$Death_to_Burial[i] <= 100)
    {
    mydata$Death_to_Burial[i] = mydata$Death_to_Burial[i]
  }else if(mydata$Death_to_Burial[i] >= 101){
    mydata$Death_to_Burial[i] = "NA"
  }else if(mydata$Death_to_Burial[i] <= 0){
    mydata$Death_to_Burial[i] = "NA"
  }
}

//Group by county to get Average age per county
meanpercounty <- mydata %>%
  dplyr::group_by(mydata$County_Burial) %>%
  dplyr::summarise(mean = mean(mydata$Age,na.rm=TRUE))
meanpercounty
