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

# create a plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data_subset, {
  # first plot
  plot(Global_active_power~dateTime, type = 'l', 
       ylab = 'Global Active Power', xlab = '')
  # second plot
  plot(Voltage~dateTime, type = 'l', 
       ylab = 'Voltage', xlab = 'datetime')
  # third plot
  plot(data_subset$Sub_metering_1~data_subset$dateTime, type = 'l'
       , ylab = 'Energy sub meeting', xlab = '')
  lines(data_subset$Sub_metering_2~data_subset$dateTime, col = 'red')
  lines(data_subset$Sub_metering_3~data_subset$dateTime, col = 'blue')
  legend('topright', col=c('black', 'red', 'blue'), lty = 1, cex = 0.7, 
         bty='n', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
  # fourth plot
  plot(Global_reactive_power~dateTime, type = 'l',
       ylab = 'Global Rective Power', xlab = 'datetime')
  })

# save it to PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png,'plot4.png', width = 480, height = 480)
dev.off()
