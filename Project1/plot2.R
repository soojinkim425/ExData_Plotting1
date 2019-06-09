# read data from file
data <- read.table(file = 'household_power_consumption.txt'
                   , header = TRUE
                   , sep = ';'
                   , na.strings = '?'
                   , colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# format dates
data$Date <- strptime(data$Date, "%d/%m/%Y")
format(data$Date, "%Y-%m-%d")

# take data from the dates 2007-02-01 and 2007-02-02
data_subset <- merge(data[data$Date == '2007-02-01', ], data[data$Date == '2007-02-02', ], all = TRUE)

# paste date and time
dateTime <- paste(data_subset$Date, data_subset$Time)
data_subset <- cbind(dateTime, data_subset)
data_subset$dateTime <- as.POSIXct(dateTime)

# create a plot
plot(data_subset$Global_active_power~data_subset$dateTime
     , type = 'l'
     , ylab = 'Global Active Power (kilowatts)'
     , xlab = '')

# save it to PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png, 'plot2.png', width = 480, height = 480)
dev.off()

