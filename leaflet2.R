


install.packages("leaflet")
install.packages("shiny")
library(shiny)
library(leaflet)
install.packages("htmltools")



#NEW, THIS ONE WORKS!!!

df <- read.csv('S:\\Office of Risk Management\\User Folders\\Darius Mehri\\Teracata Address\\EASEMENT_STREET_MATCH_geocoded.csv', header=T, na.strings=c("","NA"))
df$Building.Status <- as.character(df$Building.Status)
df$Building.Status[df$Building.Status == "Unknown"] <- "Demolished"
df$Building.Status[df$Building.Status == "Probably Demolished"] <- "Demolished"
df$AddressMatch <- gsub(' NY, NY', '', df$AddressMatch)

names(df)
#unique(df$Building.Status)
#df$AddressMatch

df$Building.Status <- as.factor(df$Building.Status)
pal <- colorFactor(c("orange", "blue"), df$Building.Status, ordered=FALSE)

#pal <- colorFactor(topo.colors(5), df$Building.Status)


map <- leaflet(df) %>%
  addProviderTiles("CartoDB.Positron") %>% setView(lng = -73.968285, lat = 40.785091, zoom = 12) %>%
  addCircleMarkers(lng = ~lng, 
                   lat = ~lat, 
                   radius = 5, 
                   label = df$AddressMatch,
                   labelOptions = labelOptions(noHide = F, direction = 'right'),
                   fillColor = ~pal(Building.Status),
                   stroke=FALSE,
                   
                   fillOpacity = 0.6) %>%
  addLegend("topleft", pal = pal, values = ~Building.Status, labels = "Community ", title = "Building Status") 

map
 
library(htmlwidgets)
saveWidget(map, file="map.html")


