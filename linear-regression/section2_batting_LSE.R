library(Lahman)
library(dplyr)
library(ggplot2)

# Create 2002 batting stats table
bat_02 <- Batting %>%
  filter(yearID == 2002) %>%
  mutate(pa = AB + BB,
         singles = (H - X2B - X3B - HR) / pa,
         bb = BB / pa) %>%
  filter(pa >= 100) %>%
  select(playerID, singles, bb)

# Create 1999–2001 average batting stats table
bat_99_01 <- Batting %>%
  filter(yearID %in% 1999:2001) %>%
  mutate(pa = AB + BB,
         singles = (H - X2B - X3B - HR) / pa,
         bb = BB / pa) %>%
  filter(pa >= 100) %>%
  group_by(playerID) %>%
  summarise(mean_singles = mean(singles, na.rm = TRUE),
            mean_bb = mean(bb, na.rm = TRUE)) %>%
  ungroup()

# Count how many players had mean_singles > 0.2
sum(bat_99_01$mean_singles > 0.2)

# Count how many players had mean_bb > 0.2
sum(bat_99_01$mean_bb > 0.2)

# Join 2002 data with 1999–2001 averages
combined <- inner_join(bat_02, bat_99_01, by = "playerID")

# Correlation: 2002 vs 1999–2001
cor(combined$singles, combined$mean_singles)
cor(combined$bb, combined$mean_bb)

# Scatterplots
ggplot(combined, aes(mean_singles, singles)) +
  geom_point() +
  geom_smooth(method = "lm") +
  ggtitle("2002 Singles vs. 1999–2001 Mean Singles")

ggplot(combined, aes(mean_bb, bb)) +
  geom_point() +
  geom_smooth(method = "lm") +
  ggtitle("2002 BB vs. 1999–2001 Mean BB")

# Linear model: singles
fit_singles <- lm(singles ~ mean_singles, data = combined)
summary(fit_singles)$coefficients

# Linear model: bb
fit_bb <- lm(bb ~ mean_bb, data = combined)
summary(fit_bb)$coefficients
