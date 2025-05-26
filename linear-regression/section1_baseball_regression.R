# Load required libraries
install.packages("Lahman")
library(Lahman)
library(dplyr)
library(ggplot2)

graphics.off()

# Filter Teams data from 1961 to 2001 and compute relevant per-game statistics
teams <- Teams %>%
  filter(yearID >= 1961 & yearID <= 2001) %>%
  mutate(
    R_per_game = R / G,
    AB_per_game = AB / G,
    W_per_game = W / G,
    E_per_game = E / G,
    X2B_per_game = X2B / G,
    X3B_per_game = X3B / G
  )

# Runs vs At-Bats per game
teams %>%
  ggplot(aes(x = AB_per_game, y = R_per_game)) +
  geom_point(alpha = 0.5) +
  labs(
    title = "Runs vs At-Bats per Game",
    x = "At-Bats per Game",
    y = "Runs per Game"
  )

# As the number of at-bats per game increases, the number of runs per game tends to increase.

# Win Rate vs Errors per game
teams %>%
  ggplot(aes(x = E_per_game, y = W_per_game)) +
  geom_point(alpha = 0.5) +
  labs(
    title = "Win Rate vs Errors per Game",
    x = "Errors per Game",
    y = "Win Rate (Wins per Game)"
  )

# As the number of errors per game increases, the win rate tends to decrease.

# Triples vs Doubles per game
teams %>%
  ggplot(aes(x = X2B_per_game, y = X3B_per_game)) +
  geom_point(alpha = 0.5) +
  labs(
    title = "Triples vs Doubles per Game",
    x = "Doubles per Game",
    y = "Triples per Game"
  )

# There is no clear relationship between doubles per game and triples per game.
