library(data.table)
library(dplyr) 
## using data.table and dplyr library

##using fread for quick reading of large dataset with "?" as the NA string
data<-fread("../household_power_consumption.txt",na.strings = '?') 

## select just the global active power variable
selection<-select(data,Date,Global_active_power)

## use Date to select the 2 days of data
selection<-mutate(selection,Date=as.Date(Date,format="%d/%m/%Y"))
selection<-filter(selection,Date>=as.Date("2007-02-01")&Date<=as.Date("2007-02-02"))

#convert to numeric
selection<-mutate(selection,Global_active_power=as.numeric(Global_active_power))

## plot the histogram into the png file

png(file="plot1.png",width = 480, height = 480)
with(selection,hist(Global_active_power,
                    main="Global Active Power",
                    xlab = "Global Active Power (kilowatts)",
                    col="red1"))
dev.off()