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

## Adding to a plot more two graphs
with(data, {
  plot(Sub_metering_1~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime, col='Red')
  lines(Sub_metering_3~DateTime, col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()