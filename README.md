# Visualizations
A repository of scripts that can be used to create some of the most popular data visualizations at PBCAR

## Rain Cloud Plots

The rain cloud plot script contains instructions for user input, and gives suggestions for changes that can be made to tweak the visualization.

![image](https://github.com/PBCAR/Visualizations/blob/main/Examples/raincloud.png)


### Packages:

This script uses {ggplot2} and {gghalves} packages

### Changes Required:

i) Set your working directory - This is the file location of your data to be analyzed. To set your working directory, go to:

      Session > Set Working Directory > Choose Directory

ii) Input the name of your data file (this script is set up to only import .csv files)

iii) Changing the categorical variable to a factor if represented numerically (Line 27)

iv) Input the name of the categorical and continuous variables to the ggplot (Line 37)

v) Changing the x and y axes titles (Line 57)

vi) Changing the title of the plot (Line 60)

### Other Possible Changes:

i) Set the opacity of various plot visuals using `alpha`
ii) Change the size of visuals or text using `size`
iii) Show/ suppress the legend (T/F) using `show.legend`

## Heatmaps

The heatmap script utilizes 'pairwise complete' observations, meaning only individuals with missing data for the 2 variables being compared will be removed. User input required at the beginning of the script only.

![image](https://github.com/PBCAR/Visualizations/blob/main/Examples/heatmap.png)


### Packages:

This script uses {corrplot}, {Hmisc}, {ggplot2}, and {reshape2} packages. Make sure these are installed prior to running the script. For each of the package not already installed, copy and paste the following in the console, replacing the relvant package name in quotes:

      install.packages("name of package")

### Changes Required:

There are 4 changes required, with a further 3 option changes to the script total. These are outlined at the top of the script with examples:

a) Set your working directory - This is the file location of your data to be analyzed. To set your working directory, go to:

      Session > Set Working Directory > Choose Directory

b) Input the name of your data file (this script is set up to only import .csv files)

c) Select the names of variables within your data file to include in the heatmap

d) Choose a name for the heatmap

e) Change the variable names (optional)

f) Reorder the variables (optional)

g) Change the number of decimal points displayed (default is 2)

### The Script:

i) The heatmap itself

ii) "heatmap.pvalues.csv" - A file of the p.values for each variable pair

iii) "corr.pair.numbers.csv" - A file of the number of pairwise complete observations

