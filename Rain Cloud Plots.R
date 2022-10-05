#################################################################################################
##############################       RAIN CLOUD PLOT TEMPLATE     ###############################
#################################################################################################

### Required packages

library(ggplot2); library(gghalves)

### Example are provided using the mock data, with various types of rain cloud plots created:

# 1: Plot with 1 categorical & 1 continuous variable
# 2A: Plot with 1 categorical variable (faceted), 1 time variable, & 1 continuous variable
# 2B: Plot with 1 categorical variable (faceted), 1 time variable (colour only), & 1 continuous variable

### NOTE: the coord_flip() function of ggplot2 is used to accommodate the use of the half-violins,
### meaning that the x variable maps onto the y-axis, and the y variable maps onto the x-axis

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

### d) If the categorical variable(s) is/are represented numerically, then manually change to a factor:

data.viz$gender <- factor(data.viz$gender, levels = c(1,2,0), labels = c("Female","Non-Binary","Male"))

### For the long data format, both gender and time need to be changed to factors

dviz$time <- factor(dviz$time, levels = c(1,2), labels = c("Baseline","Follow-Up"))
dviz$gender <- factor(dviz$gender, levels = c(1,2,0), labels = c("Female","Non-Binary","Male"))

##### ----------  VISUALIZATION 1:
#################################################################################################

### EX. 1 Categorical Variable & 1 Continuous Variable:

### x = the categorical variable
### y = the continuous variable measured
### fill and colour = the x categorical variable

(viz.plot <- ggplot(data.viz, aes(x = gender, y = total_drinks1, fill = gender, colour = gender)) +
  geom_half_violin(position = position_nudge(x = 0.2, y = 0), side = "r", show.legend = F) +
  geom_point(position = position_jitter(width = 0.1), size = 1, show.legend = F) +
  geom_boxplot(position = position_nudge(x = 0.15,y = 0),width = 0.05,
               outlier.shape = NA, alpha = 0.3, colour = "black", show.legend = F) +
  coord_flip())

### MAKE changes to overall aesthetic

(viz.plot <- viz.plot + theme_classic() +
    ggtitle("Rain Cloud Plot Example 1") + # add a title to the rain cloud plot
    xlab("") + # change x-axis title
    ylab("Total Drinks per Week") + # change y-axis title
    scale_colour_manual("Gender", values = c("#2c39b8","#2c7fb8","#2cb8ab")) + # custom colour (in order of factor)
    scale_fill_manual("Gender", values = c("#2c39b8","#2c7fb8","#2cb8ab")) + # custom fill (in order of factor)
  theme(axis.title = element_text(face = "bold", size = 20), # customize axis titles
        axis.text = element_text(face = "bold", size = 15), # customize axis text
        plot.title = element_text(face = "bold", size = 30, hjust = 0.5))) # customize plot title

##### ----------  VISUALIZATION 2A:
#################################################################################################

### EX. 2 Categorical Variables (1 faceted) & 1 Continuous Variable:

### x = categorical variable 1
### y = the continuous variable measured
### fill and colour = categorical variable 1
### faceted = categorical variable 2

(viz.plot <- ggplot(dviz, aes(x = time, y = total_drinks, fill = time, colour = time)) + 
   geom_half_violin(position = position_nudge(x = 0.2, y = 0), side = "r", alpha = 0.7) +
   geom_point(position = position_jitter(width = 0.1), size = 1, show.legend = F) +
   geom_boxplot(position = position_nudge(x = 0.15, y = 0),width = 0.05,
                outlier.shape = NA, alpha = 0.3, colour = "black", show.legend = F) +
   facet_wrap(~gender, nrow = 3) +
   coord_flip())

### MAKE changes to overall aesthetic

(viz.plot <- viz.plot + theme_classic() +
    ggtitle("Rain Cloud Plot Example 2A") + # add a title to the rain cloud plot
    xlab("") + # change x-axis title
    ylab("Total Drinks per Week at Baseline & Follow-Up") + # change y-axis title
    scale_colour_manual("Time", values = c("#b8652c","#2c7fb8")) + # custom colour (in order of factor)
    scale_fill_manual("Time", values = c("#b8652c","#2c7fb8")) + # custom fill (in order of factor)
    theme(axis.title = element_text(face = "bold", size = 20), # customize axis titles
          axis.text = element_text(face = "bold", size = 15), # customize axis text
          plot.title = element_text(face = "bold", size = 30, hjust = 0.5),
          strip.text = element_text(size = 15, face = "bold"), # change facet titles
          legend.position = "bottom")) # change legend location

##### ----------  VISUALIZATION 2B:
#################################################################################################

### EX. 2 Categorical Variables (1 faceted) & 1 Continuous Variable:

### x = space holder to put variables on same axis line
### y = the continuous variable measured
### fill and colour = categorical variable 2 (occupy same space on x axis)

(viz.plot <- ggplot(dviz, aes(x = "overall", y = total_drinks, fill = time, colour = time)) + 
   # smaller x in position_nudge to better centre the plot
   geom_half_violin(position = position_nudge(x = 0.1, y = 0), side = "r", alpha = 0.7) +
   # aes(x = 0.9) to better centre the plot
   geom_point(mapping = aes(x = 0.8), position = position_jitter(width = 0.1), size = 1, show.legend = F) +
   # different from the geom_boxplots in other rain cloud plots, is the addition of:
   # aes(x = 1) to keep position underneath violins; and position_dodge() to avoid boxplot overlap
   geom_boxplot(mapping = aes(x = 1), position = position_dodge(width = 0.1), width = 0.05,
                outlier.shape = NA, alpha = 0.3, colour = "black", show.legend = F) +
   facet_wrap(~gender, nrow = 3) +
   coord_flip())

### MAKE changes to overall aesthetic

(viz.plot <- viz.plot + theme_classic() +
    ggtitle("Rain Cloud Plot Example 2B") + # add a title to the rain cloud plot
    xlab("") + # change x-axis title
    ylab("Total Drinks per Week at Baseline & Follow-Up") + # change y-axis title
    scale_colour_manual("Time", values = c("#b8652c","#2c7fb8")) + # custom colour (in order of factor)
    scale_fill_manual("Time", values = c("#b8652c","#2c7fb8")) + # custom fill (in order of factor)
    theme(axis.title = element_text(face = "bold", size = 20), # customize axis titles
          axis.text.x = element_text(face = "bold", size = 15), # customize x-axis text
          axis.text.y = element_blank(), # remove "overall" label from axis text
          axis.ticks.y = element_blank(), # remove "overall" label ticks
          plot.title = element_text(face = "bold", size = 30, hjust = 0.5),
          strip.text = element_text(size = 15, face = "bold"), # change facet titles
          legend.position = "bottom")) # change legend location
