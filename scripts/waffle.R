#################################################################################################
##############################         WAFFLE PLOT TEMPLATE       ###############################
#################################################################################################

##### ----- Required packages

## !! NOTE, ggwaffle is not on CRAN and as such, needs to be downloaded from GitHub using the {devtools} package:

# devtools::install_github("liamgilbey/ggwaffle")

library(ggplot2); library(ggwaffle)

##### ----------  DATA PREPARATION
#################################################################################################

### a) IMPORT DATA (example data provided):

data.viz <- read.csv("https://raw.githubusercontent.com/PBCAR/Visualizations/main/data/PBCAR_Mock_Data.csv")

### b) ALL DATA PREP will be done using the waffle_iron() function from the ggwaffle package

##### ----------  VISUALIZATION:
#################################################################################################

### EX. Basic Waffle Plot: Each square represents N individuals

### If wanting 1 square to = 1 participant, make sample_size = 1
### if sample_size = 0.5, sample size will be halved so 1 square = 2 participants
### when sample_size = 0.1, 1 square = 10 participants

waffle.data <- waffle_iron(data.viz, aes_d(group = cann_assist1), rows = 15, sample_size = 1)

### Make the grouping variable a factor as the waffle_iron function reverts factors back to numeric

waffle.data$group <- factor(waffle.data$group, levels = c(0:3),labels = c("None","Monthly","Weekly","Daily"))

(viz.plot <- ggplot(waffle.data, aes(x, y, fill = group)) + 
    coord_equal() + # makes each waffle a square 
    ggtitle("Waffle Plot Example") + # add a title to the waffle plot
    geom_waffle() +
    theme_waffle()) # waffle plot theme from package
 
(viz.plot <- viz.plot + 
    scale_colour_manual("Cannabis Use Frequency", values = c("royalblue3","gold2","orange3","red4")) + # custom colour (in order of factor)
    scale_fill_manual("Cannabis Use Frequency", values = c("royalblue3","gold2","orange3","red4")) + # custom fill (in order of factor)
  theme(plot.title = element_text(face = "bold", size = 30, hjust = 0.5), # customize plot title
        legend.title = element_text(face = "bold", size = 13, vjust = 0.75), # customize legend title
        legend.text = element_text(size = 10), # cutomize legend text
        legend.position = "bottom", # customize legend position
        axis.title.x = element_blank(),axis.title.y = element_blank())) # remove x and y axis titles (not meaningful)
