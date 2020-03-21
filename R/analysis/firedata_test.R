# require devtools and fireData packages
#if (!require("devtools")) install.packages("devtools")
#devtools::install_github("Kohze/fireData")

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

# average correct across all participants/conditions
mean(data$correct, na.rm = T)

# look at averages across groups
aggregate(correct~phase,data = data, mean)
hist(aggregate(correct~subject,data = data, mean)$correct)
agg<-aggregate(correct~subject*phase,data = data, mean)

# subset to sex question and t.test
sub<-subset(agg,agg$phase=="Sex")
t.test(sub$correct,mu = .5)

# subset to age question and t.test
sub<-subset(agg,agg$phase=="Age")
t.test(sub$correct,mu = 1/3)

# subset to language questions and t.test
sub<-subset(agg,agg$phase=="Language")
t.test(sub$correct,mu = .5)

# looking at frequence to choosing age buttons
hist(as.numeric(subset(data,data$phase=="Sex")$button_pressed))
hist(as.numeric(subset(data,data$phase=="Age")$button_pressed))
hist(as.numeric(subset(data,data$phase=="Language")$button_pressed))



# playing around with analysis
# library(ez)
# ezANOVA(data = subset(data,data$phase=="Age"),dv = correct,wid = subject,within = age_group,detailed = T)
