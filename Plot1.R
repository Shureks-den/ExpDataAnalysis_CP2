fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filename<-"summarySCC_PM25.rds"

if(!file.exists(filename)){
    download.file(fileurl, mode = "wb", "Data.zip")
    unzip("Data.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



boxplot(subset(NEI, year == 1999)$Emissions)


with(NEI, boxplot(Emissions ~ year, ylim = c(1, 1000)))

##trying to fix extreme points
NEI1<-NEI$Emissions<6460

##scale
##graphs

par(bg = "aliceblue", mfrow = c(2,1), mar=c(4,4,2,1))

with(NEIfix, boxplot(Emissions ~ year,ylim=c(0,0.3), col = "khaki1", range = 0))
abline(h=median(subset(NEIfix, year == 1999)$Emissions), lwd =3, col = "darkslateblue" )
legend("topright", lwd = 4, col=c("darkslateblue"), legend = c("median 1999"))
title(main = "Total emissions in US from all sources")

with(NEIfix, boxplot(Emissions ~ year, ylim = c(0, 0.010), col = "khaki1", range = 0))
##add median lines to see changes
abline(h=median(subset(NEIfix, year == 2002)$Emissions), lwd =3, col = "blue" )
abline(h=median(subset(NEIfix, year == 2005)$Emissions), lwd =3, col = "aquamarine4")
abline(h=median(subset(NEIfix, year == 2008)$Emissions), lwd =3, col = "indianred4")
legend("bottomleft", lwd = 4, col=c("blue", "aquamarine4","indianred4"), legend = c("median 2002", "median 2005", "median 2008"))

dev.copy(png, "plot1.png")
dev.off()
