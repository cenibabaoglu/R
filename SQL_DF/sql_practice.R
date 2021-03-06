# install sqldf package if already not installed
# install.packages('sqldf')
library('sqldf')
# please change the path in following two code-lines to where you have saved drives and timesheet files
# or create a sql_practice folder on C drive and move dervers and timesheet files there
drivers <- read.csv('c:\\sql_practice\\drivers.csv')
timesheet <- read.csv('c:\\sql_practice\\timesheet.csv')

# selecting all columns
sqldf('select * from drivers')
sqldf('select * from timesheet')

# selecting named columns
sqldf('select driverId, name from drivers')

# changing the column name in the output --> AS operator
sqldf('select driverId AS ID, name AS DRIVER_NAME from drivers')

# Using arithmetic operators (sum, mean, std)
# SUM                --> SUM(column_name)
sqldf('select sum(mileslogged) AS MILES, sum(hourslogged) AS hours from timesheet')
# AVERAGE (MEAN)     --> avg(column_name)
# STANDARD DEVIATION --> stdev(column_name)
sqldf('select sum(mileslogged) AS TOTAL_HOURS, avg(hourslogged) AS AVG_HOURS, stdev(hourslogged) AS ST_DEV_HOURS from timesheet')

# GROUP BY Operator
sqldf('select driverId AS DRIVER, sum(hourslogged) AS TOTAL_HOURS from timesheet GROUP BY driverId')

# JOIN two tables 
sqldf('SELECT d.driverId, d.name, t.total_hours, t.total_miles from drivers AS d 
      JOIN (SELECT driverId, sum(hourslogged) AS total_hours, sum(mileslogged) AS total_miles FROM timesheet GROUP BY driverId ) AS t 
      ON (d.driverId = t.driverId);')
