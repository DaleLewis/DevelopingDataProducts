---
title: "Nursing Home Finder Shiny Application Pitch"
author: "L. D. Schroyer - February 20, 2016"
highlighter: highlight.js
output: pdf_document
job: null
knit: slidify::knit2slides
mode: selfcontained
hitheme: tomorrow
subtitle: Developing Data Products Course Project
framework: io2012
widgets: []
---

## Background

The greying of America causes more and more people to have to struggle with finding a good nursing home to care for their loved ones. They need good information on which to make placement decisions.

- CMS has information on all the nursing homes in the US.
- Most of this information is tabular.
- It is not easily searched.
- It is not displayed in a user friendly format.
- The CMS databse is very large with approximately one hundred fields of information.
- Database from CMS does not include geographical coordinates.
- So much information is provided that it is confusing for the consumer.
- A more concise user friendly method is needed to enable bettwer placement decisions.


---  

## Covert The CMS Data to User Friendly Information

- Download the database from CMS.gov
- Download a database of Zip Code longitude and latitudes from www.gaslampmedia.com
- Subset the CMS data down to the key factors
  + Nursing Home Name and Address
  + Nursing Home Quality Rating 
- Join the two databases on zip code to add the geographical coordinates to form the Nursing Home Database
- Reduce the resulting data frame to only the important fields of information
  - Nursing home name and address 
  - Nursing home zip code with geographical coordinates (lng,lat)
  - Nursing home CMS quality rating

-------


## The User Friendly Nursing Home Finder

- This application uses the dataset generated above as the data source for the application
- Shiny inputs were created that take in the user's zip code and a search radius
- The application then searches the CMS database to find all homes within the search radius
  + Distance is calculated using the geosphere package distHaversine function
- The ten closet homes are then selected from these results
- These ten homes are populated into the tabbed output
  + The first tab displays a table output arranged by distance
  + The second tab displays a map with markers for each of the ten homes
  + The map also displays a red cirle at the user's zip code coordinates
- The zip code or the search radius can both be changed
- The user must press the submit button after any such change to see the updated (reactive) results

---

## Example Application Output Screen

![Table](C:/Users/Dale/Documents/Coursera/DevelopingDataProducts/DataProductsCourseProject/Nursing Home Finder Pitch/screen1lgdarker.PNG)

The full application can be found [here.](https://lewisdale.shinyapps.io/DataProductsCourseProject/)


