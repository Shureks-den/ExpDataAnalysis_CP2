library(ggplot2)


fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filename<-"summarySCC_PM25.rds"

if(!file.exists(filename)){
    download.file(fileurl, mode = "wb", "Data.zip")
    unzip("Data.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



##trying to fix extreme points
NEI1<-NEI$Emissions<6460

par()##restore plot window

baltimore<-subset(NEIfix, fips == "24510")

gp<-with(baltimore, ggplot(aes(year, Emissions), pch = type, col = type, facets = type~.))


gp<-ggplot(baltimore, aes(x=year, y=Emissions))
gp+
    ggtitle("Baltimore City by types")+
    geom_point(color= "palegreen4",alpha = 1/2, pch =19)+
    coord_cartesian(ylim = c(0,100))+
    facet_grid(.~type)+
    theme(axis.text.x = element_text(size =9))+
    geom_smooth(method = "lm", lwd = 1)

dev.copy(png, "plot3.png")
dev.off()