setwd("C:/Users/natal/OneDrive - The University of Western Ontario/PitchDeg/MCI/raw_data")

#installs and files
library(dplyr)
pilot_data <- read.csv("pilot_6.Table")

#creating itentifier for each semitone condition
pilot_data$semitones <- sub(".*_([0-9]+)$", "\\1", pilot_data$stimulus)
#removing the number from the end of the 
pilot_data$correct_response <- sub("_[0-9]+$", "", pilot_data$stimulus)
pilot_data$correct <- pilot_data$response == pilot_data$correct_response

correct <- mean(pilot_data$correct, na.rm = TRUE)

filtered_pilot_data <- pilot_data %>%
  filter(correct_response != "flat") %>%
  ungroup()

each_correct <- aggregate(correct ~ semitones, filtered_pilot_data, mean)


pilot_data$correct <- as.integer(pilot_data$correct)  # 1 / 0
pilot_data$semitones <- factor(pilot_data$semitones)
pilot_data$correct_response <- factor(pilot_data$correct_response)




pilot_data_summary <- pilot_data %>%
  group_by(semitones, correct_response) %>%
  summarise(
    accuracy = mean(correct, na.rm = TRUE),
    n = n()
  )

write.csv(each_correct, "accuracy_p6", row.names = FALSE)



