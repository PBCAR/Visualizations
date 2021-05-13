#################################################################################################
##############################     HEATMAP CORRELATION TEMPLATE    ##############################
#################################################################################################

##### ----------  REQUIRED CHANGES BY USER:
#################################################################################################
### a) CHANGE file directory - GO TO: SESSION > SET WORKING DIRECTORY > CHOOSE DIRECTORY

setwd("~/Desktop/PBCAR")   ### CHANGE FILE DIRECTORY

### b) CHANGE THE NAME OF THE FILE (MUST BE A .csv file)

heatmap.name <- "DATA.csv"

### c) SELECT only the names of the variables you want to analyze

heatmap.items <- c("Variable_3","Variable_4","Variable_1","Variable_2","Variable_5")

### d) TITLE for the heatmap (leave as "" to omit a title)

hmap.title <- "Heatmap Title"

##### ----------  OPTIONAL CHANGES:
#################################################################################################

### e) RENAME variables (if desired):

item.rename <- c("Var3", "Var4","Var1","Var2","Var5")

### f) SELECT and REORDER the variables for the heatmap
# ----- In order from left-to-right for x axis & bottom-to-top for y axis

item.reorder <- c("Var1","Var2","Var3","Var4","Var5")

### g) DENOTES the number of decimal points the correlation matrix is rounded to

dec.points <- 2

### N.B. -- PAIRWISE COMPLETE OBSERVATIONS ARE USED:
# "Pairwise Complete" is the exclusion of individuals with missing data for
# the 2 variables which are being compared as opposed to the exclusion of
# individuals with any missing data for the variables compared in the heat map

#################################################################################################
##### STEP '0': DATA INPUT AND FORMATTING PRIOR TO CLEANING AND PROCESSING
#################################################################################################
library(ggplot2)
library(corrplot)
library(reshape2)
library(Hmisc)

# READS IN the .csv file & ASSIGNS the DF name
heatmap.df <- read.csv(heatmap.name)

# SELECTS only the variables to be analyzed
hmap.df <- heatmap.df[c(heatmap.items)]

# ASSIGNS the new names to the data frame
colnames(hmap.df) <- item.rename

# ASSIGNS the new item order to the new data frame
hmap.df <- hmap.df[item.reorder]
#################################################################################################
##### STEP 1: CREATION OF THE CORRELATION MATRIX
#################################################################################################

correlation.matrix <- rcorr(as.matrix(hmap.df), type="pearson")

corr.matrix <- round(as.matrix(correlation.matrix[["r"]]), dec.points)

### LONG FORMAT OF CORRELATION MATRIX
melted.corr.matrix <- melt(corr.matrix)

### Upper triangle of the correlation matrix
get.upper.tri <- function(corr.matrix){
  corr.matrix[lower.tri(corr.matrix)] <- NA
  return(corr.matrix)
}

### USE
upper.tri <- get.upper.tri(corr.matrix)

### MELT the correlation matrix
melted.corr.matrix <- melt(upper.tri, na.rm = TRUE)

#################################################################################################
##### STEP 2: CREATION OF THE GGPLOT VISUALIZATION OF THE CORRELATION MATRIX
#################################################################################################

heatmap.plot <- ggplot(data = melted.corr.matrix, aes(Var2, Var1, fill = value)) +
  geom_tile(color = "grey70") +
  scale_fill_gradient2(low = "midnightblue", high = "maroon4", mid = "grey90", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  scale_y_discrete(position = "right") +
  theme_minimal() +
  coord_fixed()

### ADD correlation coefficients to the heat map
(heatmap.plot <- heatmap.plot + 
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.justification = c(2, 0),
    legend.position = c(0.5, 0.7),
    legend.direction = "horizontal",
    legend.title = element_text(face = "bold",size = 12, vjust = 2),
    axis.text.x = element_text(face = "bold", angle = 30,size = 10),
    axis.text.y = element_text(face = "bold", size = 10),
    plot.title = element_text(size = 30, face = "bold", vjust = -2)) +
    labs(title = hmap.title) +
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5)))

#################################################################################################
##### STEP 3: PRINT P-VALUES & # OF PAIRED OBS
#################################################################################################

corr.p.values <- as.matrix(correlation.matrix[["P"]])

get.upper.tri <- function(corr.p.values){
  corr.p.values[lower.tri(corr.p.values)] <- NA
  return(corr.p.values)
}
upper.tri <- get.upper.tri(corr.p.values)
melted.corr.pval <- as.data.frame(melt(upper.tri, na.rm = TRUE))

(melted.corr.pval$pval <- ifelse(melted.corr.pval$value<0.001,"p < 0.001",
                                ifelse(melted.corr.pval$value>0.001 &
                                         melted.corr.pval$value<0.01,"p < 0.01",
                                       ifelse(melted.corr.pval$value>0.01 &
                                                melted.corr.pval$value<0.05,"p < 0.05","Not Sign."))))


### OPTIONAL WRITE A .csv file with p-values of significance
write.csv(melted.corr.pval,"heatmap.pvalues.csv")

### CHECK # OF OBS per correlation pair
#################################################################################################
(corr.pair.numbers <- correlation.matrix[["n"]])

### OPTIONAL WRITE A .csv file with the number of correlation pairs
write.csv(corr.pair.numbers, "corr.pair.numbers.csv")
