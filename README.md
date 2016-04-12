#### Synopsis:
This project conducts analysis of Premier League data in R. The data spans from the 2003/2004 season to the 2015/2016 season. The analysis contains summary statistics, visualizations, machine learning, and really anything I found interesting. Results are presented in a 'Premier League Exploratory Analysis.pdf'.

#### Motivation:
I created this project to display an example of a complete analysis result.

#### Dataset Details:
The dataset contains data on the Premier League matches from the 2003/2004 season to the 2015/2016 season. Quantities recorded include half-time score, full-time (end of the game) score, various match statistics, and various betting odds on the game.
The data can be found at:
http://www.football-data.co.uk/englandm.php

I downloaded the relevant data files from this site and renamed each file to indicate the season it represented.

The 'data' folder contains 1 file for each season. It also contains 'notes.txt' which explains all variables in the data. The 'data_aggregation.R' file creates a single data file from the season files. Running 'data_aggregation_and_cleaning.R' yields 'premier_data.csv', which is used for the analysis.

The analysis is conducted in 'premier_data_exploratory_analysis.Rmd' and the final output is in 'Premier League Exploratory Analysis.pdf'.

#### License:
GNU General Public License
