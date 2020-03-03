# Open the OSCWinter2020 R Project

# read in functions for making stimuli
source("./R/pre_experiment/OCSWinter2020_functions.R")
# install.packages("tidyverse")
# install.packages("here")
# install.packages("plyr")
library(tidyverse)
library(here)
library(plyr)

#set working directory to where private metadata and unzipped clips direcotry live
#setwd("C:/Users/Matt/Downloads/")

# Will need the private_metadata.csv file from BabbleCor: https://osf.io/rz4tx/
# by contacting the authours and submitting the data usage agreement
# put the file in your project folder but DO NOT share publicly on github
d <- read.csv("private_metadata.csv")

# remove the - sign. It causes problems later
d$corpus<-revalue(d$corpus, c("Casillas-Yeli"="CasillasYeli"))

#add a column called with a unique id (the original child id pasted together with the corpus)
d <- d %>% mutate(unique_id = paste0(child_ID, corpus))

#get rid of data from the warlaumont corpus
d <- d %>% filter(corpus != c("Warlaumont"))

#make a new column with the language
d <- d %>% mutate(language = ifelse(corpus == "Seedlings",
                                    "English",
                                    "Non-English"))

#make a categorical age variable based on 07, 8-18, and 19-36 groupings
d <- d %>% mutate(age_groups = ifelse(age_mo_round <= 7,
                                      "0-7",
                                      ifelse(age_mo_round <= 18,
                                             "8-18",
                                             "19-36")))

#make grouping variable for age-language question
d <- d %>% mutate(age_language = paste0(age_groups, language))

#keep only canonical and non-canonical
d <- d %>% filter(Answer %in% c("Canonical", "Non-canonical"))




###SAMPLE FOR AGE-LANGUAGE RESEARCH QUESTION:

#split into six groups (age*language)
s <- split(d, d$age_language)

#sample n unique ids
min_n <- min(sapply(s, function(x){length(unique(x$unique_id))}))
ids <- sapply(s, function(x){sample(unique(x$unique_id), min_n, FALSE)})
ids <- c(ids)

#sample n clips from each of those unique ids
n_clips <- 20 # should be 20 then narrowed down: will need to write it so that we read in the files from the correct folder and then get the data
set.seed(1234)
inds <- sapply(ids, function(x){
    sample(which(d$unique_id %in% x), n_clips, FALSE)
})
inds <- c(inds)

selected_files <- d[inds, ]

selected_files$file_id <- paste0(selected_files$unique_id, selected_files$clip_ID)


#get rejected files list
rejected_files <- list.files("./audio/selected_audio_files_age-language_Michael/selected_audio_files_age-language/EXCLUDED",
                        pattern = "*.wav")

#remove flaged files
selected_files <- selected_files[ ! selected_files$clip_ID %in% rejected_files, ]

table(selected_files$unique_id)

selected_files <- selected_files %>%
    group_by(unique_id) %>%
    sample_n(10)

table(selected_files$unique_id)
table(selected_files$age_language)



#dir.create("./audio/selected_audio_files_age-language")
#file.copy(from = paste0("./audio/clips_corpus/", selected_files$clip_ID),
#          to = "./audio/selected_audio_files_age-language",
#          overwrite = TRUE)
unlink("./audio/selected_audio_files", recursive = TRUE)
dir.create("./audio/selected_audio_files")
file.copy(from = paste0("./audio/clips_corpus/", selected_files$clip_ID),
          to = "./audio/selected_audio_files",
          overwrite = TRUE)

# create age-language test stimuli
txt<-"var age_language_stim = [\n"
for (i in unique(selected_files$unique_id)){
    txt<-paste0(txt,json_entry(selected_files, i))
}
txt<-paste0(txt,"]")
writeLines(txt,"./stimuli/age_language_test_stimuli.js")
#cat(txt)
#cat(json_entry(selected_files, "26Seedlings"))

###SAMPLE FOR SEX RESEARCH QUESTION:

#sample equal number of babies both male and female only non-English all from the same age group
d <- d %>% filter(language == "Non-English" & age_groups == "8-18")
s <- split(d, d$child_gender)

#sample n unique ids
min_n <- min(sapply(s, function(x){length(unique(x$unique_id))}))
ids <- sapply(s, function(x){sample(unique(x$unique_id), min_n, FALSE)})
ids <- c(ids)

#sample n clips from each of those unique ids
n_clips <- 20
set.seed(1234)
inds <- sapply(ids, function(x){
    sample(which(d$unique_id %in% x), n_clips, FALSE)
})
inds <- c(inds)

selected_files <- d[inds,]

selected_files$file_id <- paste0(selected_files$unique_id, selected_files$clip_ID)


#get rejected files list
rejected_files <- list.files("./audio/selected_audio_files_sex_Michael/selected_audio_files_sex/EXCLUDED",
                             pattern = "*.wav")

#remove flaged files
selected_files <- selected_files[ ! selected_files$clip_ID %in% rejected_files, ]

table(selected_files$unique_id)

selected_files <- selected_files %>%
    group_by(unique_id) %>%
    sample_n(10)

table(selected_files$unique_id)
table(selected_files$child_gender)

#dir.create("./audio/selected_audio_files_sex")
#file.copy(from = paste0("./audio/clips_corpus/", selected_files$clip_ID),
#          to = "./audio/selected_audio_files_sex",
#          overwrite = TRUE)
file.copy(from = paste0("./audio/clips_corpus/", selected_files$clip_ID),
          to = "./audio/selected_audio_files",
          overwrite = TRUE)


# create age-language test stimuli
txt<-"var sex_stim = [\n"
for (i in unique(selected_files$unique_id)){
    txt<-paste0(txt,json_entry(selected_files, i))
}
txt<-paste0(txt,"]")
writeLines(txt,"./stimuli/sex_test_stimuli.js")
