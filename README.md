# Visualizations
A repository of scripts that can be used to create some of the newest data visualizations techniques (and the most popular at PBCAR!). These scripts and accompanying documentation (such as this READ ME file) are intended for non-R users.

## Rain Cloud Plots

Rain cloud plots are cited as a transparent approach to data visualization. To learn more about the original creators of this technique, see: 

> Allen M, Poggiali D, Whitaker K et al. Raincloud plots: a multi-platform tool for robust data visualization [version 2; peer review: 2 approved]. Wellcome Open Res 2021, 4:63 (https://doi.org/10.12688/wellcomeopenres.15191.2)

The rain cloud plot script in this repository contains instructions for user input, and gives suggestions for changes that can be made to tweak the visualization.

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

## Alluvial Plots (Sankey Plots)

The alluvial plot script contains instructions for user input, and offers several customizations.

![image](https://github.com/PBCAR/Visualizations/blob/main/Examples/alluvials.png)


### Packages:

This script uses {dplyr}, {ggplot2}, and {ggalluvial} packages, along with the optional {viridis} package.

### Changes Required:

i) Set your working directory - This is the file location of your data to be analyzed. To set your working directory, go to:

      Session > Set Working Directory > Choose Directory

ii) Input the name of your data file (this script is set up to only import .csv files)

iii) Input the names of your ID variable and time variable

iv) Select the fill type ("numeric" or "percent")

v) Changing the categorical variable to a factor and change order, as alluvials are filled from the top down (Line 46)

### Other Possible Changes:

a) Changes can be made to both the axis titles and main plot title (Line 91)

b) Changes can be made to the colour palette by ensuring the {viridis} package is installed (Line 101)

## Corset Plots

![image](https://github.com/kbelisar/ggcorset/blob/main/visualizations/example_corset_plot_github_faceted.png)

Corset plots are used to show the heterogeneity of change in discrete repeat measures data at 2 time points. They can be made using the {ggcorset} package. To use this package, please refer to the downloading instructions and use instructions available [here](https://github.com/kbelisar/ggcorset).
