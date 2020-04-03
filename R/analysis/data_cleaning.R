# install.packages("jsonlite")
library("jsonlite")

# install.packages("plyr")
library("plyr")

data <- unlist(jsonlite::fromJSON("data/final_data.json"), recursive = FALSE, use.names = TRUE)

data <- rbind.fill(data)

extract_subject_data <- function(d){
    
    extract_json <- function(key, survey_data){
        return(survey_data[[max(grep(key, survey_data))]])
    }
    
    survey_data <- d$responses[d$phase == "Survey"]
    survey_data <- survey_data[! is.na(survey_data)]
    survey_data <- sapply(survey_data, fromJSON)
    
    data.frame(d$subject,
               mean(d$correct[d$phase == "Sex"], na.rm=TRUE),
               mean(d$correct[d$phase == "Language"], na.rm=TRUE),
               mean(d$correct[d$phase == "Age"], na.rm=TRUE),
               max(d$time_elapsed) / 60000,
               min(d$time_elapsed) / 60000, # BCS added
               (max(d$time_elapsed)-min(d$time_elapsed)) / 60000, # BCS added
               max(as.numeric(d$rt[d$phase == "Sex" | d$phase == "Language" | d$phase == "Age"]),na.rm = T), #BCS added
               as.numeric(extract_json("Childcare", survey_data)),
               as.numeric(extract_json("Caregiver", survey_data)),
               as.numeric(extract_json("Par_Age", survey_data)),
               as.character(extract_json("Gender_Q", survey_data)[[1]]),
               as.character(extract_json("Gender_Q", survey_data)[[2]]),
               as.character(extract_json("Country_Q", survey_data)[[1]]),
               as.character(extract_json("Country_Q", survey_data)[[2]]),
               as.character(extract_json("Normal_hearing", survey_data)),
               as.character(extract_json("Engl_first_lang", survey_data)),
               as.character(paste0(extract_json("Know_corp_lang", survey_data))),
               as.character(extract_json("monolingual", survey_data)),
               as.numeric(sum(d$phase == "Attention_Check", na.rm=TRUE)),
               as.numeric(sum(d$phase == "audio_check", na.rm=TRUE))/2,
               as.numeric(var(d$button_pressed[d$phase == "Sex"] , na.rm=TRUE)),
               as.numeric(var(d$button_pressed[d$phase == "Language"] , na.rm=TRUE)),
               as.numeric(var(d$button_pressed[d$phase == "Age"] , na.rm=TRUE)),
               stringsAsFactors = FALSE)
    
}

tidy_data <- data.frame(matrix(0, length(unique(data$subject)), 24))

for(i in 1:length(unique(data$subject))){
    tidy_data[i, ] <- extract_subject_data(data[data$subject == unique(data$subject)[i], ])
}

# BCS add some time measures
colnames(tidy_data) <- c("subject_ID", "p_cor_sex", "p_cor_lang", "p_cor_age", "time_mins","fin_consent_mins","consent_to_fin_mins", "max_RT_exp_trials", "childcare", "caregiver", 
                         "age", "gender", "gender_text", "country", "country_text", "hearing", 
                         "eng_first", "know_corp_lang", "monolingual", "n_attention_checks", "n_audio_checks",
                         "var_sex", "var_lang", "var_age")

tidy_data$know_corp_lang[tidy_data$know_corp_lang == "list()"] <- "None"

write.csv(tidy_data, "./data/cleaned_data.csv", row.names = FALSE)

###################################################################
########### Now Incoperating Data Exclusions ################## BCS
###################################################################

w_exclusions_data <- tidy_data[tidy_data$n_attention_checks <=5,] #only those who took 5 or less tries on attention check
w_exclusions_data <- w_exclusions_data[w_exclusions_data$n_audio_checks <= 5, ] # only those who took 5 or less tries on audio check
w_exclusions_data <- w_exclusions_data[w_exclusions_data$gender %in% c("Female", "Male"), ] # only those who idetify as Male or Female
w_exclusions_data <- w_exclusions_data[w_exclusions_data$country %in% c("Canada", "USA"), ] # only those who reside in Canada/USA
w_exclusions_data <- w_exclusions_data[w_exclusions_data$eng_first == "Yes", ] # only those who first language is english
w_exclusions_data <- w_exclusions_data[w_exclusions_data$know_corp_lang == "None", ] # do not know any of the corpus langauges
w_exclusions_data <- w_exclusions_data[w_exclusions_data$var_sex > 0 & w_exclusions_data$var_lang > 0 & w_exclusions_data$var_age > 0, ] # remove those who only chose 1 response for a full block of trials

write.csv(w_exclusions_data, "./data/w_exclusions_data.csv", row.names = FALSE)