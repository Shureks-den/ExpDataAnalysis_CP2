library(ggplot2)


fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filename<-"summarySCC_PM25.rds"

if(!file.exists(filename)){
    download.file(fileurl, mode = "wb", "Data.zip")
    unzip("Data.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##find 'coal' scc 
TaskCollums<-grepl("coal|Coal", SCC$Short.Name)
TaskCollums<-as.character(SCC$SCC[TaskCollums])

##subsetting them
taskDATA<-subset(NEI, SCC == TaskCollums)


with(taskDATA, qplot(year,Emissions, col = year, alpha=1/2))+
    geom_smooth(method = "lm", lwd = 1, color = "red")+
    coord_cartesian(ylim = c(0,500))+
    theme_bw()+
    theme(legend.position="none")+
    ggtitle("Coal combustion-related sources emissions")

    
dev.copy(png, "plot4.png")
dev.off()