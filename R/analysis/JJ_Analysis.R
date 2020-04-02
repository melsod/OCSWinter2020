#Logistic Data pull out by Brad & Matt 

#install.packages("jsonlite")
library("jsonlite")

#data <- unlist(jsonlite::fromJSON("https://raw.githubusercontent.com/smitty0015/OCSWinter2020/master/R/analysis/short_exp_test_data.json"), recursive = FALSE, use.names = TRUE)
data <- unlist(jsonlite::fromJSON("./data/data.json"), recursive = FALSE, use.names = TRUE)


# install.packages("plyr")
library("plyr")

data <- rbind.fill(data)


extract_json <- function(key, survey_data){
  return(survey_data[[max(grep(key, survey_data))]])
}

# extract_subject_data <- function(d){
#   
#   # extract_json <- function(key, survey_data){
#   #   return(survey_data[[max(grep(key, survey_data))]])
#   # }
#   
#   # survey_data <- d$responses[d$phase == "Survey"]
#   # survey_data <- survey_data[! is.na(survey_data)]
#   # survey_data <- sapply(survey_data, fromJSON)
#   
#   data.frame(d$subject,
#              #mean(d$correct[d$phase == "Sex"], na.rm=TRUE),
#              #mean(d$correct[d$phase == "Language"], na.rm=TRUE),
#              #mean(d$correct[d$phase == "Age"], na.rm=TRUE),
#              #max(d$time_elapsed) / 60000,
#              as.numeric(extract_json("Childcare", survey_data)),
#              as.numeric(extract_json("Caregiver", survey_data)),
#              as.numeric(extract_json("Par_Age", survey_data)),
#              as.character(extract_json("Gender_Q", survey_data)[[1]]),
#              as.character(extract_json("Gender_Q", survey_data)[[2]]),
#              as.character(extract_json("Country_Q", survey_data)[[1]]),
#              as.character(extract_json("Country_Q", survey_data)[[2]]),
#              as.character(extract_json("Normal_hearing", survey_data)),
#              as.character(extract_json("Engl_first_lang", survey_data)),
#              as.character(paste0(extract_json("Know_corp_lang", survey_data))),
#              as.character(extract_json("monolingual", survey_data)),
#              stringsAsFactors = FALSE)
#   
# }

tidy_data <- data.frame(matrix(0, length(unique(data$subject))*34, 15))
count<-1
for(i in 1:length(unique(data$subject))){
  sub_data <- data[data$subject == unique(data$subject)[i],]
  survey_data <- sub_data$responses[sub_data$phase == "Survey"]
  survey_data <- survey_data[! is.na(survey_data)]
  survey_data <- sapply(survey_data, fromJSON)
  subject<-sub_data$subject[1]
  childcare<-as.numeric(extract_json("Childcare", survey_data))
  #if(is.na(childcare)==TRUE){as.numeric(strsplit(extract_json("Childcare", survey_data),split = " ")[[1]][1])} # subject typed "XX months" this with catch that
  if(is.na(childcare)==TRUE){
    childcare_txt<-strsplit(extract_json("Childcare", survey_data),split = " ")
    if(length(childcare_txt[[1]])==1){
      childcare_txt<-strsplit(extract_json("Childcare", survey_data),split = "-")
      childcare<-mean(c(childcare_txt[[1]][1],childcare_txt[[1]][-1]))
    }else{
      if(tolower(substring(text = childcare_txt[[1]][2],first = 1,last = 1))=="y"){
        childcare<-(12)*as.numeric(childcare_txt)[[1]][1]
      }else{
        childcare<-as.numeric(childcare_txt)[[1]][1]
      }
    }
  }
  caregiver<-as.numeric(extract_json("Caregiver", survey_data))
  if(is.na(caregiver)==TRUE){
    caregiver_txt<-strsplit(extract_json("Caregiver", survey_data),split = " ")
    if(length(caregiver_txt[[1]])==1){
      caregiver_txt<-strsplit(extract_json("Caregiver", survey_data),split = "-")
      caregiver<-mean(c(caregiver_txt[[1]][1],caregiver_txt[[1]][-1]))
    }else{
      if(tolower(substring(text = caregiver_txt[[1]][2],first = 1,last = 1))=="y"){
        caregiver<-(12)*as.numeric(caregiver_txt)[[1]][1]
      }else{
        caregiver<-as.numeric(caregiver_txt)[[1]][1]
      }
    }
  }
  if(is.na(caregiver)==TRUE){as.numeric(strsplit(extract_json("Caregiver", survey_data),split = " ")[[1]][1])}
  par_age<-as.numeric(extract_json("Par_Age", survey_data))
  par_gen<-as.character(extract_json("Gender_Q", survey_data)[[1]])
  par_gen_other<-as.character(extract_json("Gender_Q", survey_data)[[2]])
  par_country<-as.character(extract_json("Country_Q", survey_data)[[1]])
  par_country_other<-as.character(extract_json("Country_Q", survey_data)[[2]])
  hearing<-as.character(extract_json("Normal_hearing", survey_data))
  engl_first<-as.character(extract_json("Engl_first_lang", survey_data))
  know_corp<-as.character(paste0(extract_json("Know_corp_lang", survey_data)))
  monolingual<-as.character(extract_json("monolingual", survey_data))
  for(j in 1:nrow(sub_data)){
    if(sub_data$correct[j] %in% c(0,1)){
      tidy_data[count,] <- data.frame(subject,
                                      sub_data$correct[j],
                                      sub_data$phase[j],
                                      sub_data$time_elapsed[j]/60000,
                                      childcare,
                                      caregiver,
                                      par_age,
                                      par_gen,
                                      par_gen_other,
                                      par_country,
                                      par_country_other,
                                      hearing,
                                      engl_first,
                                      know_corp,
                                      monolingual,
                                      stringsAsFactors = FALSE)
      count<-count+1
    }
  }
  #tidy_data[i, ] <- extract_subject_data(data[data$subject == unique(data$subject)[i], ])
  #print(count)
}

colnames(tidy_data) <- c("subject_ID", "correct", "phase", "time_ellapsed_mins", "childcare", "caregiver", 
                         "age", "gender", "gender_text", "country", "country_text", "hearing", 
                         "eng_first", "know_corp_lang", "monolingual")


library(readr)
cleaned_subject_data <- read_csv("data/cleaned_subject_data.csv")
tidy_data<-subset(tidy_data,tidy_data$subject_ID%in%cleaned_subject_data$subject)


#································Follow Up Analysis ··············································

# if participants can identify sex

# Random intercept Model: Baseline
library(lme4)
model1<- glmer(correct~1+(1|subject_ID),
              data = subset(tidy_data,
                            tidy_data$gender%in%c("Male","Female") & tidy_data$phase=="Sex"),
              family = binomial(link=logit))
summary(model1)
confint(model1)

# Adding level 1 predictors: childcare & caredgiver
model2<- glmer(correct~1+childcare+caregiver+(1|subject_ID),
               data = subset(tidy_data,
                             tidy_data$gender%in%c("Male","Female") & tidy_data$phase=="Sex"),
               family = binomial(link=logit))
summary(model2)
confint(model2)

# Compare two models
anova(model1,model2)

# Adding level 2 predictor: Participant's gender
model3<- glmer(correct~1+childcare+caregiver+gender+(1|subject_ID),
                       data = subset(tidy_data,
                                     tidy_data$gender%in%c("Male","Female") & tidy_data$phase=="Sex"),
                       family = binomial(link=logit))
summary(model3)
confint(model3)

# Compare two models
anova(model2,model3)

#````````````````````````````````````````````````````````````````````````````````````````````````````````````
# if participants can identify language

# Random intercept Model: Baseline
library(lme4)
model1<- glmer(correct~1+(1|subject_ID),
               data = subset(tidy_data,
                             tidy_data$gender%in%c("Male","Female") & tidy_data$phase=="Language"),
               family = binomial(link=logit))
summary(model1)
confint(model1)

# Adding level 1 predictors: childcare & caredgiver
model2<- glmer(correct~1+childcare+caregiver+(1|subject_ID),
               data = subset(tidy_data,
                             tidy_data$gender%in%c("Male","Female") & tidy_data$phase=="Language"),
               family = binomial(link=logit))
summary(model2)
confint(model2)

# Compare two models
anova(model1,model2)

# Adding level 2 predictor: Participant's gender
model3<- glmer(correct~1+childcare+caregiver+gender+(1|subject_ID),
               data = subset(tidy_data,
                             tidy_data$gender%in%c("Male","Female") & tidy_data$phase=="Language"),
               family = binomial(link=logit))
summary(model3)
confint(model3)

# Compare two models
anova(model2,model3)

#`````````````````````````````````````````````````````````````````````````````````````````````````````````````
# if participants can identify age

# Random intercept Model: Baseline
library(lme4)
model1<- glmer(correct~1+(1|subject_ID),
               data = subset(tidy_data,
                             tidy_data$gender%in%c("Male","Female") & tidy_data$phase=="Age"),
               family = binomial(link=logit))
summary(model1)
confint(model1)

# Adding level 1 predictors: childcare & caredgiver
model2<- glmer(correct~1+childcare+caregiver+(1|subject_ID),
               data = subset(tidy_data,
                             tidy_data$gender%in%c("Male","Female") & tidy_data$phase=="Age"),
               family = binomial(link=logit))
summary(model2)
confint(model2)

# Compare two models
anova(model1,model2)

# Adding level 2 predictor: Participant's gender
model3<- glmer(correct~1+childcare+caregiver+gender+(1|subject_ID),
               data = subset(tidy_data,
                             tidy_data$gender%in%c("Male","Female") & tidy_data$phase=="Age"),
               family = binomial(link=logit))
summary(model3)
confint(model3)

# Compare two models
anova(model2,model3)
