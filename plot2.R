plot2 <- function(){
  
  library(dplyr)
  fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  td=tempdir()
  tf = tempfile(tmpdir=td,fileext=".zip")
  download.file(fileURL,tf)
  list.files<-unzip(tf,list=TRUE)
  name1 = list.files$Name[1]
  unzip(tf, files = name1, exdir=td, overwrite = TRUE)
  path1 = file.path(td, name1)
  initial<-read.table(path1,nrows=100,na.strings = "?",sep=";",header = TRUE)
  names<-colnames(initial)
  classes <- sapply(initial,class)
  data<-read.table(path1, na.strings = "?",sep=";",header = FALSE,skip=66637,nrows=2880,stringsAsFactors = FALSE,colClasses=classes)
  colnames(data)<-names
  
  data<-transform(data, Date = as.character(Date))
  data<-mutate(data,DT=paste(data$Date,data$Time))
  data<-transform(data,DT=strptime(data$DT, format = "%d/%m/%Y %H:%M:%S"))
  
  ## Create the plot
  png(filename="plot2.png",width=480,height=480)
  plot(data$DT,data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
  dev.off()
  
}