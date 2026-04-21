setwd("C:/Users/natal/OneDrive - The University of Western Ontario/PitchDeg/MCI/raw_data")


library(dplyr)
library(ggplot2)

read_participant_accuracy <- function(participant_id) {
  filename <- paste0("accuracy_p", participant_id)
  
  read.csv(filename) %>%
    mutate(participant = factor(participant_id))
}

accuracy_all <- purrr::map_dfr(
  1:6,
  read_participant_accuracy
)

accuracy_all$Percent_Correct <- accuracy_all$correct*100
accuracy_all$semitones <- factor(accuracy_all$semitones)

plot <- ggplot(accuracy_all,
       aes(x = semitones,
           y = Percent_Correct,
           group = participant)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.5) +
  stat_summary(
    aes(group = 1),
    fun = mean,
    geom = "line",
    linewidth = 1.2,
    color = "black"
  ) +
  stat_summary(
    aes(group = 1),
    fun.data = mean_cl_normal,
    geom = "errorbar",
    width = 0.1
  ) +
  labs(
    x = "Pitch Distance (Semitones)",
    y = "Percent Correct"
  ) +

  theme_minimal()

ggsave("pilot_accuracy_plot.png", plot = plot, width = 6, height = 4, units = "in", dpi = 300)


anova <- aov(
  correct ~ semitones + Error(participant / semitones),
  data = accuracy_all
)

summary(anova)
