# Matt: basically we need to adapt this code to now subset to not only 10 clips per baby 
# but to balance the number of babies that fit in our experimental cells. Putting just those
# into selected_files

# install.packages("tidyverse")
library(tidyverse)

#set working directory to where private metadata and unzipped clips directory live
try(setwd("/home/smithb/Dropbox/PSYC7310Open"))
try(setwd("C:/Users/brads/Dropbox/PSYC7310Open"))
file<-file.choose()
d <- read.csv(file)

#remove "-" from Casillas-Yeli as it causes problems in javascript/html
library(plyr)
d$corpus<-revalue(d$corpus, c("Casillas-Yeli"="CasillasYeli"))
#setwd("C:/Users/Matt/Downloads/")
d <- read.csv("private_metadata.csv")

#add a column called with a unique id (the original child id pasted together with the corpus)
d <- d %>% mutate(unique_id = paste0(child_ID, corpus))

#get rid of data from the warlaumont corpus
d <- d %>% filter(corpus != c("Warlaumont"))

#make a new column with the language
#d <- d %>% mutate(language = ifelse(corpus == "Seedlings",))
d <- d %>% mutate(language = ifelse(corpus == "Seedlings", "English","Non-English"))

#make a categorical age variable based on 07, 8-18, and 19-36 groupings
d <- d %>% mutate(age_groups = ifelse(age_mo_round <= 7, # what is going on here?
                                      "0-7",
                                      ifelse(age_mo_round <= 18,
                                             "8-18",
                                             "19-36")))

# added just so that I would get a decently small subset to play around with while programming the experiment
#d <- subset(d,d$age_groups=="8-18"&d$language=="Non-English")



set.seed(1234)
selected_files <- d %>%
  filter(Answer %in% c("Canonical", "Non-canonical")) %>%
  group_by(unique_id) %>%
  sample_n(10)


# try's added so that it works on both my linux and windows. This will need to change to be more general
try(dir.create("./selected_audio_files"))
try(dir.create("C:/Users/brads/Dropbox/PSYC7310Open/experiments/Babble_Exp/selected_audio_files"))

# similar issues below, needs to be more general probably

# copy selected audio files to new location
# file.copy(from = paste0("./clips_corpus/", selected_files$clip_ID),
#           to = "./selected_audio_files",
#           overwrite = TRUE)
file.copy(from = paste0("./clips_corpus/", selected_files$clip_ID),
          to = "./experiments/Babble_Exp/selected_audio_files",
          overwrite = TRUE)

# I'm sure we can do this without constantly changing wd but that was my quick solution
try(setwd("./experiments/Babble_Exp/selected_audio_files"))
try(setwd("C:/Users/brads/Dropbox/PSYC7310Open/experiments/Babble_Exp/selected_audio_files"))

# rename the "selected_files" to inclue the corpus name/unique id at the beginning
files_list<-list.files()
for(i in 1:length(selected_files$clip_ID)){
  file.rename(files_list[i],paste0(selected_files$unique_id[i],selected_files$clip_ID[i]))
}

# again, reseting the wd
try(setwd("/home/smithb/Dropbox/PSYC7310Open"))
try(setwd("C:/Users/brads/Dropbox/PSYC7310Open"))


# I have no idea why these are duplicated. I'm guessing it has to do with git just keeping additions and not removing things that were deleted
# ergo I have now commented these out

# d <- d %>% mutate(age_groups = ifelse(age_mo_round <= 7, 
#                                       "0-7", 
#                                       ifelse(age_mo_round <= 18, 
#                                              "8-18", 
#                                              "19-36")))
# 
# 
# set.seed(1234)
# selected_files <- d %>%
#     filter(Answer %in% c("Canonical", "Non-canonical")) %>%
#     group_by(unique_id) %>%
#     sample_n(10)
# 
# 
# dir.create("./selected_audio_files")
# file.copy(from = paste0("./clips/clips_corpus/", selected_files$clip_ID), 
#           to = "./selected_audio_files", 
#           overwrite = TRUE)
