# This file conducts a 'raw' version of the English Premier League exploratory analysis.
# The more polished result is in 'premier_league_exploratory_analysis.Rmd'.
# This file will provide a better explanation of the code, but less analysis/interpretation.
# This report conducts exploratory analysis using Premier League match data from the 2003/2004 season to the 2015/2016 season.
# The data can be obtained from:
# http://www.football-data.co.uk/englandm.php

# Load packages.
library(data.table)
library(ggplot2)
library(reshape2)
library(cluster)
library(fpc)

# Import data.
premier_data = data.table(read.csv('premier_data.csv', 
                                   header = T, 
                                   stringsAsFactors = F))

# Change 'Date' to date format.
premier_data$Date = as.Date(premier_data$Date, 
                            '%d/%m/%y')

#####
# SUMMARY STATISTICS.
# Compute summary statistics about data set.

  # Show date range analyzed.
  min(premier_data$Date)
  max(premier_data$Date)
  
  # Number of seasons analyzed.
  length(unique(premier_data$season_num))
  
  # Number of matches analyzed.
  nrow(premier_data)
  
  # Number of teams analyzed.
  length(unique(premier_data$HomeTeam))
  
  # Number of Referees.
  length(unique(premier_data$Referee))
  
#####
# RELEGATION.
# The bottom 3 teams are relegated to a lower division at the end of each season.
# The English Premier League is the top English league, so teams cannot be 'promoted' up out of the league.
  
  # First, look at all teams in the data. Let's see how many seasons (out of 13) they appear in.
  
    # Count seasons played by each team.
    premier_data[, 
                 seasons_played := length(unique(season_num)), 
                 by = 'HomeTeam']
  
    # Create unique table with 1 row per team.
    seasons = premier_data[, .(HomeTeam, seasons_played)]
    seasons = unique(seasons)
    
    # Create table with number of teams and how many seasons they played.
    seasons_result = data.table(table(seasons$seasons_played))
    setnames(seasons_result, 
             names(seasons_result), 
             c('Seasons', 'Teams'))
    rm(seasons_result)
  
#####
# BEST OF THE BEST AND WORST OF THE BEST.
# This section shows a visualization of winning percentages over time for 6 teams.
# I only consider teams that have played in the EPL for each of the 13 seasons in the data set.
# Out of these teams, I look at the top and bottom 2 teams (defined by overall winning percentage).
    
    # Create 'winner' column in 'premier_data'. This helps with counting below.
    premier_data$winner = ifelse(premier_data$FTR == 'h', premier_data$HomeTeam, 
                                 ifelse(premier_data$FTR == 'a', premier_data$AwayTeam, 'draw'))
    
    # Create 'team__season_list' of all teams in all games specified by season. This helps with counting below.
    home_team_seasons = premier_data[, .(HomeTeam, season_num)]
    away_team_seasons = premier_data[, .(AwayTeam, season_num)]
    setnames(home_team_seasons, names(home_team_seasons), c('team', 'season_num'))
    setnames(away_team_seasons, names(away_team_seasons), c('team', 'season_num'))
    team_season_list = rbind(home_team_seasons, away_team_seasons)
    rm(home_team_seasons, away_team_seasons)

    # Restrict 'seasons' from above to only teams that played 13 seasons.
    seasons = seasons[seasons_played == 13]
    
    # Add 'total_wins','total_games', and a wins and games column for each season to 'seasons'. They're blank for now.
    seasons$total_win_percent = rep(NA, 
                                    nrow(seasons))
    seasons$s1_win_percent = rep(NA, 
                                 nrow(seasons))
    seasons$s2_win_percent = rep(NA, 
                                 nrow(seasons))
    seasons$s3_win_percent = rep(NA, 
                                 nrow(seasons))
    seasons$s4_win_percent = rep(NA, 
                                 nrow(seasons))
    seasons$s5_win_percent = rep(NA, 
                                 nrow(seasons))
    seasons$s6_win_percent = rep(NA, 
                                 nrow(seasons))
    seasons$s7_win_percent = rep(NA, 
                                 nrow(seasons))
    seasons$s8_win_percent = rep(NA, 
                                 nrow(seasons))
    seasons$s9_win_percent = rep(NA, 
                                 nrow(seasons))
    seasons$s10_win_percent = rep(NA, 
                                  nrow(seasons))
    seasons$s11_win_percent = rep(NA, 
                                  nrow(seasons))
    seasons$s12_win_percent = rep(NA, 
                                  nrow(seasons))
    seasons$s13_win_percent = rep(NA, 
                                  nrow(seasons))
    
    # Fill in all empty 'season' values.
    for (i in 1:nrow(seasons))
      {
        
        # Fill in win values.
        seasons$total_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i]]) / nrow(team_season_list[team == seasons$HomeTeam[i]])
        seasons$s1_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 1]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 1])
        seasons$s2_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 2]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 2])
        seasons$s3_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 3]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 3])
        seasons$s4_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 4]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 4])
        seasons$s5_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 5]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 5])
        seasons$s6_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 6]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 6])
        seasons$s7_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 7]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 7])
        seasons$s8_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 8]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 8])
        seasons$s9_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 9]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 9])
        seasons$s10_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 10]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 10])
        seasons$s11_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 11]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 11])
        seasons$s12_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 12]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 12])
        seasons$s13_win_percent[i] = 100 * nrow(premier_data[winner == seasons$HomeTeam[i] & season_num == 13]) / nrow(team_season_list[team == seasons$HomeTeam[i] & season_num == 13])
      
      }
    rm(i)
  
    # Order 'seasons' by 'total_win_percent'.
    seasons = seasons[order(total_win_percent, 
                            decreasing = T)]
    
    # Limit 'seasons' to top and bottom 2 teams.
    # Any more is hard to read on the plot.
    seasons = seasons[c(1:2, ((nrow(seasons) - 1):nrow(seasons))),]
    
    # Remove 'seasons_played' and 'total_win_percent' from 'seasons'. It's not needed.
    seasons$seasons_played = NULL
    seasons$total_win_percent = NULL
    
    # Rename 'seasons' columns for ease of plotting.
    setnames(seasons, 
             names(seasons),
             c('Team', '03-04', '04-05', '05-06', '06-07', '07-08', '08-09', '09-10', '10-11', '11-12', '12-13', '13-14', '14-15', '15-16'))
    
    # Rename 'seasons$Team' with proper team names.
    seasons$Team = c('Man. United', 'Chelsea', 'Everton', 'Aston Villa')
    
    # Reshape data for plotting.
    seasons_reshape = melt(seasons, 
                           id = 'Team')
    
    # Create plot.
    ggplot(data = seasons_reshape, 
           aes(x = variable, 
               y = value, 
               group = Team,
               color = Team)) +
      geom_line() +
      geom_point() +
      ylim(c(0, 100)) +
      ggtitle('Win Percentage of Selected Teams') +
      xlab('Season') +
      ylab('Win Percentage') +
      theme(axis.text.x = element_text(color = 'black', 
                                   size = 11, 
                                   angle = 45), 
      axis.text.y = element_text(color = 'black', 
                                   size = 13), 
      axis.title.x = element_text(size = 13),
      axis.title.y = element_text(size = 13,
                                  vjust = 1),
      axis.ticks = element_blank(),
      plot.title = element_text(face = 'bold', 
                                size = 13), 
      legend.title = element_text(size = 12),
      legend.text = element_text(size = 12))
    
#####
# CLUSTERING TEAMS BY PLAYING STYLE.
# In this section, I use K-means to cluster all 38 teams in the data set.
# I cluster on fouls committed and percentage of shots on target.
# I only use 2 variables to allow easy visualization.
    
  # Clean up previous section artifacts.
  rm(seasons, team_season_list, seasons_reshape)
  
  # Create data table for clustering analysis with 1 row per team.
  cluster_data = data.table(team = unique(premier_data$HomeTeam), 
                            home_games = rep(NA, length(unique(premier_data$HomeTeam))), 
                            away_games = rep(NA, length(unique(premier_data$HomeTeam))),
                            home_fouls = rep(NA, length(unique(premier_data$HomeTeam))),
                            away_fouls = rep(NA, length(unique(premier_data$HomeTeam))),
                            home_shots_on_target = rep(NA, length(unique(premier_data$HomeTeam))),
                            away_shots_on_target = rep(NA, length(unique(premier_data$HomeTeam))),
                            home_shots = rep(NA, length(unique(premier_data$HomeTeam))),
                            away_shots = rep(NA, length(unique(premier_data$HomeTeam))))

  # Fill in 'cluster_data'.
  for (i in 1:nrow(cluster_data))
    {
    
      cluster_data$home_games[i] = nrow(premier_data[HomeTeam == cluster_data$team[i]])
      cluster_data$away_games[i] = nrow(premier_data[AwayTeam == cluster_data$team[i]])
      cluster_data$home_fouls[i] = sum(premier_data[HomeTeam == cluster_data$team[i]]$HF) 
      cluster_data$away_fouls[i] = sum(premier_data[AwayTeam == cluster_data$team[i]]$AF)
      cluster_data$home_shots_on_target[i] = sum(premier_data[HomeTeam == cluster_data$team[i]]$HST)
      cluster_data$away_shots_on_target[i] = sum(premier_data[AwayTeam == cluster_data$team[i]]$AST)
      cluster_data$home_shots[i] = sum(premier_data[HomeTeam == cluster_data$team[i]]$HS)
      cluster_data$away_shots[i] = sum(premier_data[AwayTeam == cluster_data$team[i]]$AS)
  
  }
  
  # Compute total games, fouls, shots on target, and shots (home quantity + away quantity).
  cluster_data$games = cluster_data$home_games + cluster_data$away_games
  cluster_data$fouls = cluster_data$home_fouls + cluster_data$away_fouls
  cluster_data$shots_on_target = cluster_data$home_shots_on_target + cluster_data$away_shots_on_target
  cluster_data$shots = cluster_data$home_shots + cluster_data$away_shots
  
  # Compute average fouls per game and average shot percentage per game for each team.
  cluster_data$avg_fouls = cluster_data$fouls / cluster_data$games
  cluster_data$avg_shots_on_target_percent = 100 * cluster_data$shots_on_target / cluster_data$shots
  
  # Scale 'avg_fouls' and 'avg_shots_on_target_percent'. This should be done prior to clustering.
  # I do this separately so I can later access the mean and standard deviation of scaling.
  avg_fouls_scaled = scale(cluster_data$avg_fouls)
  avg_shots_on_target_percent_scaled = scale(cluster_data$avg_shots_on_target_percent)
  
  # Add 'avg_fouls_scaled' and 'avg_shots_on_target_percent_scaled' to 'cluster_data'.
  cluster_data$avg_fouls_scaled = avg_fouls_scaled
  cluster_data$avg_shots_on_target_percent_scaled = avg_shots_on_target_percent_scaled
  
  # View 'elbow' plot to help decide how many clusters there should be.
  # I actually think it should be four (high/low combinations of both variables).
  # But I'll do this exercise anyway.
  # This won't be in the RMarkdown document.
  
    # Create plot function.
    elbow_plot = function(data, cluster_num = 15, seed = 1){
               wss <- (nrow(data) - 1) * sum(apply(data, 2, var))
               for (i in 2:cluster_num){
                    set.seed(seed)
                    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
                plot(1:cluster_num, wss)}
  
    # View plot.
    elbow_plot(cluster_data[, .(avg_fouls_scaled, avg_shots_on_target_percent_scaled)])
  
  # Conduct K-means clustering with 4 clusters.
  cluster_kmeans = kmeans(cluster_data[, .(avg_fouls_scaled, avg_shots_on_target_percent_scaled)], 
                          centers = 4)
  
  # Convert cluster centers back into unscaled values.
  cluster_centers = data.table(cluster_kmeans$centers)
  cluster_centers$avg_fouls_scaled = (cluster_centers$avg_fouls_scaled * attr(avg_fouls_scaled, 'scaled:scale')) + 
                                      attr(avg_fouls_scaled, 'scaled:center')
  cluster_centers$avg_shots_on_target_percent_scaled = (cluster_centers$avg_shots_on_target_percent_scaled * attr(avg_shots_on_target_percent_scaled, 'scaled:scale')) + 
                                                        attr(avg_shots_on_target_percent_scaled, 'scaled:center')
  
  # Add clusters to 'cluster_data'.
  cluster_data$clusters = cluster_kmeans$cluster
  
  # Plot clusters.
 ggplot(data = cluster_data[, .(avg_fouls, avg_shots_on_target_percent, clusters)], 
         aes(x = avg_fouls, 
             y = avg_shots_on_target_percent, 
             group = as.character(clusters),
             color = as.character(clusters))) +
    geom_point(size = 2, 
               aes(shape = as.character(clusters))) +
    scale_color_manual(values = c('red', 'blue', 'yellow', 'black')) +
    theme(axis.text.x = element_text(color = 'black', 
                                     size = 13), 
          axis.text.y = element_text(color = 'black', 
                                     size = 13), 
          axis.title.x = element_text(face = 'bold', 
                                    size = 13),
          axis.title.y = element_text(face = 'bold',
                                      size = 13, 
                                      vjust = 1),
          axis.ticks = element_blank(),
          plot.title = element_text(face = 'bold', 
                                    size = 13)) +
    guides(colour = F, 
           shape = F) +
    ggtitle('Clustered EPL Teams') +
    xlab('Average Fouls Per Game') +
    ylab('Avg. Shots on Net % Per Game')
 
  
