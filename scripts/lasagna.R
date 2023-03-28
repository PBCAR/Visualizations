#################################################################################################
##############################         LASAGNA PLOT TEMPLATE      ###############################
#################################################################################################

##### ----- Required packages

library(ggplot2); library(dplyr)

##### ----- Examples are provided, with various types of lasagna plots created:

## 1: Plot with data aggregated at the individual level
## 2: Plot with data aggregated at the grouping level

### For the purpose of giving an example, the `total_drinks` variable is visualized, however
### lasagna plots work well to show the homogeneity within individuals or groups across variables
### on the same scale (ex. Likert scales).

##### ----------  DATA PREPARATION
#################################################################################################

### a) IMPORT DATA (example data provided):

data.viz <- read.csv("https://raw.githubusercontent.com/PBCAR/Visualizations/main/data/PBCAR_Mock_Data.csv")

### b) CHANGE to long format if required:

dviz <- reshape(as.data.frame(data.viz), idvar = "id", timevar = "var",
                varying = c("perception1","perception2","perception3"),
                direction = "long", sep = "")

### c) CHANGE ID (EX. 1) / GROUPING (EX. 2) variables to a factor:

dviz$id <- factor(dviz$id)
dviz$cann_assist1 <- factor(dviz$cann_assist1, levels = c(0:3), labels = c("None","Monthly","Weekly","Daily"))

### d) ORDER x-axis variables from left to right

dviz$var <- factor(dviz$var, levels = c(1,2,3), labels = c("Medicinal Cannabis Use","Recreational Cannabis Use","Alcohol Use"))

### e) FOR lasagna plot by GROUP (EX 2), CALCULATE MEAN AVERAGES

dmean <- dviz %>% group_by(var,cann_assist1) %>% summarize(mean = mean(perception, na.rm = T))

##### ----------  VISUALIZATION 1:
#################################################################################################

### EX. Each individual represents one layer of lasagna

### x = the perception variables (var)
### y = the grouping variable (cann_assist1)
### fill and colour = continuous measure (perception for each individual)

(viz.plot <- ggplot(dviz, aes(x = var, y = id)) +
  geom_tile(aes(fill = perception, colour = perception))) 

### MAKE changes to overall aesthetic

(viz.plot <- viz.plot + theme_classic() +
    ggtitle("Lasagna Plot Example 1") + # add a title to the lasagna plot
    xlab("") + # change x-axis title
    ylab("") + # change y-axis title
    scale_colour_continuous("Regular Use Acceptability", type = "viridis") + # custom colour (viridis provides high contrast)
    scale_fill_continuous("Regular Use Acceptability", type = "viridis") + # custom fill (viridis provides high contrast)
    theme(axis.text.x = element_text(face = "bold", size = 17), # customize x-axis text
          axis.line = element_blank(), # remove axis lines
          axis.text.y = element_blank(), # remove id variable labels
          axis.ticks = element_blank(), # remove axis ticks
          plot.title = element_text(face = "bold", size = 30, hjust = 0.5), # customize plot title
          legend.title = element_text(face = "bold", size = 13, vjust = 0.75), # customize legend title
          legend.text = element_text(size = 10), # cutomize legend text
          legend.position = "bottom", legend.key.width = unit(5,"cm"))) # customize legend

##### ----------  VISUALIZATION 2:
#################################################################################################

### EX. Each group represents one layer of lasagna

### x = the perception variables (var)
### y = the grouping variable (cann_assist1)
### fill and colour = continuous measure (mean average across each group)

(viz.plot <- ggplot(dmean, aes(x = var, y = cann_assist1)) +
    geom_tile(aes(fill = mean, colour = mean)))

### MAKE changes to overall aesthetic

(viz.plot <- viz.plot + theme_classic() +
    ggtitle("Lasagna Plot Example 2") + # add a title to the lasagna plot
    xlab("") + # change x-axis title
    ylab("Cannabis Use Frequency") + # change y-axis title
    scale_colour_continuous("Regular Use Acceptability", type = "viridis") + # custom colour (viridis provides high contrast)
    scale_fill_continuous("Regular Use Acceptability", type = "viridis") + # custom fill (viridis provides high contrast)
    theme(axis.text = element_text(face = "bold", size = 17), # customize axis text
          axis.title = element_text(face = "bold", size = 20), # customize axis titles
          plot.title = element_text(face = "bold", size = 30, hjust = 0.5),  # customize plot title
          legend.title = element_text(face = "bold", size = 13, vjust = 0.75), # customize legend title
          legend.text = element_text(size = 10), # cutomize legend text
          legend.position = "bottom", legend.key.width = unit(5,"cm"))) # customize legend
