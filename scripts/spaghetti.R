#################################################################################################
##############################       SPAGHETTI PLOT TEMPLATE     ################################
#################################################################################################

##### ----- Required packages

library(ggplot2); library(dplyr)

##### ----- Examples are provided, with various types of spaghetti plots created:

## 1: Plot with individual spaghetti plots created by a grouping variable
## 2: Plot with individual spaghetti plots created alongside the overall trend for each group

##### ----------  DATA PREPARATION
#################################################################################################

### a) IMPORT DATA (example data provided):

data.viz <- read.csv("https://raw.githubusercontent.com/PBCAR/Visualizations/main/data/PBCAR_Mock_Data.csv")

### First, let's split individuals into two groups by their drinking level at baseline (total_drinks1)

data.viz$drinks_baseline <- ifelse(data.viz$total_drinks1<10,"Low Total Drinks (<10)","High Total Drinks (10+)")

### b) CHANGE to long format if required:

dviz <- reshape(as.data.frame(data.viz), idvar = "id", timevar = "time",
                varying = c(paste0("total_drinks",1:5)),
                direction = "long", sep = "")

### c) CHANGE GROUPING variable to a factor:

dviz$drinks_baseline <- factor(dviz$drinks_baseline, levels = c("Low Total Drinks (<10)","High Total Drinks (10+)"))

### e) FOR PLOT 2, CALCULATE MEAN AVERAGES

dmean <- dviz %>% group_by(time,drinks_baseline) %>% summarize(mean_drinks = mean(total_drinks, na.rm = T))

##### ----------  VISUALIZATION 1:
#################################################################################################

### EX. 1 Each individual has their own trend line over time

### x = the time variable (time)
### y = the variable to plot over time (total_drinks)
### colour = the grouping variable (drinks_baseline)

(viz.plot <- ggplot(dviz, aes(x = time, y = total_drinks, group = id, colour = drinks_baseline)) +
  geom_line(show.legend = F) + facet_wrap(~drinks_baseline))

### MAKE changes to overall aesthetic

(viz.plot <- viz.plot + theme_classic() +
    ggtitle("Spaghetti Plot Example 1") + # add a title to the spaghetti plot
    xlab("Time") + # change x-axis title
    ylab("Total Drinks per Week") + # change y-axis title
    scale_colour_manual(values = c("#2c39b8","#b8652c")) + # custom colour
    theme(axis.title = element_text(face = "bold", size = 20), # customize axis titles
          axis.text = element_text(face = "bold", size = 15), # customize axis text
          strip.text = element_text(size = 15, face = "bold"), # change facet titles
          plot.title = element_text(face = "bold", size = 30, hjust = 0.5)))

##### ----------  VISUALIZATION 2:
#################################################################################################

### EX. 2 Add an overall trend line to the spaghetti plot by grouping variable

### Same variables as EX. 1
### PLUS add a second geom_line() with the overall mean trend by group whereby:
### y = the mean of the variable to plot over time (mean_drinks)
### group = the grouping variable changes from id to the grouping variable (drinks_baseline)

(viz.plot <- ggplot(dviz, aes(x = time, y = total_drinks, group = id, colour = drinks_baseline)) +
   geom_line(alpha = 0.25,show.legend = F) + # change opacity of individual lines using alpha
   geom_line(dmean, mapping = aes(y = mean_drinks, group = drinks_baseline), linewidth = 2, show.legend = F) + # mean data plotted ontop of the individual trajectories
   facet_wrap(~drinks_baseline))

(viz.plot <- viz.plot + theme_classic() +
    ggtitle("Spaghetti Plot Example 2") + # add a title to the spaghetti plot
    xlab("Time") + # change x-axis title
    ylab("Mean Average Drinks per Week \n and Drinks per Week by Individual") + # change y-axis title
    scale_colour_manual(values = c("#2c39b8","#b8652c")) + # custom colour
    theme(axis.title = element_text(face = "bold", size = 20), # customize axis titles
          axis.text = element_text(face = "bold", size = 15), # customize axis text
          strip.text = element_text(size = 15, face = "bold"), # change facet titles
          plot.title = element_text(face = "bold", size = 30, hjust = 0.5)))
