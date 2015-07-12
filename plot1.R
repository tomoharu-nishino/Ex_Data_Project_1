# This script assumes that the source datafile is in the working directory.

library(dplyr) # load the dplyr library

# Read the raw data from the working directory, specifying the presence of header
# information, the use of ";" as data separators, and the use of "?" as missing
# values into the new dataframe "power_data".

power_data <- read.table("./household_power_consumption.txt",
                         header = TRUE, sep=";", na.strings="?")

# Subset the to only use the data from the two dates required.

small_data <- subset(power_data, Date=="1/2/2007" | Date=="2/2/2007")

# Use the paste function to concatenate the Date and Time columns, then apply
# apply the strptime() function to convert the information into a single
# date/time variable.  The resulting "date_time" variable is added to the
# dataframe using the mutate() function in dplyr.

small_data <- mutate(small_data,
        date_time = as.POSIXct(
        strptime(paste(small_data$Date, small_data$Time, sep=" "),
        "%d/%m/%Y %H:%M:%S")))

# Open PNG device, with appropriate demensions and file name.

png(file="~/git/plot1.png", width=480, height=480)

# Generate plot, and close PNG device
with(small_data, hist(Global_active_power, col="red",
        main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()