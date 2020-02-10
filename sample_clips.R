# install.packages("tidyverse")
library(tidyverse)

#set working directory to where private metadata and unzipped clips direcotry live
setwd("C:/Users/Matt/Downloads/")
d <- read.csv("private_metadata.csv")

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


set.seed(1234)
selected_files <- d %>%
    filter(Answer %in% c("Canonical", "Non-canonical")) %>%
    group_by(unique_id) %>%
    sample_n(10)


dir.create("./selected_audio_files")
file.copy(from = paste0("./clips/clips_corpus/", selected_files$clip_ID), 
          to = "./selected_audio_files", 
          overwrite = TRUE)
