## CatSalut Cancer Economics

## Options 
options(scipen = 999)

## Read Excel Package
library(readxl)

## Set Wd
setwd("C:\\Users\\Miquel\\Desktop\\CRES\\CatSalut_Cancer\\Paper")

## Read data
data_lung <- read_excel("Facturació 2010 -2017.xlsx",sheet = "PULMÓ")
data_miel <- read_excel("Facturació 2010 -2017.xlsx",sheet = "MIELOMA")
data_crc <- read_excel("Facturació 2010 -2017.xlsx",sheet = "COLORECTAL")
## Convert CHR into Factors 
data_lung <- as.data.frame(unclass(data_lung))
data_miel <- as.data.frame(unclass(data_miel))
data_crc <- as.data.frame(unclass(data_crc))

## Cost / patient
data_lung$cp <- data_lung$cost/data_lung$n
data_miel$cp <- data_miel$cost/data_miel$n
data_crc$cp <- data_crc$cost/data_crc$n

## Libraries graphs
library(ggplot2)
library(ggsci)
library(plotly)


plot_lung <- ggplot(data_lung, aes(x=year, y = cost)) + theme_classic()
ggplotly(plot_lung + geom_point(alpha=.5) + geom_smooth() + geom_line(alpha=.4,aes(group=UP, color=UP)) )

plot_miel <- ggplot(data_miel, aes(x=year, y = cp)) + theme_classic()
plot_miel + geom_point(alpha=.5) + geom_smooth() + geom_line(alpha=.4,aes(group=UP, color=UP)) 

plot_crc <- ggplot(data_crc, aes(x=year, y = cp)) + theme_classic()
plot_crc + geom_point(alpha=.5) + geom_smooth() + geom_line(alpha=.4,aes(group=UP, color=UP)) 






## ICO inference
data_lung$ICO <- factor(ifelse(data_lung$UP %in% c("ICO Badalona",                          
                                            "ICO Girona"  , "ICO L'Hospitalet" ), "ICO", "Other"))

data_miel$ICO <- factor(ifelse(data_miel$UP %in% c("ICO Badalona",                          
                                                   "ICO Girona"  , "ICO L'Hospitalet" ), "ICO", "Other"))

data_crc$ICO <- factor(ifelse(data_crc$UP %in% c("ICO Badalona",                          
                                                   "ICO Girona"  , "ICO L'Hospitalet" ), "ICO", "Other"))


plot_2_lung <- ggplot(data_lung, aes(x=year, y = cp)) + theme_classic() + ylab("Cost per patient, Lung Cancer") 
plot_2_lung <- plot_2_lung + geom_point(alpha=.5) + geom_smooth(aes(group=ICO, color=ICO)) + geom_line(alpha=.4,aes(group=UP)) 

plot_2_miel <- ggplot(data_miel, aes(x=year, y = cp)) + theme_classic() + ylab("Cost per patient, Myeloma")
plot_2_miel <- plot_2_miel + geom_point(alpha=.5) + geom_smooth(aes(group=ICO, color=ICO)) + geom_line(alpha=.4,aes(group=UP)) 

plot_2_crc <- ggplot(data_crc, aes(x=year, y = cp)) + theme_classic() + ylab("Cost per patient, Colorectal Cancer") 
plot_2_crc <- plot_2_crc + geom_point(alpha=.5) + geom_smooth(aes(group=ICO, color=ICO)) + geom_line(alpha=.4,aes(group=UP)) 

library(gridExtra)
grid.arrange(plot_2_lung,plot_2_miel,plot_2_crc)
