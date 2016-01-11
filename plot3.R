library(data.table)
library(dplyr)
## using data.table and dplyr library

##using fread for quick reading of large dataset with "?" as the NA string
data<-fread("../household_power_consumption.txt",na.strings = '?')

## Select Date, Time and the 3 sub metering variables 
selection<-select(data,Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3)

## first create a new variable Date_R to extra the 2 days' of data
selection<-mutate(selection,Date_R=as.Date(Date,format="%d/%m/%Y")) 

## filter data between 2007-02-01 & 2007-02-02
selection<-filter(selection,Date_R>=as.Date("2007-02-01")&Date_R<=as.Date("2007-02-02"))

## convert back to numeric
selection<-mutate(selection,
                  Sub_metering_1=as.numeric(Sub_metering_1),
                  Sub_metering_2=as.numeric(Sub_metering_2),
                  Sub_metering_2=as.numeric(Sub_metering_2))

## combining date and time into POSIXct format
selection<-mutate(selection,Date_Time=as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))

## initiate the png device as output
png(file="plot3.png",width = 480, height = 480)
## start a plot without any points
with(selection,plot(Date_Time,Sub_metering_1,type='n',
                    ylab = "Energy sub metering", xlab="" ))

## connecting the points to format a line chart
with(selection,lines(Date_Time,Sub_metering_1))
with(selection,lines(Date_Time,Sub_metering_2,col="red1"))
with(selection,lines(Date_Time,Sub_metering_3,col="blue1"))

## put the legend
legend("topright",legend = c("Sub_meter_1","Sub_meter_2","Sub_meter_3"),lty=1,col=c("black","red1","blue1"))
dev.off()