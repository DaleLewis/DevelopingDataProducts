
shinyServer(function(input, output) {
  testingrawzipcodedata <- read.csv(file="zip_codes_states.csv", header=TRUE, as.is = TRUE, stringsAsFactors = FALSE, sep=',', na.strings=c('NA','','#DIV/0!'))
  
  #
  data<-reactive({
    library(shiny)
    distance <- input$distance
    library(geosphere)
    testzip<-input$MyZipCode
    HomeData<-read.csv("HomeData.csv")
    testdistance<-vector(mode="numeric",1)
    testdistance<-as.numeric(distance)
    testzipcoor<-testingrawzipcodedata[testingrawzipcodedata$zip_code==as.numeric(testzip),c(3:2)]
    testdb=NULL
    testdb<-HomeData[0,]
    distance<-vector(mode="numeric",0)
    testdb<-cbind(testdb,distance)
    count=1
    for (i in 1:nrow(HomeData)){
      testcoor<-NULL  
      testcoor<-vector(mode="numeric",2)
      testcoor<-c(HomeData[i,"longitude"],HomeData[i,"latitude"])
      check<-distHaversine(testzipcoor,testcoor)
      check<-check/1609.344
      if (is.na(check)){check=500}
      if (check<=testdistance){ 
        testdb[count,]<-HomeData[i,]
        testdb[count,"distance"]<-check
        count=count+1}
    }
    require(plyr)
    testdb<-arrange(testdb,distance)
    finaldb<-head(testdb,10)
    finaldb1<-data.frame(Distance=round(as.numeric(finaldb$distance),digits=2),"Quality Rating"=finaldb$overall_rating,Name=finaldb$PROVNAME,Address=finaldb$ADDRESS,City=finaldb$CITY,State=finaldb$STATE,Zip=finaldb$ZIP)
    return(finaldb1)
})
  
markers<-reactive({library(shiny)
  distance1 <- input$distance
  library(geosphere)
  testzip1<-input$MyZipCode
  HomeData1<-read.csv("HomeData.csv")
  testdistance1<-vector(mode="numeric",1)
  testdistance1<-as.numeric(distance1)
  testzipcoor1<-testingrawzipcodedata[testingrawzipcodedata$zip_code==as.numeric(testzip1),c(3:2)]
  testdb1=NULL
  testdb1<-HomeData1[0,]
  distance1<-vector(mode="numeric",0)
  testdb1<-cbind(testdb1,distance1)
  count=1
  for (i in 1:nrow(HomeData1)){
    testcoor1<-NULL  
    testcoor1<-vector(mode="numeric",2)
    testcoor1<-c(HomeData1[i,"longitude"],HomeData1[i,"latitude"])
    check1<-distHaversine(testzipcoor1,testcoor1)
    check1<-check1/1609.344
    if (is.na(check1)){check1=500}
    if (check1<=testdistance1){ 
      testdb1[count,]<-HomeData[i,]
      testdb1[count,"distance1"]<-check1
      count=count+1}
  }
  require(plyr)
  testdb1<-arrange(testdb1,distance1)
  finaldba<-head(testdb1,10)
  markerdb<-data.frame(finaldba$longitude,finaldba$latitude,finaldba$PROVNAME)
  return(markerdb)})  
  
  output$map <- renderLeaflet({
    require(leaflet)
    distance <- input$distance
    MyZipCode <- input$MyZipCode
    temp<-markers()
    testzipcoor1<-testingrawzipcodedata[testingrawzipcodedata$zip_code==as.numeric(MyZipCode),c(3:2)]
    m <- leaflet() %>% addTiles()
    
    m <- m %>%
      setView(testzipcoor1$longitude, testzipcoor1$latitude,10) %>% # map location
      addCircleMarkers(testzipcoor1$longitude, testzipcoor1$latitude, popup = "Your Zip Code!",color=c("red")) %>% 
      addMarkers(temp[1,1],temp[1,2]+.001,popup = temp[1,3],clusterOptions = markerClusterOptions()) %>% 
      addMarkers(temp[2,1]+.001,temp[2,2],popup = temp[2,3],clusterOptions = markerClusterOptions()) %>% 
      addMarkers(temp[3,1],temp[3,2]+.002,popup = temp[3,3],clusterOptions = markerClusterOptions()) %>% 
      addMarkers(temp[4,1]+.002,temp[4,2],popup = temp[4,3],clusterOptions = markerClusterOptions()) %>% 
      addMarkers(temp[5,1],temp[5,2]+.003,popup = temp[5,3],clusterOptions = markerClusterOptions()) %>% 
      addMarkers(temp[6,1],temp[6,2]+.004,popup = temp[6,3],clusterOptions = markerClusterOptions()) %>% 
      addMarkers(temp[7,1]+.004,temp[7,2],popup = temp[7,3],clusterOptions = markerClusterOptions()) %>% 
      addMarkers(temp[8,1],temp[8,2]+.005,popup = temp[8,3],clusterOptions = markerClusterOptions()) %>% 
      addMarkers(temp[9,1]+.005,temp[9,2],popup = temp[9,3],clusterOptions = markerClusterOptions()) %>% 
      addMarkers(temp[10,1],temp[10,2],popup = temp[10,3],clusterOptions = markerClusterOptions())  
    m
    
  })
  
 
  # Generate an HTML table view of the data
  output$table <- renderTable({
    temp<-data()
    as.data.frame(temp)
  })
   
})
