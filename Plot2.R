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
par()##restore plot window

##subset only baltimore
baltimore<-subset(NEIfix, fips == "24510")

with(baltimore, plot (year,Emissions, col = year, ylim = c(0,70), pch = 19,
                      title(main = " Total emissions from PM2.5 in the Baltimore City")))
model<-lm(Emissions ~ year, baltimore)
abline(model, lwd =3)
legend("topright", lwd = 2, legend = ("linear model of emissions in Baltimore"))


dev.copy(png, "plot2.png")
dev.off()