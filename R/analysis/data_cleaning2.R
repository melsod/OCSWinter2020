# install.packages("jsonlite")
library("jsonlite")

# install.packages("plyr")
library("plyr")

data <- unlist(jsonlite::fromJSON("data_575.json"), recursive = FALSE, use.names = TRUE)

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
               as.numeric(var(d$button_pressed[d$phase == "Sex"] , na.rm=TRUE)),
               as.numeric(var(d$button_pressed[d$phase == "Language"] , na.rm=TRUE)),
               as.numeric(var(d$button_pressed[d$phase == "Age"] , na.rm=TRUE)),
               stringsAsFactors = FALSE)
    
}

tidy_data <- data.frame(matrix(0, length(unique(data$subject)), 20))

for(i in 1:length(unique(data$subject))){
    tidy_data[i, ] <- extract_subject_data(data[data$subject == unique(data$subject)[i], ])
}

colnames(tidy_data) <- c("suject_ID", "p_cor_sex", "p_cor_lang", "p_cor_age", "time_mins", "childcare", "caregiver", 
                         "age", "gender", "gender_text", "country", "country_text", "hearing", 
                         "eng_first", "know_corp_lang", "monolingual", "n_attention_checks",
                         "var_sex", "var_lang", "var_age")

tidy_data$know_corp_lang[tidy_data$know_corp_lang == "list()"] <- "None"

write.csv(tidy_data, "./cleaned_data.csv", row.names = FALSE)
