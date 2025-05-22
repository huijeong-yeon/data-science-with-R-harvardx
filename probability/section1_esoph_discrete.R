# Load tidyverse and inspect the esoph dataset
library(tidyverse)

head(esoph)

## the number of groups
nrow(esoph)

## Total number of cases and controls
all_cases <- sum(esoph$ncases)
all_controls <- sum(esoph$ncontrols)

## Probability that a subject in the highest alcohol consumption group is a cancer case
esoph %>%
  filter(alcgp == "120+") %>%
  summarize(ncases = sum(ncases), ncontrols = sum(ncontrols)) %>%
  mutate(p_case = ncases / (ncases + ncontrols)) %>%
  pull(p_case)


## Probability that a subject in the lowest alcohol consumption group is a cancer case
esoph %>%
  filter(alcgp == "0-39g/day") %>%
  summarize(ncases = sum(ncases), ncontrols = sum(ncontrols)) %>%
  mutate(p_case = ncases / (ncases + ncontrols)) %>%
  pull(p_case)

## Given that a subject is a case, probability they smoke 10g or more per day
esoph %>%
  filter(tobgp != "0-9g/day") %>%
  summarise(prob = sum(ncases) / all_cases) %>%
  pull(prob)

## Given that a subject is a control, probability they smoke 10g or more per day
esoph %>%
  filter(tobgp != "0-9g/day") %>%
  summarise(prob = sum(ncontrols) / all_controls) %>%
  pull(prob)

## Probability that a case is in the highest alcohol group
high_alc_cases <- esoph %>%
  filter(alcgp == "120+") %>%
  pull(ncases) %>%
  sum()

p_case_high_alc <- high_alc_cases / all_cases
p_case_high_alc

## Probability that a case is in the highest tobacco group
high_tob_cases <- esoph %>%
  filter(tobgp == "30+") %>%
  pull(ncases) %>%
  sum()

p_case_high_tob <- high_tob_cases / all_cases
p_case_high_tob

## Probability that a case is in both highest alcohol AND tobacco groups
both_high_cases <- esoph %>%
  filter(alcgp == "120+", tobgp == "30+") %>%
  pull(ncases) %>%
  sum()

p_case_high_both <- both_high_cases / all_cases
p_case_high_both

## Probability that a case is in highest alcohol OR tobacco group
p_case_either_highest <- p_case_high_alc + p_case_high_tob - p_case_high_both
p_case_either_highest

## Probability that a control is in the highest alcohol group
high_alc_controls <- esoph %>%
  filter(alcgp == "120+") %>%
  pull(ncontrols) %>%
  sum()

p_control_high_alc <- high_alc_controls / all_controls
p_control_high_alc

## How many times more likely are cases than controls to be in the highest alcohol group
p_case_high_alc / p_controls_high_alc

## Probability that a control is in the highest tobacco group
high_tob_controls <- esoph %>%
  filter(tobgp == "30+") %>%
  pull(ncontrols) %>%
  sum()

p_control_high_tob <- high_tob_controls / all_controls
p_control_high_tob

## Probability that a control is in both highest alcohol AND tobacco groups
both_high_controls <- esoph %>%
  filter(alcgp == "120+", tobgp == "30+") %>%
  pull(ncontrols) %>%
  sum()

p_control_high_both <- both_high_controls / all_controls
p_control_high_both

## Probability that a control is in highest alcohol OR tobacco group
p_control_either_highest <- p_controls_high_alc + p_control_high_tob - p_control_high_both
p_control_either_highest

## How many times more likely are cases than controls to be in the highest alcohol group or the highest tobacco group
p_case_either_highest / p_control_either_highest
