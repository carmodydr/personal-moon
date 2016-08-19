---
layout: post
title: US Library Data
excerpt: Exploring relationships between libraries and literacy.
tags: libraries data cartodb
---

A while ago I was trying to teach myself some of the basics of data science and online visualization, and since I love reading and frequent libraries on a relatively regular basis, I thought that I would see what kind of data was out there on the public libraries of the US.

The first step, of course, is to find the data. A quick Google search for 'US public libraries' brings me to a few different sites: 

-   [www.publiclibraries.com](www.publiclibraries.com) - list of libraries by state, with name, address, and phone number
-   [Institute of Museum and Library Services](http://www.imls.gov) - surveys and data files stretching back to 1992 
-   [IMLS Data Analysis Tools](http://www.imls.gov/research/data_analysis_tools.aspx) - some data analysis tools - look up specific locations
-   [iMapLibraries](http://www.imaplibraries.org/) - map of library locations, a couple of derived maps

The IMLS data looks pretty solid. I download the data from 2012 and take a look. Luckily, this data set includes a geospatial file (geojson), which makes the creation of online maps a lot easier. Unfortunately this is only available for the 2012 data - previous years would require a lot more work.

This data set has extensive documentation, which makes it easier to understand the 100+ columns available. Some key ones are total library income, total library expenditures, total visits, and the population of the local service area (important for calculating per capita quantities). From there, it's important to organize it into a workable format and understand what kind of data we've got.The python library "pandas" is the go-to workhorse for dealing with datasets like these. 

CartoDB is a great tool for creating quick maps of geolocated quantities, which might help to identify some trends. At the very least it's nice to see everything laid out. For instance, here is a map of public libraries that is color-coded based on the annual number of library visits.

![image](/assets/img/posts/us-libraries-visits-choropleth.png)

This library dataset, though quite extensive, doesn't really give us a whole lot in terms of the effectiveness of various libraries. For that we have to seek out additional data. Literacy data seems like the stuff to get, and for that we turn to the National Center for Education Statistics, which has some estimates of adult literacy. There is both state data and county data. For just a quick and dirty look, let's try comparing state averages of various quantities to the state literacy data. County data would be more localized and probably more useful, but it would also take a good bit more time. Perhaps in the future.

There are tons of quantities we could look at. For now, I'm just going to look at a few: the total library income per capita, the number of print materials per capita, and the number of librarians per 10000 people.

![image](/assets/img/posts/us-libraries-lackVincmFIT.png)

There doesn't seem much of a correlation with the per capita library income, but the next two figures show a correlation with the amount of print material and the number of librarians.

![image](/assets/img/posts/us-libraries-lackVbkvolFIT.png)

![image](/assets/img/posts/us-libraries-lackVlibrariaFIT.png)

Have we learned anything from all this? That's hard to say. Obviously there are issues to consider in correlation/causation. Maybe a more literate population just expects more from their libraries, and so those libraries will have more books and a larger staff. This is a pretty quick look, and a lot more work would need to be done to draw solid conclusions. The fact that the above plots were made with averaged state data washes out information quite a bit. Performing this same sort of analysis county by county would be much more revealing.

