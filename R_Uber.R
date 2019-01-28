
/*Store teh data set in R*/
  
  
  uber_data<-read.csv("Uber Request Data.csv",stringsAsFactors = FALSE)
  /*Ignoring the NA values as its related to drop time of cancelled and no cars status*/
    /*Structure of dataset*/
Str(uber_data)
/* Formating the datefield removing / and replcacing it with - to make it uniform*/
  uber_data<-cbind(uber_data,Format_Request_time=uber_data<-gsub("/","-",uber_data$Request.timestamp))

/* Formating the datefield removing / and replcacing it with - to make it uniform*/
  uber_data<-cbind(uber_data,Format_Drop_time=uber_data<-gsub("/","-",uber_data$Drop.timestamp))

/*Converting string to date format*/
  uber_data<-cbind(uber_data,Drop_time_dt=as.POSIXlt(uber_data$Format_Drop_time, format = "%d-%m-%Y %H:%M"))
/*Converting string to date format*/
  uber_data<-cbind(uber_data,Request_time_dt=as.POSIXlt(uber_data$Format_Request_time, format = "%d-%m-%Y %H:%M"))

/*Extracting hours from date*/
 uber_data<-cbind(uber_data,Request_hr=format(uber_data$Request_time_dt, "%H"))
uber_data<-cbind(uber_data,Drop_hr=format(uber_data$Drop_time_dt, "%H"))

/*Filtering the data set by status/Basically further analysing the gap data*/
uber_data_no_cars<-filter(uber_data,Status=="No Cars Available")
uber_data_cancel<-filter(uber_data,Status=="Cancelled")




ggplot:-
  
  /*Shows teh overall picture of supply and demand*/
  ggplot(uber_data, aes(x=Status,color=Status)) + geom_histogram(stat = "count",fill=I("blue"))

/*Shows the data of no_cars_available status against hours*/
  ggplot(uber_data_no_cars, aes(Request_hr)) + geom_histogram(stat = "count")

/*Shows the data of no_cars_available status against pickup_points*/
  ggplot(uber_data_no_cars, aes(x=Pickup.point,color=Pickup.point)) + geom_histogram(stat = "count",fill=I("blue"))

/*Shows the cancelled status against hours*/
  ggplot(uber_data_cancel, aes(Request_hr)) + geom_histogram(stat = "count")

/*Shows the cancelled status against pickup_points*/
  ggplot(uber_data_cancel, aes(x=Pickup.point,color=Pickup.point)) + geom_histogram(stat = "count",fill=I("blue"))