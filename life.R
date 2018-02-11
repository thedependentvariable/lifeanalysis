library(googlesheets)
library(dplyr)
gs_ls()
be <- gs_title("Obituaries Dataset")
gs_ws_ls(be)
mydata <- gs_read(ss=be,ws = "Data")
apply(mydata['Morgue'], 2, function(x) length(which(!is.na(x))))
mean(mydata$Size,na.rm = TRUE)
head(mydata$Size)

# ============ Removing Wrongly calculated dates, which are negative and those greater than 100 =======
mydata$Death_to_Burial = as.numeric(as.character(mydata$Death_to_Burial))

# Death to Burial


#Group by county to get Average age per county
meanpercounty <- mydata %>%
  dplyr::group_by(mydata$County_Burial) %>%
  dplyr::summarise(mean = mean(mydata$Age,na.rm=TRUE))
meanpercounty
