# This script takes the individual data files for each season and aggregates them
# into a single file.
# The working directory when running this file should be the 'premier-league-data-analysis' folder.

# Then, it computes features that are used in the 'Match Outcome Prediction' section.
# I use a variety of features (wins, average goals per match, average on-target shots per match, average corner kicks per match, 
# average fouls per match, average yellow cards per match, average red cards per match) from the same season only.   
# Each feature is computed for the home and away teams of the match.
# For example, suppose team A is playing team B in season 2. I would compute all features for both teams using only previous matches in season 2.   
# This method means that I cannot obtain predictions for a team's 1st match of the season.  
# For a team's 2nd match of the season, I will obtain predictions using only data from that team's 1st match.
# For a team's 10th match, I obtain predictions using data from the 1st 9 matches.   
# So, each team's features are being updated every match.

# The output is 'premier_data.csv' which contains cleaned data with compute features.
# Warning: this script takes a while to run.

#####
# PREP.

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

#####
# CLEAN/STANDARDIZE DATA.

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

  # Change 'Date' to date format.
  # This is needed to compute features below.
  premier_data$Date = as.Date(premier_data$Date, 
                              '%d/%m/%y')
  
  # Make all text fields lowercase and remove extra whitespace.
  premier_data$HomeTeam = rm_white(tolower(premier_data$HomeTeam))
  premier_data$AwayTeam = rm_white(tolower(premier_data$AwayTeam))
  premier_data$Referee = rm_white(tolower(premier_data$Referee))

#####
# COMPUTE FEATURES.

  # Pre-allocate features.
  # Remember features are computed on the current season to date.
  # They are all NULL for now.
  premier_data$home_team_wins = rep(NA,                     # home team wins
                                    nrow(premier_data))
  premier_data$away_team_wins = rep(NA,                     # away team wins
                                    nrow(premier_data))
  premier_data$home_avg_goals = rep(NA,                     # home team average goals per match
                                    nrow(premier_data))
  premier_data$away_avg_goals = rep(NA,                     # away team average goals per match
                                    nrow(premier_data))
  premier_data$home_avg_sot = rep(NA,                       # home team average shots on target per match
                                  nrow(premier_data))
  premier_data$away_avg_sot = rep(NA,                       # away team average shots on target per match
                                  nrow(premier_data))
  premier_data$home_avg_corner = rep(NA,                    # home team average corner kicks per match
                                     nrow(premier_data))
  premier_data$away_avg_corner = rep(NA,                    # away team average corner kicks per match
                                     nrow(premier_data))
  premier_data$home_avg_foul = rep(NA,                      # home team average fouls per match
                                   nrow(premier_data))
  premier_data$away_avg_foul = rep(NA,                      # away team average fouls per match
                                   nrow(premier_data))
  premier_data$home_avg_yellow = rep(NA,                    # home team average yellow cards per match
                                     nrow(premier_data))
  premier_data$away_avg_yellow = rep(NA,                    # away team average yellow cards per match
                                     nrow(premier_data))
  premier_data$home_avg_red = rep(NA,                       # home team average red cards per match
                                  nrow(premier_data))
  premier_data$away_avg_red = rep(NA,                       # away team average red cards per match
                                  nrow(premier_data))

  # Add features.
  # This is a big, ugly, dense loop and hopefully the last one.
  for (i in 1:nrow(premier_data))
    {
    
      # Keep track of progress.
      print(i)
      
      # Create 'helper' data table.
      # For any match m, 'helper' contains all matches that satisfy all of the following conditions:
      # - in the same season as match m ('season_num')
      # - occurred before match m
      # - include at least 1 of the 2 teams playing in match m
      helper = premier_data[season_num == premier_data$season_num[i] &
                              Date < premier_data$Date[i] & 
                              ((HomeTeam %in% c(premier_data$HomeTeam[i], premier_data$AwayTeam[i])) | 
                                 (AwayTeam %in% c(premier_data$HomeTeam[i], premier_data$AwayTeam[i])))
                            ]
      
      # Compute features.
      premier_data$home_team_wins[i] = nrow(helper[HomeTeam == premier_data$HomeTeam[i] & FTR == 'h']) +
        nrow(helper[AwayTeam == premier_data$HomeTeam[i] & FTR == 'a'])
      premier_data$away_team_wins[i] = nrow(helper[HomeTeam == premier_data$AwayTeam[i] & FTR == 'h']) +
        nrow(helper[AwayTeam == premier_data$AwayTeam[i] & FTR == 'a'])
      premier_data$home_avg_goals[i] = (sum(helper[HomeTeam == premier_data$HomeTeam[i]]$FTHG) + sum(helper[AwayTeam == premier_data$HomeTeam[i]]$FTAG)) / 
        (nrow(helper[HomeTeam == premier_data$HomeTeam[i]]) + nrow(helper[AwayTeam == premier_data$HomeTeam[i]]))
      premier_data$away_avg_goals[i] = (sum(helper[HomeTeam == premier_data$AwayTeam[i]]$FTHG) + sum(helper[AwayTeam == premier_data$AwayTeam[i]]$FTAG)) / 
        (nrow(helper[HomeTeam == premier_data$AwayTeam[i]]) + nrow(helper[AwayTeam == premier_data$AwayTeam[i]]))
      premier_data$home_avg_sot[i] = (sum(helper[HomeTeam == premier_data$HomeTeam[i]]$HST) + sum(helper[AwayTeam == premier_data$HomeTeam[i]]$AST)) / 
        (nrow(helper[HomeTeam == premier_data$HomeTeam[i]]) + nrow(helper[AwayTeam == premier_data$HomeTeam[i]]))
      premier_data$away_avg_sot[i] = (sum(helper[HomeTeam == premier_data$AwayTeam[i]]$HST) + sum(helper[AwayTeam == premier_data$AwayTeam[i]]$AST)) / 
        (nrow(helper[HomeTeam == premier_data$AwayTeam[i]]) + nrow(helper[AwayTeam == premier_data$AwayTeam[i]]))
      premier_data$home_avg_corner[i] = (sum(helper[HomeTeam == premier_data$HomeTeam[i]]$HC) + sum(helper[AwayTeam == premier_data$HomeTeam[i]]$AC)) / 
        (nrow(helper[HomeTeam == premier_data$HomeTeam[i]]) + nrow(helper[AwayTeam == premier_data$HomeTeam[i]]))
      premier_data$away_avg_corner[i] = (sum(helper[HomeTeam == premier_data$AwayTeam[i]]$HC) + sum(helper[AwayTeam == premier_data$AwayTeam[i]]$AC)) / 
        (nrow(helper[HomeTeam == premier_data$AwayTeam[i]]) + nrow(helper[AwayTeam == premier_data$AwayTeam[i]]))
      premier_data$home_avg_foul[i] = (sum(helper[HomeTeam == premier_data$HomeTeam[i]]$HF) + sum(helper[AwayTeam == premier_data$HomeTeam[i]]$AF)) / 
        (nrow(helper[HomeTeam == premier_data$HomeTeam[i]]) + nrow(helper[AwayTeam == premier_data$HomeTeam[i]]))
      premier_data$away_avg_foul[i] = (sum(helper[HomeTeam == premier_data$AwayTeam[i]]$HF) + sum(helper[AwayTeam == premier_data$AwayTeam[i]]$AF)) / 
        (nrow(helper[HomeTeam == premier_data$AwayTeam[i]]) + nrow(helper[AwayTeam == premier_data$AwayTeam[i]]))
      premier_data$home_avg_yellow[i] = (sum(helper[HomeTeam == premier_data$HomeTeam[i]]$HY) + sum(helper[AwayTeam == premier_data$HomeTeam[i]]$AY)) / 
        (nrow(helper[HomeTeam == premier_data$HomeTeam[i]]) + nrow(helper[AwayTeam == premier_data$HomeTeam[i]]))
      premier_data$away_avg_yellow[i] = (sum(helper[HomeTeam == premier_data$AwayTeam[i]]$HY) + sum(helper[AwayTeam == premier_data$AwayTeam[i]]$AY)) / 
        (nrow(helper[HomeTeam == premier_data$AwayTeam[i]]) + nrow(helper[AwayTeam == premier_data$AwayTeam[i]]))
      premier_data$home_avg_red[i] = (sum(helper[HomeTeam == premier_data$HomeTeam[i]]$HY) + sum(helper[AwayTeam == premier_data$HomeTeam[i]]$AY)) / 
        (nrow(helper[HomeTeam == premier_data$HomeTeam[i]]) + nrow(helper[AwayTeam == premier_data$HomeTeam[i]]))
      premier_data$away_avg_red[i] = (sum(helper[HomeTeam == premier_data$AwayTeam[i]]$HY) + sum(helper[AwayTeam == premier_data$AwayTeam[i]]$AY)) / 
        (nrow(helper[HomeTeam == premier_data$AwayTeam[i]]) + nrow(helper[AwayTeam == premier_data$AwayTeam[i]]))
    
    }
  rm(helper, i)

# Export 'premier_data' as CSV.
write.csv(premier_data, 
          'premier_data.csv', 
          row.names = F)