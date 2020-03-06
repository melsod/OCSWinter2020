# require devtools and fireData packages
#if (!require("devtools")) install.packages("devtools")
#devtools::install_github("Kohze/fireData")

library(fireData) # https://github.com/Kohze/fireData


# secret key = JTRER28zbNsqNrE0vZRoal74D3JujQaQHjrUG5FW

# download all files from database
# dataBackup(projectURL = "https://ocswinter2020.firebaseio.com",
#            secretKey = "JTRER28zbNsqNrE0vZRoal74D3JujQaQHjrUG5FW",
#            "data.json")


# install.packages("jsonlite")
library("jsonlite")

#data <- jsonlite::fromJSON(txt = "data.json")

# choose the short_exp_test_data.json file in R/analysis folder
data<-unlist(jsonlite::fromJSON(file.choose()), recursive = FALSE, use.names = TRUE)

#data<-unlist(jsonlite::fromJSON("./R/analysis/data.json"), recursive = FALSE, use.names = TRUE)
# install.packages("plyr")
library("plyr")
data<-rbind.fill(data)

mean(data$correct, na.rm = T)

aggregate(correct~phase,data = data, mean)
aggregate(correct~subject,data = data, mean)


hist(as.numeric(subset(data,data$phase=="Age")$button_pressed))



# install.packages("rjson")
# library(rjson)
#df<-as.data.frame(data$HVB58WohafSX2mPNi4ZDnucWkFt2)
# install.packages("jsonlite")
# library("jsonlite")
# data <- rjson::fromJSON(file = "data.json")
# data
# 
# data<-jsonlite::fromJSON("data.json")
# 
# data2<-unlist(data,recursive = FALSE,use.names = TRUE)
# 
# data3<-unlist(data2,recursive = FALSE)
# 
# data4<-data3[[1]]
# 
# par1<-data$HVB58WohafSX2mPNi4ZDnucWkFt2
# 
# par1<-data2$HVB58WohafSX2mPNi4ZDnucWkFt2.data
# 
# library(plyr)
# 
# new<-rbind.fill(data2)
# 
# 
# mean(new$correct, na.rm = T)
