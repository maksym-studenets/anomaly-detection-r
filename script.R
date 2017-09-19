fileName <- file.choose()

data <- read.csv(fileName, header = TRUE, dec = '.')
dates = as.Date(data$Date)
closeValues = data$Close

timeSeries <- ts(closeValues, start = c(1990, 1), end = c(2017, 9),
                 frequency = 52)
plot(timeSeries)

# STL model
stlModel <- stl(timeSeries, s.window = "period")
plot(stlModel)

dataframe <- cbind.data.frame(as.POSIXct(dates, format = "%Y-%m-%d"), closeValues)
anModel <- AnomalyDetectionTs(dataframe, max_anoms = 0.4, direction = 'both',
                               plot = TRUE, threshold = 'p95')
anModel$plot
