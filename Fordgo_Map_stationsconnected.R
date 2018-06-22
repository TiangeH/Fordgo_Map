fordgobike<-read.csv(file = "C:/Users/Tiange/Desktop/fordgobike.csv", header = T,sep=',')
install.packages("sqldf")
library(sqldf)
popular_station<-sqldf('select start_station_name, end_station_name,
                       start_station_latitude,start_station_longitude,end_station_latitude, 
                       end_station_longitude,count(*) as count_t 
                       from fordgobike 
                       where start_station_name != end_station_name 
                       GROUP BY start_station_name, end_station_name 
                       order by count_t desc limit 10')

install.packages("maps")
library(maps)
install.packages("ggplot2")
library(ggmap)
library(ggplot2)
install.packages("geosphere")
library(geosphere) #this is for gcIntermediate function
library(maptools)

SanFran<-get_map(location = "San Francisco",source="google",maptype = "terrain",zoom = 10)


#till this step, I can see orange dots(start_station) and bluedots(endstation) on map
start_dots<-geom_point(aes(x = start_station_longitude, y = start_station_latitude), col = "orange", data = popular_station)
end_dots<-geom_point(aes(x = end_station_longitude, y = end_station_latitude), col = "blue", data = popular_station)
ggmap(SanFran)+start_dots+end_dots