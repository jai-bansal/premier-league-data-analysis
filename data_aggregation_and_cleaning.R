# This script takes the individual data files for each season and aggregates them
# into a single file.

# Load packages.
library(data.table)

# Import data files.
d1 = data.table(read.csv('data/03-04.csv', 
                         header = T, 
                         stringsAsFactors = F))
d2 = data.table(read.csv('data/04-05.csv', 
                         header = T, 
                         stringsAsFactors = F))
d3 = data.table(read.csv('data/05-06.csv', 
                         header = T, 
                         stringsAsFactors = F))
d4 = data.table(read.csv('data/06-07.csv', 
                         header = T, 
                         stringsAsFactors = F))
d5 = data.table(read.csv('data/07-08.csv', 
                         header = T, 
                         stringsAsFactors = F))
d6 = data.table(read.csv('data/08-09.csv', 
                         header = T, 
                         stringsAsFactors = F))
d7 = data.table(read.csv('data/09-10.csv', 
                         header = T, 
                         stringsAsFactors = F))
d8 = data.table(read.csv('data/10-11.csv', 
                         header = T, 
                         stringsAsFactors = F))
d9 = data.table(read.csv('data/11-12.csv', 
                         header = T, 
                         stringsAsFactors = F))
d10 = data.table(read.csv('data/12-13.csv', 
                         header = T, 
                         stringsAsFactors = F))
d11 = data.table(read.csv('data/13-14.csv', 
                          header = T, 
                          stringsAsFactors = F))
d12 = data.table(read.csv('data/14-15.csv', 
                          header = T, 
                          stringsAsFactors = F))
d13 = data.table(read.csv('data/15-16.csv', 
                          header = T, 
                          stringsAsFactors = F))

# These data files have different numbers of variables and so cannot be joined in
# their current state. I choose a standard set of variables to pick from each file.
# I end up dropping most of the betting odds columns, not least because I am not
# very familiar with the details of these odds. The bettingI also drop columns that do not appear
# in every data file.
d1 = d1[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d2 = d2[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d3 = d3[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d4 = d4[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d5 = d5[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d6 = d6[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d7 = d7[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d8 = d8[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d9 = d9[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d10 = d10[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d11 = d11[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d12 = d12[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]
d13 = d13[, .(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee, HS, AS, HST, AST, HC, AC, HF, AF, HY, AY, HR, AR, B365H, B365D, B365A)]

# Add a 'season_num' variable to denote the numerical order of each season being considered.
d1$season_num = 1
d2$season_num = 2
d3$season_num = 3
d4$season_num = 4
d5$season_num = 5
d6$season_num = 6
d7$season_num = 7
d8$season_num = 8
d9$season_num = 9
d10$season_num = 10
d11$season_num = 11
d12$season_num = 12
d13$season_num = 13

# Join data files together into single file.
premier_data = rbind(d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13)

# Remove rows where "Date == ''". These rows are blank or NULL throughout.
premier_data = premier_data[Date != '']

# Make 'HomeTeam', 'AwayTeam', 'FTR', 'HTR', and 'Referee' lowercase for consistency.
premier_data$HomeTeam = tolower(premier_data$HomeTeam)
premier_data$AwayTeam = tolower(premier_data$AwayTeam)
premier_data$FTR = tolower(premier_data$FTR)
premier_data$HTR = tolower(premier_data$HTR)
premier_data$Referee = tolower(premier_data$Referee)

# Export 'premier_data' as CSV.
write.csv(premier_data, 
          'premier_data.csv', 
          row.names = F)