source("functions.R")

# Use awk to only read first line (column names) and selected dates
data <- read_data()

png('plot4.png')

par(mfrow=c(2,2))

# PLOT 1

plot(data$Global_active_power, type = "l", 
     ylab = "Global Active Power",
     xlab = "",
     axes = FALSE)
draw_axis_and_borders(data)

# PLOT 2

plot(data$Voltage, type = "l", 
     ylab = "Voltage",
     xlab = "datetime",
     axes = FALSE)
draw_axis_and_borders(data)

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
draw_axis_and_borders(data)

# PLOT 4

plot(data$Global_reactive_power, type = "l", 
     xlab = "datetime",
     ylab = "Global_reactive_power",
     axes = FALSE)
draw_axis_and_borders(data)

dev.off()