library(data.table)
library(dplyr)
## using data.table and dplyr library

##using fread for quick reading of large dataset with "?" as the NA string
data<-fread("../household_power_consumption.txt",na.strings = '?')

## first create a new variable Date_R to extra the 2 days' of data
selection<-mutate(data,Date_R=as.Date(Date,format="%d/%m/%Y")) 

## filter data between 2007-02-01 & 2007-02-02
selection<-filter(selection,Date_R>=as.Date("2007-02-01")&Date_R<=as.Date("2007-02-02"))

## convert back to numeric
selection<-mutate(selection,
                  Global_active_power=as.numeric(Global_active_power),
                  Global_reactive_power=as.numeric(Global_reactive_power),
                  Voltage=as.numeric(Voltage),
                  Sub_metering_1=as.numeric(Sub_metering_1),
                  Sub_metering_2=as.numeric(Sub_metering_2),
                  Sub_metering_2=as.numeric(Sub_metering_2))

## combining date and time into POSIXct format
selection<-mutate(selection,Date_Time=as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))

## initiate the png device as output
png(file="plot4.png",width = 480, height = 480)

## set teh mfrow for 4 graphs in the same plot
par(mfrow=c(2,2))

## 1st graph
with(selection,plot(Date_Time,Global_active_power,type='n',
                    ylab = "Global Active Power", xlab="" ))
with(selection,lines(Date_Time,Global_active_power))

## 2nd graph
with(selection,plot(Date_Time,Voltage,type='n',
                    ylab = "Voltage", xlab="datetime" ))
with(selection,lines(Date_Time,Voltage))

## 3rd graph
with(selection,plot(Date_Time,Sub_metering_1,type='n',
                    ylab = "Energy sub metering", xlab="" ))

with(selection,lines(Date_Time,Sub_metering_1))
with(selection,lines(Date_Time,Sub_metering_2,col="red1"))
with(selection,lines(Date_Time,Sub_metering_3,col="blue1"))

legend("topright",legend = c("Sub_meter_1","Sub_meter_2","Sub_meter_3"),lty=1,col=c("black","red1","blue1"))

## 4th graph
with(selection,plot(Date_Time,Global_reactive_power,type='n',
                     xlab="datetime" ))
with(selection,lines(Date_Time,Global_reactive_power))

dev.off()