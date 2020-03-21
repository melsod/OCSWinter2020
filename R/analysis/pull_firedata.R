# require devtools and fireData packages
# if (!require("devtools")) install.packages("devtools")
# devtools::install_github("Kohze/fireData")

library(fireData) # https://github.com/Kohze/fireData


# secret key = JTRER28zbNsqNrE0vZRoal74D3JujQaQHjrUG5FW

# download all files from database
dataBackup(projectURL = "https://ocswinter2020.firebaseio.com",
           secretKey = "JTRER28zbNsqNrE0vZRoal74D3JujQaQHjrUG5FW",
           "./data/data.json")


# install.packages("jsonlite")
library("jsonlite")

#data <- jsonlite::fromJSON(txt = "data.json")

# choose the short_exp_test_data.json file in R/analysis folder
# choose whatever data file you want to analyze
data<-unlist(jsonlite::fromJSON("./data/data.json"), recursive = FALSE, use.names = TRUE)

# install.packages("plyr")
library("plyr")

# collapse json levels
data<-rbind.fill(data)

# number of subjects
length(unique(data$subject))

