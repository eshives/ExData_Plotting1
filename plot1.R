plot1 <- function() {
  
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
  data<-read.table(path1, colClasses = classes, na.strings = "?",sep=";",header = FALSE,skip=66637,nrows=2880)
  colnames(data)<-names

  
  ###Create the plot
  png(filename="plot1.png",width=480,height=480)
  hist(data$Global_active_power, col="red", breaks = 12, main="Global Active Power", xlab="Global Active Power (kilowatts)")
  dev.off()
  
}