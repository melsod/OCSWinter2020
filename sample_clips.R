# install.packages("tidyverse")
library(tidyverse)

#set working directory to where private metadata and unzipped clips direcotry live
<<<<<<< HEAD
try(setwd("/home/smithb/Dropbox/PSYC7310Open"))
try(setwd("C:/Users/brads/Dropbox/PSYC7310Open"))
file<-file.choose()
d <- read.csv(file)

#remove "-" from Casillas-Yeli as it causes problems in experiment
library(plyr)
d$corpus<-revalue(d$corpus, c("Casillas-Yeli"="CasillasYeli"))
=======
setwd("C:/Users/Matt/Downloads/")
d <- read.csv("private_metadata.csv")
>>>>>>> 016d1a57d4d6b314891ab7a28cd2b4e34f32f4b3

#add a column called with a unique id (the original child id pasted together with the corpus)
d <- d %>% mutate(unique_id = paste0(child_ID, corpus))

#get rid of data from the warlaumont corpus
d <- d %>% filter(corpus != c("Warlaumont"))

#make a new column with the language
<<<<<<< HEAD
d <- d %>% mutate(language = ifelse(corpus == "Seedlings",
=======
d <- d %>% mutate(language = ifelse(corpus == "Seedlings", 
>>>>>>> 016d1a57d4d6b314891ab7a28cd2b4e34f32f4b3
                                    "English",
                                    "Non-English"))

#make a categorical age variable based on 07, 8-18, and 19-36 groupings
<<<<<<< HEAD
d <- d %>% mutate(age_groups = ifelse(age_mo_round <= 7,
                                      "0-7",
                                      ifelse(age_mo_round <= 18,
                                             "8-18",
                                             "19-36")))

d <- subset(d,d$age_groups=="8-18"&d$language=="Non-English")



set.seed(1234)
selected_files <- d %>%
  filter(Answer %in% c("Canonical", "Non-canonical")) %>%
  group_by(unique_id) %>%
  sample_n(10)


try(dir.create("./selected_audio_files"))
try(dir.create("C:/Users/brads/Dropbox/PSYC7310Open/experiments/Babble_Exp/selected_audio_files"))
# file.copy(from = paste0("./clips_corpus/", selected_files$clip_ID),
#           to = "./selected_audio_files",
#           overwrite = TRUE)
file.copy(from = paste0("./clips_corpus/", selected_files$clip_ID),
          to = "./experiments/Babble_Exp/selected_audio_files",
          overwrite = TRUE)

try(setwd("./experiments/Babble_Exp/selected_audio_files"))
try(setwd("C:/Users/brads/Dropbox/PSYC7310Open/experiments/Babble_Exp/selected_audio_files"))
files_list<-list.files()
for(i in 1:length(selected_files$clip_ID)){
  file.rename(files_list[i],paste0(selected_files$unique_id[i],selected_files$clip_ID[i]))
}
try(setwd("/home/smithb/Dropbox/PSYC7310Open"))
try(setwd("C:/Users/brads/Dropbox/PSYC7310Open"))

=======
d <- d %>% mutate(age_groups = ifelse(age_mo_round <= 7, 
                                      "0-7", 
                                      ifelse(age_mo_round <= 18, 
                                             "8-18", 
                                             "19-36")))


set.seed(1234)
selected_files <- d %>%
    filter(Answer %in% c("Canonical", "Non-canonical")) %>%
    group_by(unique_id) %>%
    sample_n(10)


dir.create("./selected_audio_files")
file.copy(from = paste0("./clips/clips_corpus/", selected_files$clip_ID), 
          to = "./selected_audio_files", 
          overwrite = TRUE)
>>>>>>> 016d1a57d4d6b314891ab7a28cd2b4e34f32f4b3
