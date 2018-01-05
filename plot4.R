library(data.table)

# Use awk to only read first line (column names) and selected dates
data <- fread("awk 'NR==1 || /^(1|2)\\/2\\/2007;/' household_power_consumption.txt")
data$Weekday <- weekdays(as.POSIXlt(data$Date, format="%d/%m/%Y"), abbreviate = TRUE)

# Prepare x axis labels
# 1. merge dates so that only the first unique date in subsequent rows is selected
# 2. add the "next date" to label vectors to "close off" the x label
uniq_date_logical <- !duplicated(data$Date)
xlabels_at <- c(which(uniq_date_logical), nrow(data) + 1)
next_day <- weekdays(as.Date(as.POSIXlt(data$Date[nrow(data)], format="%d/%m/%Y")) + 1, abbreviate = TRUE)
xlabels <- c(data$Weekday[uniq_date_logical], next_day)

axis_and_borders <- function(p) {
  axis(2)
  axis(1, 
       at = xlabels_at,
       labels = xlabels)
  box(which = "plot", lty = "solid")
}

png('plot4.png')

par(mfrow=c(2,2))

# PLOT 1

plot(data$Global_active_power, type = "l", 
     ylab = "Global Active Power",
     xlab = "",
     axes = FALSE)
axis_and_borders()

# PLOT 2

plot(data$Voltage, type = "l", 
     ylab = "Voltage",
     xlab = "datetime",
     axes = FALSE)
axis_and_borders()

# PLOT 3

column_names <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colors <- c("black", "red", "blue")

matplot(data[,..column_names],
        ylab = "Energy sub metering",
        type=c("l"), 
        col = colors,
        lty = 1,
        axes = FALSE)

legend(legend = column_names, x = "topright", col = colors, lty = 1)
axis_and_borders()

# PLOT 4

plot(data$Global_reactive_power, type = "l", 
     xlab = "datetime",
     ylab = "Global_reactive_power",
     axes = FALSE)
axis_and_borders()

dev.off()