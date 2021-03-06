## Getting full dataset
## missing values are ?
complete_data <- read.csv("./data/household_power_consumption.txt", 
                          header=T, 
                          na.strings="?",
                          sep=";",
                          colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

complete_data$Date <- as.Date(complete_data$Date, format="%d/%m/%Y")

## Filtering data
data <- subset(complete_data, subset=(Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2")))
remove(complete_data)

## Converting date and time to datetime
dateTime <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(dateTime)

## Type l for lines
plot(data$Global_active_power~data$DateTime,
     type="l",
     ylab="Global Active Power (kilowatts)", 
     xlab="")

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()