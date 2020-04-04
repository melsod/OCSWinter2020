# Open Collaborative Science PSYC 4540 T39/7310 T34 Winter 2020

This is the repository for PSYC 4540 T39/7310 T34, a course on Open and Collaborative Science in the Psychology Department at the University of Manitoba, Winter 2020 (Instructor: Dr. Melanie Soderstrom). During the course, there was a class-wide group research project where Open and Collaborative Science tools and principles were applied.The objective was a fully open and pre-registered project that will be submitted for (possible peer review and) publication.

## The Project

### What can we perceive in infant babble?

The purpose of this study is to determine whether or not English-speaking monolingual adults can identify the age, sex, or first language of a baby after listening to recorded snippets of baby babble. The study will also determine if the adults’ gender or caregiving experience affect their abilities to discriminate between the babble.

This research is valuable in that it lends to the study of human language development. There have been mixed results so far on whether humans can identify differences in baby babble based on a baby’s first language and age. Furthermore, there appears to be no literature on adult participants identifying differences in babble based on the sex of the baby, although there is evidence that sex hormones are linked to language development in babies as young as 5-months (Quast et al., 2016). Our research will contribute to these growing bodies of literature.

### Our procedure

In this experiment, adult participants will hear a series of short audio clips of babble, one at a time or in batches of 10. Participants will be asked a question about each clip. Their task will be to answer the questions based on their best judgement. All answers will be collected by a computer. At the end of the study, some information will be asked about the participant and their experience with infants.

# Getting Started

A step by step guide in reproducing the experiment, and the results (based on our sample) can be found in the section [Step-by-Step Guide](#step-by-step-guide).

## Overall Summary

This repository will be used to store all of the code and data for this project. Other material regarding the project can be found at our open science page: https://osf.io/2a6b4/

The actual experiment can be viewed/tested at https://melsod.github.io/OCSWinter2020/

The experiment is run using [jsPsych](https://www.jspsych.org/) (a JavaScript library for running behavioural experiments in a web browser) and is hosted on GitHub Pages. Data was collected by Google Firebase before being consolidated and saved into our [data folder](data). Our data analysis can be reproduced using the code found in our [analysis folder](R/analysis) (detailed steps below).

Our selection of Babble Clips used in the experiment is found in the [Selected Audio Files Folder](audio/selected_audio_files). The clips found in the two folders were selected by an [R Script](R/pre_experiment/sample_clips.R). Three of the contributors then manually screened the clips for usability (e.g., non-infant noises). A copy of the excluded files are found [here](audio/Exclusion_files). Following the screening process, another [R Script](R/pre_experiment/narrow_sample.R) generated the list of files that were presented in the experiment (a copy of these files are found [here](audio/selected_audio_files/clips_to_use)).


## Step-by-Step Guide

### First Steps

The easiest way to reproduce these results is to fork this repository into your own account and then clone it (so that it is saved locally on your machine). If you understand these instructions then you can skip to the section [Reproducibility](#reproducibility), otherwise we'll explain how to do that:

#### Sign-Up For a GitHub Account

If you alread have a GitHub Account then skip to [Fork the Repository](#fork-the-repository), otherwise:

- Go to www.github.com
- Click the "Sign Up" button in the top right hand side of the site (or click [here](https://github.com/join?source=header-home))
- Create a Username and provide the requested information
- Click "Select a Plan"
- Click "Choose Free" unless you have a reason to get the paid service
- Provide whatever level of information you want to GitHub and then scroll down and click "Complete setup"
- Verify your email address
- There is no need to "Create a new repository" if you do not want to

#### Fork the Repository

- Go to https://github.com/melsod/OCSWinter2020 (but you're already here)
- Click on the "Fork" button near the top, right hand side of the page
- Wait for the repository to complete it's fork
- You now own you're very own copy of this repository!

#### Download GitHub Desktop

If you already have the GitHub Desktop Client then skip to [Clone the Repository](clone-the-repository)

- Go to https://desktop.github.com/ and download the application
- Install the application
- Sign in with your GitHub account
- (Optional) you can learn about Git and GitHub with [this tutorial](https://help.github.com/en/desktop/getting-started-with-github-desktop/creating-your-first-repository-using-github-desktop)

- You can also avoid using the GitHub Desktop client by using the Git command line functions by downloading the program here https://git-scm.com/downloads, we will leave it up to you and Google to work through how to do it that way

#### Clone the Repository

- Make a folder on your computer where you would like to save the repository
- In the GitHub Desktop program, click on the File menu (in the top, left hand corner)
- Click on Clone Repository
- Select the "GitHub.com" tab if it is not aleady selected
- Your repositories should be visible assuming that you successfully signed into GitHub on the Desktop Client
- Select the GitHubUsername/OCSWinter2020 option
- Choose the local path where you want to save the repository (just below the repository options)
- Click the "Clone" button
- This saves a local copy of the repository on your device

### Reproducibility

Now that you have a local copy of the experiment on your machine you can begin to make and save your own edits. These edits can be saved, committed to your git repository (version control: essentially it keeps a record of all the changes you make and allows you to revert to a previous itteration of the experiment if you want), and then pushed to your GitHub repository. Once changes are on your GitHub repository others can see your work and contribute to it and you can host the experiment there (using GitHub Pages). 

We'll leave it to you to learn how to push changes to your GitHub repository and work collaboratively with others from there (it's much the same way you are "working" on our experiment) but we will show you how to how the experiment in the section [Running the Experiment](#running-the-experiment).

#### Download R and rStudio

If you already have R and rStudio then skip to [Reproduce the Experiment](#reproduce-the-experiment)

#### Reproduce the Experiment

In your local repository (the folder that you downloaded/clones the repo to)

#### Reproduce the Results

### Running the Experiment

# Contributors

Alanna Beyak, Olivia Cadieux, Matthew Cook, Carly Cressman, Barbie Jain, Jarod Joshi, Spenser Martin, Michael Mielniczek, Sara Montazeri, Essence Perera, Jolyn Sawatzky, Bradley Smith, Jackie Spear, Thomas Thompson, Derek Trudel, Jianjie Zeng, Melanie Soderstrom

# Acknowledgements 

Thank you to Cychosz et al. for providing the BabbleCor dataset. 

# Other

BabbleCor: https://osf.io/rz4tx/
