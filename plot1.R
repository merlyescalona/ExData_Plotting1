url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipname<-"data/power.zip"
filename<-"data/power.txt"

# Making sure data folder exists
if(!dir.exists("data")){dir.create("data")}
# Downloading and unzipping the data
if(!file.exists(zipname)){
  download.file(url, destfile = zipname,method = "curl")
  unzip(zipfile = zipname, exdir = "data")
  file.rename(from = "data/household_power_consumption.txt", to=filename)
}

# reading the files
f<-read.table(filename,header = T, sep=";", colClasses = c(rep("character",2), rep("numeric",7)), na.strings = "?")
# Converting columns date and time to the corresponding data types
f$Date  <-as.Date(f$Date,format = "%d/%m/%Y")
f$Time<-strptime(f$Time,format = "%H:%M:%S",tz ="" )
# Creating the subset
s<-f[f$Date%in%c(as.Date("01/02/2007",format = "%d/%m/%Y" ),as.Date("02/02/2007",format = "%d/%m/%Y")),]
# Once the subset is created, memory is freed
rm(f) 
# Device opened
png(filename = "plot1.png")
# Histogram generated
hist(s$Global_active_power, col="red", xlab="Global active power (kilowatts)", main="Global active power")
# Device closed
dev.off()
# Freeing rest of the memory used
rm(list = ls())
