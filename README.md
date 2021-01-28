# Visualizations
A repository of scripts that can be used to create some of the most popular data visualizations at PBCAR

## Rain Cloud Plots

![image](https://github.com/PBCAR/Visualizations/blob/main/Examples/raincloud.png)

## Heatmaps

The heatmap script utilizes 'pairwise complete' observations, meaning only individuals with missing data for the 2 variables being compared will be removed. User imput required at the beginning of the script only.


![image](https://github.com/PBCAR/Visualizations/blob/main/Examples/heatmap.png)


### Packages:

This script uses 'corrplot', 'Hmisc', 'ggplot2', and 'reshape2' packages

### Changes Required:

There are 3 changes required, with a further 3 option changes to the script total. These are outlined at the top of the script with examples:

i) Set your working directory - This is the file location of your data to be analyzed. To set your working directory, go to:

      Session > Set Working Directory > Choose Directory

ii) Input the name of your data file (this script is set up to only import .csv files)

iii) Select the names of variables within your data file to include in the heatmap

iv) Change the variable names (optional)

v) Reorder the variables (optional)

vi) Change the number of decimal points displayed (default is 2)

### The Script:

i) The heatmap itself

ii) 'heatmap.pvalues.csv' - A file of the p.values for each variable pair

iii) 'corr.pair.numbers.csv' - A file of the number of pairwise complete observations

