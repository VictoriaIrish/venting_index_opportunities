#create a dataframe with the historical venting index data from Smithers from here (https://catalogue.data.gov.bc.ca/dataset/ventilation-index-reports/resource/9a5e4892-d46e-433c-aaa5-deca54cd7c12)
#first create vectors
Month <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
GFplus <- c(0.4, 3.3, 15.5, 21.7, 26.4, 26.9, 24.8, 21.9, 14.1, 7.6, 1.3, 0.3)
Gminus <- c(0.7, 5.9, 17.1, 23.7, 27.2, 27.1, 25.8, 23.4, 16.4, 10.5, 2.6, 0.6)
FplusFplus <- c(0.8, 5.7, 21.8, 25.2, 28.8, 28.7, 27.8, 26.6, 20.7, 12.3, 4.2, 1)
Fplusminus <- c(2.2, 10.7, 25.2, 27.7, 29.7, 29.1, 29.5, 28.7, 24.9, 18, 7.2, 1.6)

#then make dataframe
SMITHERS_HIST_VI <- data.frame(Month = Month, GFplus = GFplus, Gminus = Gminus, FplusFplus = FplusFplus, Fplusminus = Fplusminus)
#test with tibble
tibble::tibble(`G+`="gplus",
               `F/G+`="fgplus")

library(tidyverse)

#make long dataframe
SMITHERS_HIST_VI_LONG <- pivot_longer(
  SMITHERS_HIST_VI,
  cols = -Month,
  names_to = "Venting_Index",
  values_to = "Value"
)


# Define the correct order for the months
month_order <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

# Convert 'Month' to a factor with specified order
SMITHERS_HIST_VI_LONG$Month <- factor(SMITHERS_HIST_VI_LONG$Month, levels = month_order)

# Convert 'Venting_Index' to a factor with specified levels
SMITHERS_HIST_VI_LONG$Venting_Index <- factor(SMITHERS_HIST_VI_LONG$Venting_Index, 
                                              levels = c("GFplus", "Gminus", "FplusFplus", "Fplusminus"))


#plot
SMITHERS_HIST_VI_LONG %>%
  ggplot(aes(as.factor(Month), Value, fill = Venting_Index)) +
  geom_col(position = "dodge") +
  xlab("Month") +
  ylab("Number of days") +
  scale_fill_manual(
    values = c("GFplus" = "blue", "Gminus" = "red", "FplusFplus" = "green", "Fplusminus" = "purple"),
    labels = c("G/F+" = "GFplus", "G/-" = "Gminus", "F+/F+" = "FplusFplus", "F+/-" = "Fplusminus")
  )

