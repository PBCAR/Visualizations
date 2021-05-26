#################################################################################################
###########################     ALLUVIALS (SANKEY PLOTS) TEMPLATE    ############################
#################################################################################################

##### ----------  REQUIRED CHANGES BY USER:
#################################################################################################
### a) CHANGE file directory - GO TO: SESSION > SET WORKING DIRECTORY > CHOOSE DIRECTORY

setwd("~/Desktop/PBCAR")   ### CHANGE FILE DIRECTORY

### b) CHANGE THE NAME OF THE FILE (MUST BE A .csv file)

df.name <- "PBCAR.csv"

### c) CHANGE THE NAME OF THE ID VARIABLE

id.var <- "id"

### d) CHANGE THE NAME OF THE TIME VARIABLE

time.var <- "wave"

### e) SELECT FILL TYPE - EITHER: "numeric" or "percent"

type_count <- "percent"

##### ----------  DATA PREPARATION
#################################################################################################

library(dplyr)
library(ggplot2)
library(ggalluvial)

### IMPORT DATA
DATA.VIZ <- read.csv(df.name)

### ASSIGN VARIABLE NAMES
DATA.VIZ <- DATA.VIZ %>% rename(ID = all_of(id.var),
                                TIME = all_of(time.var))

####### CHANGE: TRANSFORM THE CATEGORICAL VARIABLE
# -------------- i) Name of the categorical variable after `DATA.VIZ$`
# -------------- ii) Level values (reverse categories - the levels will fill from the top down)
# -------------- iii) Label values can be used to rename the values

DATA.VIZ$cat.var <- factor(DATA.VIZ$variable.name,           # i) CHANGE VARIABLE NAME HERE
                           levels = c(3,2,1),                # ii) CHANGE LEVELS
                           labels = c("three","two","one"))  # iii) CHANGE LABELS

if(type_count == "numeric"){
  DVIZ <- DATA.VIZ %>% group_by(ID,TIME) %>% add_count(cat.var)
} else if(type_count == "percent"){
  DVIZ <- DATA.VIZ %>% group_by(ID,TIME) %>% add_count(cat.var)
  DVIZ <- DVIZ %>% group_by(TIME) %>% mutate(percent = (n/sum(n))*100)
}

##### ----------  VISUALIZATION
#################################################################################################

if(type_count == "numeric"){
plot <- ggplot(DVIZ, aes(x = TIME, stratum = cat.var, alluvium = ID,y = percent,
                         fill = cat.var, label = cat.var)) +
scale_x_discrete(expand = c(.1, .1)) +
geom_flow(alpha = 0.5, show.legend = F) +
geom_stratum(alpha = 0.5, show.legend = F) +
  geom_text(stat = "stratum") +
  theme_classic() +
  theme(axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        title = element_text(face = "bold", size = 15))
} else if(type_count == "percent"){
plot <- ggplot(DVIZ, aes(x = TIME, stratum = cat.var, alluvium = ID, y = percent,
                        fill = cat.var, label = cat.var)) +
  scale_x_discrete(expand = c(.1, .1)) +
  geom_flow(alpha = 0.5, show.legend = F) +
  geom_stratum(alpha = 0.5, show.legend = F) +
  geom_text(stat = "stratum") +
  theme_classic() +
  theme(axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"),
        title = element_text(face = "bold", size = 15))
}

##### ----------  THE PLOT ABOVE IS THE FOUNDATION OF THE ALLUVIAL
#################################################################################################
### BELOW, ARE SOME CHANGES AND MODIFICATIONS THAT CAN BE MADE TO THIS FOUNDATION

(plot <- plot +

# ----- CHANGE THE TITLES OF THE X AND Y AXES (`xlab` & `ylab`, respectively)
   xlab("Time") + ylab("") +
  
# ----- CHANGE THE TITLE OF THE PLOT
   labs(title = "Title of Alluvial Plot"))


##### ----------  OTHER CLOUD PLOT CHANGES TO MAKE
#################################################################################################
### Make the plot colour-blind friendly using the following package:

library(viridis)

plot + scale_fill_viridis(discrete = T)
