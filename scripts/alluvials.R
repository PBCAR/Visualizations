#################################################################################################
###########################     ALLUVIALS (SANKEY PLOTS) TEMPLATE    ############################
#################################################################################################

### Required packages

library(ggplot2); library(ggalluvial); library(dplyr)

##### ----------  DATA PREPARATION
#################################################################################################

### a) CHANGE file directory - GO TO: SESSION > SET WORKING DIRECTORY > CHOOSE DIRECTORY

setwd("~/Desktop/PBCAR")   ### OR CHANGE FILE DIRECTORY HERE

### b) SELECT NAME of file to read

data.viz <- read.csv("Data_File.csv") ### READS in a .csv file

### c) CHANGE to long format if required:

dviz <- reshape(as.data.frame(data.viz), idvar = "id", timevar = "time",
                varying = c("total_drinks1","total_drinks2","drink_days1","drink_days2",
                            "cann_assist1","cann_assist2"),
                direction = "long", sep = "")

dviz$time <- factor(dviz$time, levels = c(1,2), labels = c("Baseline","Follow-Up"))

##### ----------  DATA PREPARATION
#################################################################################################

### REMOVE missing observations (if desired) so that they do not appear in the visualization

dviz <- dviz[!is.na(dviz$cann_assist),]

### RE-ORDER the categorical variable

dviz$cann_assist <- factor(dviz$cann_assist,
                           levels = c(3,2,1,0), # from left to right, alluvial categories will appear from top to bottom
                           labels = c("Daily","Weekly","Monthly","None")) # change names of levels

### ADD count data (n) to data frame by id variable and time

dviz <- dviz %>% group_by(id, time) %>% add_count(cann_assist)

### IF wanting alluvials to represent percent, mutate counts to percentages

dviz <- dviz %>% group_by(time) %>% mutate(percent = (n/sum(n))*100)

##### ----------  VISUALIZATION
#################################################################################################

### x = time
### y = percent (or if wanting counts, use y = n)
### stratum = categorical variable
### alluvium = the id variable
### fill & label = categorical variable

(viz.plot <- ggplot(dviz, aes(x = time, y = percent, stratum = cann_assist, alluvium = id,
                              fill = cann_assist, label = cann_assist)) +
     scale_x_discrete(expand = c(.1, .1)) +
     geom_stratum(alpha = 1, show.legend = T) + # columns/ bars
     geom_flow(alpha = 0.5, show.legend = F) + # the flow between columns
     # text in each bar section used to show percent. omit aes portion of code to have category name instead
     geom_text(stat = "stratum", aes(label = scales::percent(after_stat(prop), accuracy = 1)), size = 6))

### MAKE changes to overall aesthetic

(viz.plot <- viz.plot + theme_classic() +
        ggtitle("Alluvial Plot") + # add a title to the alluvial plot
        xlab("") + # change x-axis title
        ylab("%") + # change y-axis title
        scale_colour_manual("Cannabis Use Frequency", values = c("red4","orange3","gold2","royalblue3")) + # custom colour (in order of factor)
        scale_fill_manual("Cannabis Use Frequency", values = c("red4","orange3","gold2","royalblue3")) + # custom fill (in order of factor)
        theme(axis.title = element_text(face = "bold", size = 20), # customize axis titles
              axis.text.x = element_text(face = "bold", size = 15), # customize x-axis text
              axis.text.y = element_text(face = "bold", size = 15), # customize y-axis text
              legend.position = "bottom", # change legend location
              legend.title = element_text(size = 15), # customize legend title
              legend.text = element_text(size = 10), # customize legend text
              plot.title = element_text(face = "bold", size = 30, hjust = 0.5))) # customize plot title
