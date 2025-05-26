# Load necessary packages and data
library(dslabs)
library(dplyr)
library(ggplot2)
data("polls_us_election_2016")

# Filter and calculate spread
polls <- polls_us_election_2016 |>  
  filter(pollster %in% c("Rasmussen Reports/Pulse Opinion Research",
                         "The Times-Picayune/Lucid") &
           enddate >= "2016-10-15" &
           state == "U.S.") |> 
  mutate(spread = rawpoll_clinton / 100 - rawpoll_trump / 100)

# Boxplot with jittered points
ggplot(polls, aes(x = pollster, y = spread)) +
  geom_boxplot() +
  geom_jitter(width = 0.1, alpha = 0.5, color = "blue") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Spread (Clinton - Trump) by Pollster",
       x = "Pollster", y = "Spread")

# Compute standard deviation by pollster
sigma <- polls |> group_by(pollster) |> summarize(s = sd(spread))
sigma

# Summarize average, standard deviation, and poll count
res <- polls |> group_by(pollster) |> 
  summarize(avg = mean(spread), s = sd(spread), N = n()) 
res

# Calculate estimate difference and standard error
estimate <- res$avg[2] - res$avg[1]
se_hat <- sqrt(res$s[2]^2/res$N[2] + res$s[1]^2/res$N[1])

# Compute two-sided p-value for difference in means
z <- estimate / se_hat
p_value <- 2 * (1 - pnorm(abs(z)))
p_value

# Additional polling data filtering for 5+ polls
polls <- polls_us_election_2016 |> 
  filter(enddate >= "2016-10-15" &
           state == "U.S.") |>
  group_by(pollster) |>
  filter(n() >= 5) |> 
  mutate(spread = rawpoll_clinton / 100 - rawpoll_trump / 100) |>
  ungroup()

# Compute pollster-wise mean and standard deviation
var <- polls |> 
  group_by(pollster) |> 
  summarize(mean = mean(spread), sd = sd(spread))
var
