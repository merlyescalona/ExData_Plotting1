# Coursera's Exploratory Data Analysis 
# Peer Graded Assignment: Course Project 1
# Merly Escalona <escalona10@gmail.com>

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
f$datetime<-strptime(paste(f$Date,f$Time,sep=" - "),format = "%d/%m/%Y - %H:%M:%S" )
# Converting columns date and time to the corresponding data types
f$Date  <-as.Date(f$Date,format = "%d/%m/%Y")
f$Time<-strptime(f$Time,format = "%H:%M:%S",tz ="CET" )
# Creating the subset
s<-f[f$Date%in%c(as.Date("01/02/2007",format = "%d/%m/%Y" ),as.Date("02/02/2007",format = "%d/%m/%Y")),]
# Once the subset is created, memory is freed
rm(f)
# Device opened
png(filename = "plot2.png")
with(s,plot(datetime,Global_active_power, type="l",ylab="Global Active Power (kilowatts)"))
# Device closed
dev.off()
# Freeing rest of the memory used
rm(list = ls())
