<!--
need to fix and comment:
  -firedata_test.R
  -data_cleaning.R
  
need to write:
  -analysis file
-->

# Open Collaborative Science PSYC 4540 T39/7310 T34 Winter 2020

This is the repository for PSYC 4540 T39/7310 T34, a course on Open and Collaborative Science in the Psychology Department at the University of Manitoba, Winter 2020 (Instructor: Dr. Melanie Soderstrom). During the course, there was a class-wide group research project where Open and Collaborative Science tools and principles were applied.The objective was a fully open and pre-registered project that will be submitted for (possible peer review and) publication.

## The Project

### What can we perceive in infant babble?

The purpose of this study is to determine whether or not English-speaking monolingual adults can identify the age, sex, or first language of a baby after listening to recorded snippets of baby babble. The study will also determine if the adults’ gender or caregiving experience affect their abilities to discriminate between the babble.

This research is valuable in that it lends to the study of human language development. There have been mixed results so far on whether humans can identify differences in baby babble based on a baby’s first language and age. Furthermore, there appears to be no literature on adult participants identifying differences in babble based on the sex of the baby, although there is evidence that sex hormones are linked to language development in babies as young as 5-months (Quast et al., 2016). Our research will contribute to these growing bodies of literature.

### Our procedure

In this experiment, adult participants will hear a series of short audio clips of babble, one at a time or in batches of 10. Participants will be asked a question about each clip. Their task will be to answer the questions based on their best judgement. All answers will be collected by a computer. At the end of the study, some information will be asked about the participant and their experience with infants.

# Getting Started

This repository will be used to store all of the code and data for this project. Other material regarding the project can be found at our open science page: https://osf.io/2a6b4/

The experiment can be viewed at https://melsod.github.io/OCSWinter2020/

The experiment is run using [jsPsych](https://www.jspsych.org/) (a JavaScript library for running behavioural experiments in a web browser) and is hosted on GitHub Pages. Data was collected by Google Firebase before being consolidated and saved into our [data folder](data). Our data analysis can be reproduced using the code found in our [analysis folder](R/analysis) (more details below).

Our selection of Babble Clips used in the experiment is found in the [Selected Audio Files Folder](audio/selected_audio_files). The clips found in the two folders were selected by an [R Script](R/pre_experiment/sample_clips.R). Three of the contributers then manually screened the clips for usability (e.g., non-infant noises). A copy of the excluded files are found [here](audio/Exclusion_files). Following the screening process, another [R Script](R/pre_experiment/narrow_sample.R) generated the list of files that were presented in the experiment (a copy of these files are found [here](audio/selected_audio_files/clips_to_use)).


# Contributors

Alanna Beyak, Olivia Cadieux, Matthew Cook, Carly Cressman, Barbie Jain, Jarod Joshi, Spenser Martin, Michael Mielniczek, Sara Montazeri, Essence Perera, Jolyn Sawatzky, Bradley Smith, Jackie Spear, Thomas Thompson, Derek Trudel, Jianjie Zeng, Melanie Soderstrom

# Acknowledgements 

Thank you to Cychosz et al. for providing the BabbleCor dataset. 

# Other

BabbleCor: https://osf.io/rz4tx/
