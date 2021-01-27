#################################################################################################
##############################       RAIN CLOUD PLOT TEMPLATE     ###############################
#################################################################################################

### CHANGE file directory - GO TO: SESSION > SET WORKING DIRECTORY > CHOOSE DIRECTORY
setwd("~/Desktop/")

### REQUIRED LIBRARIES
library(ggplot2)
library(gghalves)

### NAME OF .CSV DATA FILE:
df.name <- "Data.csv"

##### ----------  DATA PREPARATION
#################################################################################################

### IMPORT DATA
DATA.VIZ <- read.csv(df.name)

### IF THE CATEGORICAL VARIABLE IS REPRESENTED NUMERICALLY,
### THEN THIS VARIABLE NEEDS TO BE MANUALLY CHANGED TO A FACTOR:

# ----- CHANGES: i) Name of the categorical variable after `DATA.VIZ$`
# -------------- ii) Level values (allows for the reordering of categories)

DATA.VIZ$variable.name <- factor(DATA.VIZ$variable.name, levels = c(1,2,3))

##### ----------  VISUALIZATION
#################################################################################################

### RENAME VARIABLES TO BE VISUALIZED (FIRST LINE BELOW)

# ----- CHANGES: i) cat.var == categorical variable
# -------------- ii) cont.var == continuous variable

(viz.plot <- ggplot(DATA.VIZ, aes(x = cat.var, y = cont.var, fill = cat.var, colour = cat.var)) +
  geom_half_violin(position = position_nudge(x = 0.2,y = 0),
                   side = "r", alpha = 0.8, show.legend = F)+
  geom_point(position = position_jitter(width = 0.1),
             size = 0.2, alpha = 0.8, show.legend = F) +
  geom_boxplot(position = position_nudge(x=0.15,y = 0),width = 0.05,
               outlier.shape = NA, alpha = 0.3, colour = "black", show.legend = F) +
  theme_classic() +
  theme(axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        title = element_text(face = "bold", size = 15)) +
  coord_flip())

##### ----------  THE PLOT ABOVE IS THE FOUNDATION OF THE CLOUD PLOT
#################################################################################################
### BELOW, ARE SOME CHANGES AND MODIFICATIONS THAT CAN BE MADE TO THIS FOUNDATION

(viz.plot <- viz.plot + 

# ----- CHANGE THE TITLES OF THE X AND Y AXES (`xlab` & `ylab`, respectively)
xlab("categorical variable name") + ylab("continuous variable name") +

# ----- CHANGE THE TITLE OF THE PLOT
labs(title = "Title of Rain Cloud Plot"))

### GREYSCALE REQUIRED FOR PUBLICATIONS?
(viz.plot <- viz.plot +
# ----- CHANGE: `start` and `end` values (min = 0, max = 1) to change the greyscale
scale_color_grey(start = 0.2, end = 0.7) + scale_fill_grey(start = 0.2, end = 0.7))


##### ----------  OTHER CLOUD PLOT CHANGES TO MAKE
#################################################################################################
### GLOBAL CHANGES TO THE FOUNDATION PLOT CAN TWEAK THE VISUALIZATION:

### `alpha = ` Used to set the opacity of the specific visualization (range of 0 to 1)

### `size = ` Use to change the size of the geom_points, or the size of text

### `show.legend = ` Logical statement to show/suppress the legend of each geom

