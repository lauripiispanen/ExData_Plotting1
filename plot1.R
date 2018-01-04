library(data.table)

# Use awk to only read first line (column names) and selected dates
data <- fread("awk 'NR==1 || /^(1|2)\\/2\\/2007;/' household_power_consumption.txt")

png('plot1.png')
hist(data$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", 
     col = c("red"))
dev.off()