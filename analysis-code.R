#install packages
install.packages("tidyverse")
install.packages("readxl")
library(readxl)
library(tidyverse)
library(dplyr)
library(ggplot2)

#load excel & convert to df
df <- read_excel("~/R/my-r-code/cablelabs/data/cert_qual.xlsx")
df <- as.data.frame(df)

#Remove comments, clean-up
df <- df[!is.na(df$CW),]

#create table for unique Product types
products <- as.data.frame(unique(df$`Product Type`))

#create US cable modem only analysis
cm_only <- c("CM", "CM (D3.1)")
df_cm <- df[df$`Product Type` %in% cm_only,]
df_cm <- df_cm[!is.na(df_cm$`CQ Date`),]

#2008 onwards analysis
f2008 <- seq(2008, 2018, 1)
df_cm_08 <- df_cm[df_cm$`CQ Date` %in% f2008, ] 
df_cm_08 %>% group_by (Manufacturer, `CQ Date`) 

#plotting
plot <- df_cm_08 %>% group_by (Manufacturer, `CQ Date`) %>% summarise(number = n())
plot %>% ggplot(aes(x = `CQ Date`, y = Manufacturer, color = number)) + geom_point() + ggtitle (label="Cable Modem Certs by Year & Manufacturer")
