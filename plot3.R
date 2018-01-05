source("functions.R")

# Use awk to only read first line (column names) and selected dates
data <- read_data()

column_names <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colors <- c("black", "red", "blue")

png('plot3.png')

matplot(data[,..column_names],
        ylab = "Energy sub metering",
        type=c("l"), 
        col = colors,
        lty = 1,
        axes = FALSE)

legend(legend = column_names, x = "topright", col = colors, lty = 1)

box(which = "plot", lty = "solid")

draw_axis_and_borders(data)

dev.off()