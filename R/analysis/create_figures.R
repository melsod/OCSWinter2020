#install.packages("ggplot2")
library(ggplot2)



# make it so we can use markdown commands (specifically italics **) in captions/titles
#install.packages("devtools")
library(devtools)
#install_github("wilkelab/ggtext")
library(ggtext)

#function for text wrapping using HTML because ggtext uses HTML
wrapper <- function(x, ...) 
{
  paste(strwrap(x, ...), collapse = "<br>")
}

# Read in the summarized data (with exclusions)
d <- read.csv("data/w_exclusions_summarized_data.csv")

# plot histogram for sex question t-test
hist_sex<-ggplot(d, aes(p_cor_sex)) + 
  geom_histogram(bins = 10) + # 10 bins because there were 10 different levels of responses
  geom_vline(xintercept = 0.5, linetype="solid",  color = "darkgrey", size=1.5) + # grey line for chance levels of responses
  geom_vline(xintercept = mean(d$p_cor_sex), linetype="solid",  color = "red", size=1.5) + # red line for average level of responses
  xlab("Proportion Correct for Sex Judgement") + # x-axis label
  ylab("Count") + # y-axis label
  labs(title = "Histogram for Sex Judgements", # graph title
       # below is the caption with a wrapper to make a new line every 100 characters, mean and sd inserted
       caption = wrapper(paste0("*Figure 1*. X-axis represents the propotion of correct responses across the 10 experimental trials. Y-axis represents the number of participants with that propotion of correct responses. Mean proportion correct was ",
                                round(mean(d$p_cor_sex),2),
                                " (*SD* = ",
                                round(sd(d$p_cor_sex), 2),
                                ")."), 
                         80))+
  theme_bw()+ # use black and white theme
  theme(plot.caption = ggtext::element_markdown(hjust = 0, size = 12, family = "Times New Roman"), axis.title = element_text(size = 14), panel.grid.major = element_blank(),panel.grid.minor = element_blank())

# save histogram to file
png("paper/figures/hist_sex.png") # make file
print(hist_sex) # put histogram into the file
dev.off() #turn off a dev tool so that the save completes

# plot histogram for language question t-test (see above for line by line explanations)
hist_language<-ggplot(d, aes(p_cor_lang)) + geom_histogram(bins = 10) +
  geom_vline(xintercept = 0.5, linetype="solid",  color = "darkgrey", size=1.5) +
  geom_vline(xintercept = mean(d$p_cor_lang), linetype="solid",  color = "red", size=1.5) +
  xlab("Proportion Correct for Language Judgement") + ylab("Count") +
  labs(title = "Histogram for Language Judgements", 
       caption = wrapper(paste0("*Figure 2*. X-axis represents the propotion of correct responses across the 12 experimental trials. Y-axis represents the number of participants with that propotion of correct responses. Mean proportion correct was ",
                                round(mean(d$p_cor_lang),2),
                                " (*SD* = ",
                                round(sd(d$p_cor_lang), 2),
                                ")."),
                         80))+
  theme_bw()+
  theme(plot.caption = ggtext::element_markdown(hjust = 0, size = 12), axis.title = element_text(size = 14), panel.grid.major = element_blank(),panel.grid.minor = element_blank())


# save histogram to file
png("paper/figures/hist_language.png")
print(hist_language)
dev.off()

# plot histogram for age question t-test (see above for line by line explanations)
hist_age<-ggplot(d, aes(p_cor_age)) + geom_histogram(bins = 10) +
  geom_vline(xintercept = (1/3), linetype="solid",  color = "darkgrey", size=1.5) +
  geom_vline(xintercept = mean(d$p_cor_age), linetype="solid",  color = "red", size=1.5) +
  xlab("Proportion Correct for Age Judgement") + ylab("Count") +
  labs(title = "Histogram for Age Judgements", 
       caption = wrapper(paste0("*Figure 3*. X-axis represents the propotion of correct responses across the 12 experimental trials. Y-axis represents the number of participants with that propotion of correct responses. Mean proportion correct was ",
                                round(mean(d$p_cor_age),2),
                                " (*SD* = ",
                                round(sd(d$p_cor_age), 2),
                                ")."), 
                         80))+
  theme_bw()+
  theme(plot.caption = ggtext::element_markdown(hjust = 0, size = 12), axis.title = element_text(size = 14), panel.grid.major = element_blank(),panel.grid.minor = element_blank())

# save histogram to file
png("paper/figures/hist_age.png")
print(hist_age)
dev.off()