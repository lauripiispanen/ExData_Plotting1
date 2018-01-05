source("functions.R")

data <- read_data()

png('plot2.png')
plot(data$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     axes = FALSE)

box(which = "plot", lty = "solid")

draw_axis_and_borders(data)