library(ggplot2)


fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filename<-"summarySCC_PM25.rds"

if(!file.exists(filename)){
    download.file(fileurl, mode = "wb", "Data.zip")
    unzip("Data.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



baltimore<-subset(NEI, fips == "24510")
taskDATA<-subset(baltimore, type == "ON-ROAD")




with(taskDATA, qplot(year, Emissions, col = year, alpha=1/2))+
    coord_cartesian(ylim = c(0,5))+
    geom_smooth(method = "lm", color = "lightgreen")+
    theme_bw()+
    theme(legend.position="none")+
    ggtitle("Emissions from motor vehicle sources change in Baltimore City")

dev.copy(png, "plot5.png")
dev.off()