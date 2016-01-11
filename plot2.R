library(data.table)
library(dplyr)
## using data.table and dplyr library

##using fread for quick reading of large dataset with "?" as the NA string
data<-fread("../household_power_consumption.txt",na.strings = '?')

## only need Date, Time and Global_active_power for plot2
selection<-select(data,Date,Time,Global_active_power)

## first create a new variable Date_R to extra the 2 days' of data
selection<-mutate(selection,Date_R=as.Date(Date,format="%d/%m/%Y")) 

## filter data between 2007-02-01 & 2007-02-02
selection<-filter(selection,Date_R>=as.Date("2007-02-01")&Date_R<=as.Date("2007-02-02"))

## convert back to numeric
selection<-mutate(selection,Global_active_power=as.numeric(Global_active_power))

## combining date and time into POSIXct format
selection<-mutate(selection,Date_Time=as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))

## initiate the png device as output
png(file="plot2.png",width = 480, height = 480)
## start a plot without any points
with(selection,plot(Date_Time,Global_active_power,type='n',
                    ylab = "Global Active Power (kilowatts)", xlab="" ))

## connecting the points to format a line chart
with(selection,lines(Date_Time,Global_active_power))

dev.off()