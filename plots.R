##Load only the relevant subset of the data
relData <- read.table("household_power_consumption.txt", 
			sep=";",
			skip=grep("1/2/2007", readLines("household_power_consumption.txt")),
			nrows=2880)

labels <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
	"Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

names(relData) <- labels



## Create the 1st Plot
createPlot1 <- function() {
	## create plot
	hist(relData$Global_active_power, 
		col="red",
		main = "Global Active Power",
		xlab = "Global Active Power (kilowatts)",
		ylab = "Frequency") 
}

png(file = "plot1.png") ## open png device; create 'plot1.png' in wd
createPlot1()
dev.off() ##close the png device

## Create the 2nd Plot
## Create a day of week column
x <- paste(relData$Date, relData$Time)
relData <- transform(relData, DateTime = strptime(x, "%d/%m/%Y %H:%M:%S"))

createPlot2 <- function() {
	## create plot
	with(relData, plot(DateTime, Global_active_power, 
		type="l",
		main="",
		xlab="",
		ylab="Global Active Power (kilowatts)"))
}

png(file="plot2.png") ## open png device; create 'plot2.png' in wd
createPlot2()
dev.off() ##close the png device


## Create the 3rd Plot
createPlot3 <- function() {
	plot(relData$DateTime, relData$Sub_metering_1, col="black",
		type="l", xlab = "", ylab = "Energy sub metering")
	lines(relData$Sub_metering_2, col="red")
	lines(relData$Sub_metering_3, col="blue")
	legend("topright", 
	legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), 
	col = c("black", "red", "blue"), 
	lwd = 1,
    cex = 0.5)
}
png(file="plot3.png") ## open png device; create 'plot3.png' in wd
createPlot3()
dev.off() ##close the png device

##Create the 4th Plot
createPlot4 <- function() {
	## create plot
	with(relData, plot(DateTime, Voltage, 
		type="l",
		main="",
		xlab="datetime",
		ylab="Voltage"))
}

createPlot5 <- function() {
	## create plot
	with(relData, plot(DateTime, Global_reactive_power, 
		type="l",
		main="",
		xlab="datetime",
		ylab="Global_reactive_power"))
}

png(file="plot4.png")
par(mfrow = c(2, 2))
createPlot2()
createPlot4()
createPlot3()
createPlot5()

dev.off()



