---
layout: post
title: US Literacy Data
excerpt: Mapping county literacy rates in the United States.
tags: libraries data cartodb literacy
image: /assets/img/posts/countylitmap_crop.png
project: true
---

[![image](/assets/img/posts/countylitmap_crop.png)](/countylitmap)

***click on the image for an interactive version***

I finally got around to mapping the literacy data from the [National Center for Education Statistics](https://nces.ed.gov/naal/estimates/). I did the mapping in [CartoDB](https://cartodb.com/), my go-to web utility for mapping. The literacy data was originally in Excel format (.xls), which is not as useful to me as a basic csv file. I used the following script to convert between the two formats.

		#!/bin/bash
		
		for f in *xls; do
			export name=$(basename "$f" .xls)
			ssconvert "$name".xls "$name".csv
		done

The tricky part was then connecting the figures for literacy estimates to the shapefiles for US counties (which were easy enough to find through a simple search, such as those available from the [Census Department](https://www.census.gov/geo/maps-data/data/cbf/cbf_counties.html).) Fortunately, CartoDB has the ability to merge datasets based on shared features, and although there would likely be way to use the county name to do the merge, a far easier method is to use the FIPS code, a unique county identification number included in both the shapefile and literacy data sets.

From there the mapping process is pretty direct and just uses CartoDB's inbuilt chloropleth option. I edited the default color ranges a bit to accentuate the areas with the highest (English) illiteracy rates. I include the qualifier because it's obvious that many of the areas most lacking in English prose literacy skills are on the border and therefore are also going to include a very high percentage of native Spanish speakers. I have no conclusions to draw about their Spanish literacy skills.
