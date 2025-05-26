# Load required libraries
library(Lahman)
library(dplyr)

# Filter Teams data from 1961 to 2001 and compute per-game statistics
teams <- Teams %>%
  filter(yearID >= 1961 & yearID <= 2001) %>%
  mutate(
    R_per_game = R / G,         # Runs per game
    AB_per_game = AB / G,       # At-bats per game
    W_per_game = W / G,         # Win rate
    E_per_game = E / G,         # Errors per game
    X2B_per_game = X2B / G,     # Doubles per game
    X3B_per_game = X3B / G      # Triples per game
  )

# Correlation between runs per game and at-bats per game
cor(teams$R_per_game, teams$AB_per_game)

# Correlation between win rate and errors per game
cor(teams$W_per_game, teams$E_per_game)

# Correlation between doubles and triples per game
cor(teams$X2B_per_game, teams$X3B_per_game)
