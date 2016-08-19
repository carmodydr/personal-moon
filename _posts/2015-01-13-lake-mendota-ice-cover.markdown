---
layout: post
title: Lake Mendota Ice Cover
excerpt: A brief foray into visualizing lake ice over the years.
tags: visualization python
---

Every year the Wisconsin State Climatology Office keeps track of the closing and opening dates of Lake Mendota in Madison, WI. These are the dates in the winter when the ice either completely covers the lake (in the case of closing) or finally opens up again to water (in the case of opening). These records go back all the way to 1852 and are given in a simple table format [here][mendota_ice]. Similar tables exist for [Lake Monona][monona_ice] and [Lake Wingra][wingra_ice]. Looking at this data, I wonder what kind of trends we might find.

Some of the basic stats are given on a [summary page][summary]. For instance, we can find out that the earliest closing date on record was November 23rd (in 1880) and the latest was January 20th (in 1932). The latest opening date was May 6th (in 1857) and the earliest was February 27th (in 1998). The average number of days that Mendota is frozen is 106, with the shortest being 47 days (1997-1998) and the longest being 161 (1880-1881). The summary table lists the shortest duration at 47 days (1997-1998), but this record was actually beat in the 2001-2002 season, when the duration was only 21 days.

That's all interesting, but what does it look like in graphical form? The Climatology Office provides a plot of the duration of Mendota's [closure over time][duration], which shows a decreasing trend. I want to take a different look, and instead look at the actual range of time that the lake was frozen. 

First we download the data and clean it up a bit. Once this is done, I've got to do some conversions with the dates to make it easier to use. I'm given the day and month of both the close and open dates, but I'd like to have these in numerical form. To do this, I can use the 'to_datetime' function in pandas to convert the open/close strings to the datetime format of pandas, then use the 'dayofyear' attribute to find the numerical day of the year.

	df = pd.read_csv('Mendota_Ice.csv')
	df_dates = df['Open'].to_datetime
	list = []
	for i in df_dates:
		list = list + [i.dayofyear] 
	df['OpenDay'] = list

Note that with this implementation the Open and Close dates are converted to a date within the current year. That means that when I change to 'dayofyear', for any years that are leap years, these numbers will be off by one. But I'm really not too concerned with that.

Now I want to shift these numbers so that the middle of winter will occur in the middle of the vertical axis. After doing so, and adding a few more niceties, I get the following plot.

![figure](/assets/img/posts/mendota-ice-cover.png)

[mendota_ice]: http://www.aos.wisc.edu/~sco/lakes/Mendota-ice.html
[monona_ice]: http://www.uwex.edu/sco/icemon.html
[wingra_ice]: http://www.uwex.edu/sco/icewing.html
[summary]: http://www.uwex.edu/sco/icesum.html
[duration]: http://www.aos.wisc.edu/~sco/lakes/mendota-dur.gif
