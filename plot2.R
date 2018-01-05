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

png('plot2.png')
plot(data$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     axes = FALSE)

box(which = "plot", lty = "solid")

# draw axis
axis(2)
axis(1, 
     at = xlabels_at,
     labels = xlabels)
dev.off()