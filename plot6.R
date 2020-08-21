library(ggplot2)


fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filename<-"summarySCC_PM25.rds"

if(!file.exists(filename)){
    download.file(fileurl, mode = "wb", "Data.zip")
    unzip("Data.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



baltimore_LosAngeles <-subset(NEI, fips == "24510" | fips=="06037")
taskDATA<-subset(baltimore_LosAngeles, type == "ON-ROAD")

city<-c("06037" = "Lost Angeles", "24510" = "Baltimore")
g<-ggplot(taskDATA, aes(year, Emissions))

g+geom_point(aes(col = year), alpha=1/2)+
    facet_grid(fips~., labeller = as_labeller(city))+
    theme_bw()+
    theme(legend.position="none")+
    ggtitle("Emissions from motor vehicle sources change in Baltimore and Los Angeles")+
    coord_cartesian(ylim = c(0,50))+
    geom_smooth(method = "lm", color = "lightgreen")

    

dev.copy(png, "plot6.png")
dev.off()