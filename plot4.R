## Getting full dataset
## missing values are ?
complete_data <- read.csv("./data/household_power_consumption.txt", 
                          header=T, 
                          na.strings="?",
                          sep=";",
                          check.names=F, 
                          stringsAsFactors=F, 
                          comment.char="", 
                          quote='\"',
                          colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

complete_data$Date <- as.Date(complete_data$Date, format="%d/%m/%Y")

## Filtering data
data <- subset(complete_data, subset=(Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2")))
remove(complete_data)

## Converting date and time to datetime
dateTime <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(dateTime)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()